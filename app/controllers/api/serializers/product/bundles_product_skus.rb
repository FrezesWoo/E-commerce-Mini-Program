module API
    module Serializers
      module Product
        class BundlesProductSkus < ActiveModel::Serializer
          belongs_to :product_sku, serializer: API::Serializers::SimplifyProductSkus
          attributes :product_sku_id, :quantity
        end
      end
    end
end
