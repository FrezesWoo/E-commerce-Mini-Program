module API
  module Serializers
    module Product
      module Package
        class ProductSkus < ActiveModel::Serializer
          attributes :id, :product_id, :sku, :quantity, :price, :translations
        end
      end
    end
  end
end
