module API
    module Entities
        module Product
          class Attributes < Grape::Entity
            expose :translations
            expose :product_product_attribute_category, using: API::Entities::Product::ProductAttributeCategories
          end
        end
    end
end
