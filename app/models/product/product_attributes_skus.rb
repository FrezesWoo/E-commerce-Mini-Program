class Product::ProductAttributesSkus < ApplicationRecord
  belongs_to :product_product_attribute, class_name: '::Product::ProductAttribute', optional: true
  belongs_to :product_sku, class_name: '::Product::Sku', foreign_key: 'product_sku_id', optional: true

  attr_accessor :product_attribute_category_id
end
