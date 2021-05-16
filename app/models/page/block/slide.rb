class Page::Block::Slide < ApplicationRecord
  include SetCurrentUser

  belongs_to :block, class_name: 'Page::Block', foreign_key: 'page_block_id', optional: true
  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User
  belongs_to :mp_link, optional: true
  belongs_to :product_package, optional: true

  enum link_type: { 商品页: 1, 小程序页面: 2, 自定义页面: 3, 其他小程序: 4 }

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

  translates :title, :description, :alt

  attr_accessor :original, :link_type_id

  def original
    return image.url
  end

  def link_type_id
    link_type_before_type_cast
  end
end
