class Product::BundlesGiftSku < ApplicationRecord
  belongs_to :product_bundle, class_name: '::Product::Bundle', foreign_key: 'product_bundle_id', optional: true
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true
end