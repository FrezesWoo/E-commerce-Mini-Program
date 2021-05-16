class Order::Sku < ApplicationRecord
  belongs_to :product_sku, class_name: 'Product::Sku'
  belongs_to :order

  after_create :store_sku_price

  attr_accessor :shipping

  validates :quantity, presence: true
  validate :validate_order_sku_product_sku_quantity, on: :create

  # We remove all the useless stuff from OMS
  def shipping
    (shipping_number || '').sub /APEX|CRE|ZJS|DTW|STO|HOAU|YUD|CNKJ|FedEx|YUNDA|DBL|SF|TTKDEX|ZTO|AIRFX|CYEXP|LBEX|YTO|LBEX|EMS|POST|CNMH|UPS|DDS|DHL|CCES|ANTO/, ''
  end

  class << self
    def last_hour_transactions(product_sku_id, source)
      eager_load(:order)
      .where(product_sku_id: product_sku_id).where('orders.source = ? AND orders.is_synced = ?', source, false)
    end
  end

  private

  include SkuQuantityCondition

  # validate order sku product sku quantity whether is upper to product sku quantity limit or incorrect quantity value
  def validate_order_sku_product_sku_quantity
    errors.add(:product_sku_id, "ID:#{product_sku_id} sku quantity error.") if quantity <= 0 || sku_quantity_condition(order.source)
  end

  def store_sku_price
    update(price: product_sku.price)
  end
end
