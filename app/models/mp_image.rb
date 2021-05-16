class MpImage < ApplicationRecord
  has_attached_file :image, { path: 'public/system/:class/:attachment/:id_partition/:style/:filename',
                              storage: :azure,
                              styles: {
                                  thumb: "300x300#"
                              }
  }

  validates_attachment :image, optional: true,
                       content_type: { content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"] },
                       size: { in: 0..8.megabytes }
end
