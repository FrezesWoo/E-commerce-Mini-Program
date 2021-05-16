module API
    module Serializers
        class CountryProvincesDeliveryFees < ActiveModel::Serializer
            attributes :id, :country_province
        end
    end
end
