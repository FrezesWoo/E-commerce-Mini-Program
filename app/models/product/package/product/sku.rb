class Product::Package::Product::Sku < ApplicationRecord
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true
  belongs_to :product_package_product, class_name: '::Product::Package::Product', foreign_key: 'product_package_product_id', optional: true
end
