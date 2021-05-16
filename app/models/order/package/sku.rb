class Order::Package::Sku < ApplicationRecord
  belongs_to :order_package, class_name: '::Order::Package', foreign_key: 'order_package_id', inverse_of: :product_package_skus, optional: true
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true

  after_create :store_sku_price

  validate :validate_order_package_product_sku_quantity, :validate_order_package_product_sku_limit, on: :create
  validates_presence_of :order_package

  class << self
    def last_hour_transactions(product_sku_id, source)
      eager_load(order_package: [:order])
      .where(product_sku_id: product_sku_id).where('orders.source = ? AND orders.is_synced = ?', source, false)
    end

    def get_limit_date_quantity(payment = false, product_sku_id, customer_id, source, limit_start_date, limit_end_date)
      order_customer_condition = source == 'wechat' ? "orders.customer_id" : "orders.douyin_customer_id"
      platform = source == "wechat" ? 0 : 1
      sql = eager_load(order_package: [:order]).where(product_sku_id: product_sku_id)
                .where("#{order_customer_condition} = ? AND orders.source = ?", customer_id, platform)
                .where("order_package_skus.created_at between '#{limit_start_date}' and '#{limit_end_date}'")
      sql = sql.where("orders.status IN (?)", [1, 2, 3]) if payment
      sql.sum('order_packages.quantity')
    end
  end

  private

  include SkuQuantityCondition

  # validate order package product sku quantity whether is upper to product sku quantity limit or incorrect quantity value
  def validate_order_package_product_sku_quantity
    errors.add(:product_sku_id, "ID:#{product_sku_id} sku quantity error.") if quantity <= 0 || sku_quantity_condition(order_package.order.source)
  end

  # validate product sku limit rule
  def validate_order_package_product_sku_limit
    order_customer_id = order_package.order.source == 'wechat' ? order_package.order.customer_id : order_package.order.douyin_customer_id
    errors.add(:product_sku_limit, "ID:#{product_sku_id} sku limit error.") if product_sku.limited_product && !product_sku.validate_limit_rule(false, order_customer_id, order_package.order.source, order_package.quantity*quantity)
  end

  def store_sku_price
    update(price: product_sku.price)
  end
end
