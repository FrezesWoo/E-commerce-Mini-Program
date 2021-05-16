class CreateJoinTableDeliveryFeeCountryProvince < ActiveRecord::Migration[5.2]
  def change
    create_join_table :delivery_fees, :country_provinces do |t|
      # t.index [:delivery_fee_id, :country_province_id]
      # t.index [:country_province_id, :delivery_fee_id]
    end
  end
end
