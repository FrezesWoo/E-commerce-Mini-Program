class DeliveryFee < ApplicationRecord
  has_many :country_provinces_delivery_fees, class_name: '::Country::ProvincesDeliveryFee', foreign_key: 'delivery_fee_id'

  accepts_nested_attributes_for :country_provinces_delivery_fees, allow_destroy: true
end
