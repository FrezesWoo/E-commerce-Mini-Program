module API
    module Serializers
      module Product
        class Bundles < ActiveModel::Serializer
            attributes :id, :translations, :ordering, :condition, :price, :price_condition, :quantity, :product
            has_many :product_bundles_product_skus, serializer: API::Serializers::Product::BundlesProductSkus
        end
      end
    end
end
