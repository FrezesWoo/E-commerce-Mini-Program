module API
    module Entities
        class SimplifyProducts < Grape::Entity
            expose :id
            expose :translations
            expose :image
            expose :product_category
            expose :product_skus, using: API::Entities::SimplifyProductSkus
            expose :attachments, using: API::Entities:: Attachments
        end
    end
end
