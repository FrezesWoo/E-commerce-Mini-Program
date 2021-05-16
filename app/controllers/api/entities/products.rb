module API
    module Entities
        class Products < Grape::Entity
            expose :id
            expose :translations
            expose :image
            expose :product_skus, using: API::Entities::SimplifyProductSkus
            expose :product_category
            expose :image_collection
            expose :hidden_product
            expose :attachments, using: API::Entities::Attachments
            expose :blocks, using: API::Entities::Product::Blocks
        end
    end
end
