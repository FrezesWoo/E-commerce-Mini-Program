module API
    module Entities
        module Product
          class Blocks < Grape::Entity
            expose :image_full
            expose :video_full
            expose :x_position
            expose :y_position
            expose :link_width
            expose :link_height
            expose :template
            expose :ordering
          end
        end
    end
end
