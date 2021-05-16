module API
  module Serializers
    module Order
      module Package
        class Skus < ActiveModel::Serializer
          attributes :id, :quantity
          belongs_to :product_sku, serializer: SimplifyProductSkus
        end
      end
    end
  end
end
