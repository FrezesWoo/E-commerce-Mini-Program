module API
  module Entities
    module Product
      module Package
        class Skus < Grape::Entity
          expose :product_sku, using: API::Entities::Product::Package::ProductSkus
        end
      end
    end
  end
end
