class Product::Sku < ApplicationRecord
  include SetCurrentUser

  has_many :product_product_attributes_skus, class_name: '::Product::ProductAttributesSkus', foreign_key: 'product_sku_id'
  has_many :attachments, -> { order(weight: :asc) }, as: :attachable, dependent: :destroy
  has_many :product_sku_limits, class_name: '::Product::Sku::Limit', foreign_key: 'product_sku_id', dependent: :destroy

  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User

  belongs_to :product

  translates :currency, :description, :composition, :name #  :price, :shipping_price,

  has_many :product_bundles_product_skus, class_name: '::Product::BundlesProductSku', foreign_key: 'product_sku_id'

  enum currency: { rmb: 0 }

  has_attached_file :image, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                            storage: :azure,
                            styles: {
                                thumb: "300x300#"
                            }

  validates_attachment :image, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }


  attr_accessor :available_quantity, :available_douyin_quantity, :quantity_bought

  after_save :updated_product_sku_limits

  validates :price, presence: true

  accepts_nested_attributes_for :product_product_attributes_skus, :attachments, :product_sku_limits, allow_destroy: true

  def self.mass_update(params, source)
    params.each do |sku|
      product_sku = Product::Sku.where(sku: sku['sku']).first
      next if product_sku.nil?
      source ? product_sku.quantity = sku['quantity'] : product_sku.douyin_quantity = sku['quantity']
      product_sku.save
    end
  end

  def available_quantity
    qt = quantity || 0
    Order::Sku.last_hour_transactions(id, 0).each do |order_sku|
      qt -= order_sku.quantity
    end
    Order::Package::Sku.last_hour_transactions(id, 0).each do |order_sku|
      qt -= order_sku.order_package.quantity * order_sku.quantity
    end
    Order::Bundle.last_hour_transactions(id, 0).each do |order_sku|
      qt -= order_sku.quantity
    end
    Order::Coupon.last_hour_transactions(id, 0).each do |order_sku|
      qt -= order_sku.quantity
    end
    qt
  end

  def available_douyin_quantity
    qt = douyin_quantity || 0
    Order::Sku.last_hour_transactions(id, 1).each do |order_sku|
      qt -= order_sku.quantity
    end
    Order::Package::Sku.last_hour_transactions(id, 1).each do |order_sku|
      qt -= order_sku.order_package.quantity * order_sku.quantity
    end
    Order::Bundle.last_hour_transactions(id, 1).each do |order_sku|
      qt -= order_sku.quantity
    end
    Order::Coupon.last_hour_transactions(id, 1).each do |order_sku|
      qt -= order_sku.quantity
    end
    qt
  end

  def quantity_bought
    Order::Sku.where(product_sku_id: id).sum(&:quantity)
  end

  def composed_name
    product.name + '' + sku
  end

  def updated_product_sku_limits
    product_sku_limits.destroy_all() if !limited_product
  end

  def validate_limit_rule(payment = false, customer_id, source, quantity)
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    product_sku_limits.each do |product_sku_limit|
      next if !now.between?(product_sku_limit.limit_start_date.to_s, product_sku_limit.limit_end_date.to_s)
      limit_quantity = ::Order::Package::Sku.get_limit_date_quantity(payment, id, customer_id, source, product_sku_limit.limit_start_date.to_s, product_sku_limit.limit_end_date.to_s)
      return false if limit_quantity + quantity > product_sku_limit.quantity
    end

    true
  end

  private

  def generate_string
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...20).map { o[rand(o.length)] }.join
  end
end
