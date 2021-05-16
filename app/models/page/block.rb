class Page::Block < ApplicationRecord
  include SetCurrentUser

  belongs_to :page, class_name: '::Page', optional: true
  belongs_to :created_by, class_name: :User
  belongs_to :updated_by, class_name: :User

  has_many :slides, -> { order(ordering: :asc) },  class_name: 'Page::Block::Slide', foreign_key: 'page_block_id', dependent: :destroy
  has_many :products, -> { order(ordering: :asc) },  class_name: 'Page::Block::Product', foreign_key: 'page_block_id', dependent: :destroy
  has_many :tabbars, -> { order(ordering: :asc) },  class_name: 'Page::Block::Tabbar', foreign_key: 'page_block_id', dependent: :destroy

  enum template: { content: 0, tx_video: 1, slide_show: 2, products: 3, tabbar: 4 }

  enum status: { draft: 0, published: 1, unpublished: 2 }

  translates :title, :description

  accepts_nested_attributes_for :slides, :products, :tabbars, allow_destroy: true

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

end
