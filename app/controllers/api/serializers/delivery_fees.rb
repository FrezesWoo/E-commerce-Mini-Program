module API
    module Serializers
        class DeliveryFees < ActiveModel::Serializer
            attributes :id, :price
            has_many :country_provinces_delivery_fees, serializer: CountryProvincesDeliveryFees
        end
    end
end
