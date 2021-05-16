# frozen_string_literal: true

class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data, {
                    path: 'public/ckeditor_assets/pictures/:filename',
                    storage: :azure
  }

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 7.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end
