class Page::Block::Tabbar < ApplicationRecord
  include SetCurrentUser

  belongs_to :block, class_name: 'Page::Block', foreign_key: 'page_block_id', optional: true
  belongs_to :created_by, :class_name => :User, optional: true
  belongs_to :updated_by, :class_name => :User, optional: true

  has_attached_file :anchor_hover, {
      path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
      storage: :azure,
      styles: {
          thumb: "300x300#"
      }
  }

  validates_attachment :anchor_hover, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }

  has_attached_file :anchor_active, {
      path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
      storage: :azure,
      styles: {
          thumb: "300x300#"
      }
  }

  validates_attachment :anchor_active, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }

end
