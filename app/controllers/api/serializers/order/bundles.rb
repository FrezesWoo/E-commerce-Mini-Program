module API
    module Serializers
      module Order
        class Bundles < ActiveModel::Serializer
          attributes :id, :product_sku, :product_bundle, :quantity
          belongs_to :product_sku, serializer: SimplifyProductSkus
          belongs_to :product_bundle, serializer: Product::Bundles
        end
      end
    end
end
