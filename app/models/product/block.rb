class Product::Block < ApplicationRecord
  include ImagesPath
  belongs_to :product, class_name: '::Product', foreign_key: 'product_id', optional: true

  enum template: { image: 1, video: 2, link: 3 }

  has_attached_file :image, {
      path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
      storage: :azure,
      styles: {
          thumb: "300x300#"
      }
  }

  validates_attachment :image, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }

  has_attached_file :video, {
      path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
      storage: :azure,
      styles: lambda { |a|
        {
            thumb: { geometry: "1200x900#", format: 'jpg' }
        }
      }, processors: [:transcoder]
  }

  validates_attachment :video, optional: true,
                       content_type: { content_type: ["video/mpg", "video/wmv", "video/m4v", "video/ogv", "video/mp4"] },
                       size: { in: 0..15.megabytes }
end
