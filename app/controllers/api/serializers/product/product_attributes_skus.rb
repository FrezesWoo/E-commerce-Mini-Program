module API
    module Serializers
      module Product
        class ProductAttributesSkus < ActiveModel::Serializer
            attributes :product_product_attribute, :sorting, :product_product_attribute_id, :product_sku_id
            belongs_to :product_product_attribute, serializer: Product::Attributes
        end
      end
    end
end
