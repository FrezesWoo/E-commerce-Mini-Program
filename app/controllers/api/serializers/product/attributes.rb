module API
    module Serializers
      module Product
        class Attributes < ActiveModel::Serializer
            attributes :id, :translations, :product_product_attribute_category
            belongs_to :product_product_attribute_category, serializer: Product::ProductAttributeCategories
        end
      end
    end
end
