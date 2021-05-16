class Country::Province < ApplicationRecord
  has_many :country_province_delivery_fees, class_name: '::Country::ProvincesDeliveryFee', foreign_key: 'country_province_id'
  belongs_to :country
  translates :name
end
