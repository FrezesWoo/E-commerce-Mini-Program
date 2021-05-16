# app/models/concerns/images_path.rb
module ImagesPath
  extend ActiveSupport::Concern

  def image_full
    image && image.url
  end

  def video_full
    video && video.url
  end
end
