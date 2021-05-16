module API
  module Serializers
    module Product
      class Packages < ActiveModel::Serializer
        attributes :id, :translations, :product_category, :hidden_product, :publish, :shipping_price, :note, :description, :ordering, :image
        has_many :product_package_products, serializer: Product::Package::Products
      end
    end
  end
end
