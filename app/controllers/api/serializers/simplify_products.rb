module API
    module Serializers
        class SimplifyProducts < ActiveModel::Serializer
            attributes :id, :translations, :product_category, :image, :image_collection, :ordering
            has_many :product_skus, serializer: SimplifyProductSkus
            has_many :blocks, serializer: Product::Blocks
        end
    end
end
