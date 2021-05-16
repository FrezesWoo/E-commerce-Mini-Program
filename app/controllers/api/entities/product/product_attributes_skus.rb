module API
    module Entities
        module Product
          class ProductAttributesSkus < Grape::Entity
            expose :sorting
            expose :product_product_attribute_id
            expose :product_sku_id
            expose :product_product_attribute, using: API::Entities::Product::Attributes
          end
        end
    end
end
