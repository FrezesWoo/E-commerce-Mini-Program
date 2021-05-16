module API
  module Serializers
      module Page
        module Block
          class Slides < ActiveModel::Serializer
            attributes :id, :created_at, :translations, :image, :mp_link, :product_id, :original
          end
        end
      end
    end
end
