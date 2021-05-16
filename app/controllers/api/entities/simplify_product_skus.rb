module API
    module Entities
        class SimplifyProductSkus < Grape::Entity
          expose :id
          expose :sku
          expose :translations
          expose :quantity
          expose :available_quantity
          expose :douyin_quantity
          expose :available_douyin_quantity
          expose :price
          expose :ordering
          expose :image
          expose :product_product_attributes_skus, using: API::Entities::Product::ProductAttributesSkus
          expose :attachments, using: API::Entities:: Attachments
        end
    end
end
