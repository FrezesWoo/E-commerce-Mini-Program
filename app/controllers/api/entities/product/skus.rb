module API
    module Entities
        module Product
          class Skus < Grape::Entity
            expose :id
            expose :sku
            expose :d1m_sku
            expose :translations
            expose :quantity
            expose :price
            expose :ordering
            expose :available_quantity
            expose :douyin_quantity
            expose :available_douyin_quantity
            expose :image
            expose :product, using: API::Entities::SimplifyProducts
            expose :product_product_attributes_skus, using: API::Entities::Product::ProductAttributesSkus
            expose :attachments, using: API::Entities:: Attachments
          end
        end
    end
end
