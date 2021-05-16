class Product::ProductAttribute < ApplicationRecord
  include SetCurrentUser

  has_many :product_product_attributes_skus, class_name: '::Product::ProductAttributesSkus'
  has_and_belongs_to_many :product_skus, through: :product_product_attributes_skus, optional: true

  belongs_to :product_product_attribute_category, class_name: '::Product::ProductAttributeCategory', foreign_key: 'product_product_attribute_category_id', optional: true
  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User

  translates :name, :description, :composition, :value

  has_attached_file :picture, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                              storage: :azure,
                              styles: {
                                thumb: "300x300#"
                              }

  validates_attachment :picture, optional: true,
    content_type: { content_type: ["image/png", "image/jpeg", "image/gif"] },
    size: { in: 0..8.megabytes }

end
