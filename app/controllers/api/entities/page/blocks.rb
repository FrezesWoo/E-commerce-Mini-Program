module API
    module Entities
      module Page
        class Blocks < Grape::Entity
            expose :id
            expose :translations
            expose :template
            expose :status
            expose :ordering
            expose :link
            expose :height
            expose :link_width
            expose :link_height
            expose :has_dots
            expose :has_arrows
            expose :sticky
            expose :slides, using: API::Entities::Page::Block::Slides
            expose :products, using: API::Entities::Page::Block::Products
            expose :tabbars, using: API::Entities::Page::Block::Tabbars
        end
      end
    end
end
