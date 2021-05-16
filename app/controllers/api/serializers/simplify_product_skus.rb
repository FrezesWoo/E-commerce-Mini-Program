module API
    module Serializers
        class SimplifyProductSkus < ActiveModel::Serializer
            attributes :id, :translations, :sku, :price, :ordering, :quantity, :available_quantity, :douyin_quantity, :available_douyin_quantity, :image
            belongs_to :product,serializer: SimplifySimplifyProducts
            has_many :product_product_attributes_skus, serializer: Product::ProductAttributesSkus
            has_many :attachments, serializer: Attachments
        end
    end
end
