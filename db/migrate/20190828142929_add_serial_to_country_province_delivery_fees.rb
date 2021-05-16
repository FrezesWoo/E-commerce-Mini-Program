class AddSerialToCountryProvinceDeliveryFees < ActiveRecord::Migration[5.2]
  def change
    add_column :country_provinces_delivery_fees, :id, :serial, null: false, unique: true, primary_key: true
  end
end
