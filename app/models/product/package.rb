class Product::Package < ApplicationRecord
  has_many :attachments, -> { order(ordering: :asc) }, as: :attachable, dependent: :destroy
  has_many :product_package_products, class_name: '::Product::Package::Product', foreign_key: 'product_package_id', dependent: :destroy
  has_many :blocks, class_name: 'Product::Package::Block', foreign_key: 'product_package_id', dependent: :destroy
  has_many :package_subscriptions, class_name: 'PackageSubscription', foreign_key: 'product_package_id'

  belongs_to :page, class_name: '::Page', foreign_key: 'page_id', optional: true
  belongs_to :product_category, class_name: '::Product::Category', foreign_key: 'product_category_id'
  has_many :trails, class_name: 'Product::Package::Trail', foreign_key: 'product_package_id', dependent: :destroy

  translates :name, :description, :note, :composition

  has_attached_file :image, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                            storage: :azure,
                            styles: {
                                thumb: "300x300#"
                            }

  validates_attachment :image, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }

  accepts_nested_attributes_for :attachments, :product_package_products, :blocks, :trails, allow_destroy: true

  def total_price
    price = 0
    product_package_products.each do |prod|
      price += prod.skus.sum { |sku| sku.product_sku.price }
    end
    price
  end

  def composed_name
    name.to_s + sku.to_s
  end

  def self.validate_sample(payment = false, package_id, customer_id, platform)
    package = ::Product::Package.find(package_id)
    return false if (!package || !package.product_category.is_sample)
    return true if package.trails.count === 0
    # validate now time
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    return true if !now.between?(package.trails.first.trial_start_date.to_s, package.trails.first.trial_end_date.to_s)
    # validate trail rule
    order_customer_condition = platform == 'wechat' ? "orders.customer_id" : "orders.douyin_customer_id"
    order_package = Order::Package.eager_load(:order).where(product_package_id: package_id)
                        .where("#{order_customer_condition} = ? AND orders.need_trial = ?", customer_id, true)
                        .where("order_packages.created_at between '#{package.trails.first.trial_start_date.to_s}' and '#{package.trails.first.trial_end_date.to_s}'")
    return false if payment && order_package.where("orders.status IN (?)", [1, 2, 3]).count > 0
    return false if !payment && order_package.count > 0

    true
  end

  def need_subscribe
    product_package_products.each do |product|
      return true if product.validate_subscribe_condition
    end

    false
  end
end
