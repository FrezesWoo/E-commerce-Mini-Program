module API
  module Entities
    class Coupons < Grape::Entity
      expose :id
      expose :code
      expose :condition
      expose :price_condition
      expose :product_condition
      expose :expiry_start_date
      expose :expiry_end_date
      expose :coupons_product_skus, using: API::Entities::Coupon::ProductSkus
    end
  end
end
