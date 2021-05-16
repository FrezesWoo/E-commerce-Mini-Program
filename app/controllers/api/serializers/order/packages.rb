module API
    module Serializers
      module Order
        class Packages < ActiveModel::Serializer
          attributes :id, :quantity
          belongs_to :product_package, serializer: Product::Packages
          has_many :product_package_skus, serializer: Order::Package::Skus
        end
      end
    end
end
