module API
    module Entities
      module Page
        module Block
          class Products < Grape::Entity
              expose :id
              expose :ordering
              expose :product_package, using: API::Entities::Product::Packages
          end
        end
      end
    end
end
