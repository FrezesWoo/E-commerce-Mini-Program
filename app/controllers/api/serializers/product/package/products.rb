module API
  module Serializers
    module Product
      module Package
        class Products < ActiveModel::Serializer
          has_many :skus, serializer: Product::Package::Skus
        end
      end
    end
  end
end
