module API
    module Entities
        module Order
          class Bundles < Grape::Entity
            expose :id
            expose :product_bundle
            expose :quantity
            expose :product_sku, using: API::Entities::Product::Skus
          end
        end
    end
end
