class Attachment < ApplicationRecord
  include SetCurrentUser

  belongs_to :attachable, polymorphic: true, optional: true
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :updated_by, class_name: 'User', optional: true

  has_attached_file :file, path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                           storage: :azure,
                           styles: {
                             thumb: "300x300#"
                           }

  validates_attachment :file, presence: true,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..8.megabytes }

  attr_accessor :thumb, :original

  def thumb
    return file.url(:thumb)
  end

  def original
    return file.url
  end

end
