class Coupon::ProductSku < ApplicationRecord
  belongs_to :coupon, class_name: '::Coupon', foreign_key: 'coupon_id', optional: true
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true
end
