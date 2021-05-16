module API
  module Entities
    module Product
      module Package
        class ProductSkus < Grape::Entity
          expose :id
          expose :product_id
          expose :sku
          expose :quantity
          expose :price
          expose :image
          expose :ordering
          expose :available_quantity
          expose :available_douyin_quantity
          expose :translations
          expose :product_product_attributes_skus, using: API::Entities::Product::ProductAttributesSkus
          expose :attachments, using: API::Entities:: Attachments
        end
      end
    end
  end
end
