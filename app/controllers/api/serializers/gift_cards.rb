module API
  module Serializers
    class GiftCards < ActiveModel::Serializer
      attributes :id, :image
    end
  end
end
