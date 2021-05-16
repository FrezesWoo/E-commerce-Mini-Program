module API
  module Serializers
    module Product
      module Package
        class Skus < ActiveModel::Serializer
          belongs_to :product_sku, serializer: Product::Package::ProductSkus
        end
      end
    end
  end
end
