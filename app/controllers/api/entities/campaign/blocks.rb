module API
    module Entities
        module Campaign
          class Blocks < Grape::Entity
            expose :image_full
            expose :link
            expose :x_position
            expose :y_position
            expose :link_width
            expose :link_height
            expose :template
            expose :ordering
            expose :product
            expose :product_package
            expose :mp_link
          end
        end
    end
end
