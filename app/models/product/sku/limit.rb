class Product::Sku::Limit < ApplicationRecord
  belongs_to :product_sku, :class_name => '::Product::Sku', foreign_key: 'product_sku_id', optional: true
  belongs_to :created_by, :class_name => :User, optional: true
  belongs_to :updated_by, :class_name => :User, optional: true
end
