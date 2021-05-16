module API
    module Serializers
      module Product
        class Categories < ActiveModel::Serializer
            attributes :id, :translations, :image, :ordering
            has_many :products, serializer: SimplifyProducts
        end
      end
    end
end
