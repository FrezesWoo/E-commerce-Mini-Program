class Country < ApplicationRecord
  has_many :country_provinces, class_name: 'Country::Province'
  translates :name
end
