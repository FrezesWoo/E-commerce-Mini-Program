module API
    module Serializers
      module Product
        class Blocks < ActiveModel::Serializer
          attributes :image_full, :video_full, :x_position, :y_position, :link_width, :link_height, :template, :ordering
        end
      end
    end
end
