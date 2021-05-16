module API
  module Serializers
    class ProductProductSkus < ActiveModel::Serializer
      attributes :id, :translations, :product, :sku, :attachments, :price, :ordering
    end
  end
end
