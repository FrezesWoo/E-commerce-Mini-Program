module API
    module Serializers
        module Page
          module Block
            class Products < ActiveModel::Serializer
              attributes :id, :created_at
              belongs_to :product_sku, serializer: Product::Skus
              belongs_to :product_package, serializer: Product::Packages
            end
          end
        end
    end
end
