module API
    module Entities
        class Pages < Grape::Entity
            expose :id
            expose :name
            expose :published_blocks, using: API::Entities::Page::Blocks
        end
    end
end