class Country::ProvincesDeliveryFee < ApplicationRecord
  belongs_to :country_province, class_name: '::Country::Province', foreign_key: 'country_province_id', optional: true
  belongs_to :delivery_fee, foreign_key: 'delivery_fee_id', optional: true
end
