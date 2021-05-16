module API
    module Entities
        class Campaigns < Grape::Entity
          expose :id
          expose :name
          expose :publish
          expose :blocks, using: API::Entities::Campaign::Blocks
        end
    end
end
