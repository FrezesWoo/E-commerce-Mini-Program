module API
  module Entities
    module Order
      class Coupons < Grape::Entity
        expose :id
        expose :coupon
        expose :quantity
        expose :product_sku, using: API::Entities::Product::Skus
      end
    end
  end
end
