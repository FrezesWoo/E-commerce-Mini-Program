module API
  module Entities
    module Draw
      class Prizes < Grape::Entity
        expose :name
        expose :prize_type
        expose :product_package, using: API::Entities::Product::Packages
      end
    end
  end
end
