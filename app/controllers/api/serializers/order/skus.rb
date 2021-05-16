module API
    module Serializers
      module Order
        class Skus < ActiveModel::Serializer
          attributes :id, :quantity, :product_sku
          belongs_to :product_sku, serializer: SimplifyProductSkus
        end
      end
    end
end
