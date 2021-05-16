module API
    module Entities
        module Order
          class Skus < Grape::Entity
            expose :id
            expose :created_at
            expose :quantity
            expose :price
            expose :product_sku, using: API::Entities::Product::Skus
          end
        end
    end
end
