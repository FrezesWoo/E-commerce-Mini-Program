module API
  module Entities
    module Product
      module Package
        class Products < Grape::Entity
          expose :product, using: API::Entities::Product::Package::SimplifyProducts
          expose :skus, using: API::Entities::Product::Package::Skus
        end
      end
    end
  end
end
