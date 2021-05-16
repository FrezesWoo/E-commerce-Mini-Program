class Page::Block::Product < ApplicationRecord
  include SetCurrentUser

  belongs_to :block, class_name: 'Page::Block', foreign_key: 'page_block_id', optional: true
  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User
  belongs_to :product_package, class_name: 'Product::Package', optional: true

  enum product_type: { product_package: 1 }
end
