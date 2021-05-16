class Coupon < ApplicationRecord
  has_many :coupons_product_skus, class_name: '::Coupon::ProductSku', foreign_key: 'coupon_id', dependent: :destroy
  belongs_to :lucky_draw_prize_code, class_name: '::LuckyDraw::Prize::Code', foreign_key: 'coupon_id', optional: true

  enum condition: { whole: 0, price: 1, product: 2 }
  enum status: { coupon_unvalid: 0, coupon_valid: 1 }

  before_create :generate_coupon_code

  accepts_nested_attributes_for :coupons_product_skus, allow_destroy: true

  ## static  Methods
  class << self
    def to_csv
      attributes = %w[id code condition price_condition coupon_product is_disposable expiry_start_date expiry_end_date created_at updated_at]
      "\uFEFF" + CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |coupon|
          csv << attributes.map { |attr|
            coupon.send(attr)
          }
        end
      end
    end
  end

  def generate_coupon_code
    code = generate_string(20)
    while self.class.where(code: code).count != 0
      code = generate_string(20)
    end

    self.code = code
  end

  def coupon_product
    return '' if !product_condition
    product = Product.find(product_condition)
    return '' if !product
    product.name
  end

  def validate_disposable(payment=false)
    order_coupons = Order::Coupon.eager_load(:order).where(coupon_id: self.id)
    return false if payment && order_coupons.where("orders.status IN (?)", [1, 2, 3]).count > 0
    return false if !payment && order_coupons.count != 0

    true
  end

  def validate_condition(product_skus)
    if self.condition == 'price'
      price = product_skus.sum { |item| (item['quantity'] || 1) * (Product::Sku.find(item['product_sku_id']).price || 0) }
      return true if price < self.price_condition
    end

    if self.condition == 'product'
      products = Array.new()
      product_skus.map { |sku| products.push(Product::Sku.find(sku['product_sku_id']).product_id) }
      return true if !products.include?self.product_condition
    end

    false
  end

  private

  def generate_string(len)
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...len).map { o[rand(o.length)] }.join
  end
end
