module API
    module Serializers
      module Product
        class ProductAttributeCategories < ActiveModel::Serializer
            attributes :id, :translations
        end
      end
    end
end
