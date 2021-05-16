module API
  module Entities
    module Coupon
      class ProductSkus < Grape::Entity
        expose :quantity
        expose :product_sku, using: API::Entities::SimplifyProductSkus
      end
    end
  end
end
