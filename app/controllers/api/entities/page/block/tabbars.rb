module API
  module Entities
    module Page
      module Block
        class Tabbars < Grape::Entity
          expose :id
          expose :target
          expose :anchor_hover
          expose :anchor_active
          expose :ordering
        end
      end
    end
  end
end
