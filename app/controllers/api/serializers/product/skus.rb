module API
  module Serializers
    module Product
      class Skus < ActiveModel::Serializer
        attributes :id, :translations, :product, :sku, :attachments, :price, :image, :ordering
        belongs_to :product, serializer: SimplifyProducts
        has_many :attachments, serializer: Attachments
        has_many :product_product_attributes_skus, serializer: Product::ProductAttributesSkus
      end
    end
  end
end
