class PackageSubscription < ApplicationRecord
  belongs_to :product_package, class_name: '::Product::Package', foreign_key: 'product_package_id', optional: true
  belongs_to :customer
end
