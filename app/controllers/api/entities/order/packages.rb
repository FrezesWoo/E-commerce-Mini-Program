module API
    module Entities
        module Order
          class Packages < Grape::Entity
            expose :id
            expose :quantity
            expose :product_package, using: API::Entities::Product::Packages
            expose :product_package_skus, using: API::Entities::Order::Package::Skus
          end
        end
    end
end
