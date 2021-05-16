module API
    module Entities
        module Product
          class ProductAttributeCategories < Grape::Entity
            expose :id
            expose :translations
          end
        end
    end
end
