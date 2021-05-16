module API
    module Entities
        module Order
          module Package
            class Skus < Grape::Entity
              expose :id
              expose :quantity
              expose :price
              expose :product_sku, using: API::Entities::Product::Skus
            end
          end
        end
    end
end
