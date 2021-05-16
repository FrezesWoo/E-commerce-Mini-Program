class Product::Category < ApplicationRecord
  include SetCurrentUser
  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User
  has_many :products, -> { order(ordering: :asc) }, foreign_key: 'product_category_id'
  has_many :product_packages, -> { order(ordering: :asc) }, class_name: '::Product::Package', foreign_key: 'product_category_id'

  translates :name

  has_attached_file :image, {
      storage: :azure,
      path: ":class/:id/:attachment/:style/:filename",
      styles: {
          thumb: "300x300#"
      }
  }

  validates_attachment :image,
    content_type: { content_type: ["image/png", "image/jpeg", "image/gif"] },
    size: { in: 0..8.megabytes }

end
