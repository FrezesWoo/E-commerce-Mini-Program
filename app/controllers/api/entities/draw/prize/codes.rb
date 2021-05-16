module API
  module Entities
    module Draw
      module Prize
        class Codes < Grape::Entity
          expose :id
          expose :coupon_code
        end
      end
    end
  end
end
