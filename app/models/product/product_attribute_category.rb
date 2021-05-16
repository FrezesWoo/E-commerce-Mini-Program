class Product::ProductAttributeCategory < ApplicationRecord
  include SetCurrentUser
  has_many :product_attributes, class_name: '::Product::ProductAttribute'

  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User

  translates :name

  has_attached_file :picture, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                              storage: :azure,
                              styles: {
                                thumb: "300x300#"
                              }

  validates_attachment :picture, optional: true,
    content_type: { content_type: ["image/png", "image/jpeg", "image/gif"] },
    size: { in: 0..8.megabytes }

end
