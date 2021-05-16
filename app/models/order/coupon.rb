class Order::Coupon < ApplicationRecord
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id'
  belongs_to :coupon, class_name: '::Coupon', foreign_key: 'coupon_id'
  belongs_to :order

  validate :validate_order_coupon_product_sku_quantity, on: :create

  class << self
    def last_hour_transactions(product_sku_id, source)
      eager_load(:order)
          .where(product_sku_id: product_sku_id).where('orders.source = ? AND orders.is_synced = ?', source, false)
    end
  end

  private

  # validate order bundle product sku quantity whether is upper to product sku quantity limit
  def validate_order_coupon_product_sku_quantity
    errors.add(:product_sku_id, "ID:#{product_sku_id} sku quantity error.") if quantity <= 0 || !product_sku&.available_quantity || quantity > product_sku&.available_quantity
  end
end
