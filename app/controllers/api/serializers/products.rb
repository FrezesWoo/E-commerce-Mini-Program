module API
    module Serializers
        class Products < ActiveModel::Serializer
            attributes :id, :translations, :product_category, :product_skus, :ordering, :image
            has_many :product_skus, serializer: Product::Skus
            has_many :image_collection, serializer: Attachments
            has_many :blocks, serializer: Product::Blocks
        end
    end
end
