module API
    module Entities
        module Product
          class Categories < Grape::Entity
            expose :id
            expose :translations
            expose :image
            expose :products, using: API::Entities::Products
          end
        end
    end
end
