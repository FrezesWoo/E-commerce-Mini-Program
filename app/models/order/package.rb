class Order::Package < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product_package, class_name: '::Product::Package', foreign_key: 'product_package_id', optional: true
  has_many :product_package_skus, class_name: '::Order::Package::Sku', foreign_key: 'order_package_id', inverse_of: :order_package, dependent: :destroy

  accepts_nested_attributes_for :product_package_skus, allow_destroy: true

  validate :validate_order_package_quantity, :validate_order_package_sample, on: :create

  def total_price
    product_package_skus.sum { |sku| (quantity*sku.quantity || quantity*1) * (sku.price  || 0) }
  end

  def package_total_price
    product_package_skus.sum { |sku| (quantity*sku.quantity || quantity*1) * (sku.product_sku.price  || 0) }
  end

  def total_shipping_price
    product_package_skus.sum { |sku| (quantity*sku.quantity || quantity*1) * (sku.product_sku.shipping_price || 0) }
  end

  private

  # validate order package quantity whether is correct quantity value
  def validate_order_package_quantity
    errors.add(:quantity, "Order package quantity error.") if quantity <= 0
  end

  # validate trial order sample package rule
  def validate_order_package_sample
    order_customer_id = order.source == 'wechat' ? order.customer_id : order.douyin_customer_id
    if (order.need_trial && !product_package.product_category.is_sample) || (order.need_trial && product_package.product_category.is_sample && !::Product::Package.validate_sample(false, product_package_id, order_customer_id, order.source))
      errors.add(:product_package_id, "Order sample package rule error.")
    end
  end
end
