module API
    module Entities
        module Product
          module Package
            class Categories < Grape::Entity
              expose :id
              expose :translations
              expose :image
              expose :product_packages, using: API::Entities::Product::Packages
            end
          end
        end
    end
end
