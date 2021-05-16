class Product::BundlesProductSku < ApplicationRecord
  belongs_to :product_bundle, class_name: '::Product::Bundle', foreign_key: 'product_bundle_id', optional: true
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true

  def validate_available_quantity(source)
    source == "wechat" ? product_sku&.available_quantity > 0 : product_sku&.available_douyin_quantity > 0
  end
end
