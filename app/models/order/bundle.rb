class Order::Bundle < ApplicationRecord
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id'
  belongs_to :product_bundle, class_name: '::Product::Bundle', foreign_key: 'product_bundle_id'
  belongs_to :order

  validate :validate_order_bundle_product_sku_quantity, :validate_bundle_price_condition, on: :create

  class << self
    def last_hour_transactions(product_sku_id, source)
      eager_load(:order)
          .where(product_sku_id: product_sku_id).where('orders.source = ? AND orders.is_synced = ?', source, false)
    end
  end

  private

  include SkuQuantityCondition

  # validate order bundle product sku quantity whether is upper to product sku quantity limit or incorrect quantity value
  def validate_order_bundle_product_sku_quantity
    product_bundle_sku = product_bundle.product_bundles_product_skus.where(product_sku_id: product_sku_id).first
    errors.add(:product_sku_id, "ID:#{product_sku_id} sku quantity error.") if quantity <= 0 || sku_quantity_condition(order.source) || product_bundle_sku.nil? || quantity > product_bundle_sku&.quantity
  end

  # validate order bundle & product bundle price condition
  def validate_bundle_price_condition
    errors.add(:product_bundle_id, "ID:#{product_bundle_id} bundle price condition error.") if product_bundle.condition == 'price' && product_bundle.price_condition > order.package_total_price
  end
end