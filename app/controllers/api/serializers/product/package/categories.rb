module API
    module Serializers
      module Product
        module Package
          class Categories < ActiveModel::Serializer
              attributes :id, :translations, :image, :ordering
              has_many :product_packages, serializer: Product::Packages
          end
        end
      end
    end
end
