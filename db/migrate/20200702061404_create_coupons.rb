class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :condition
      t.float :price_condition
      t.bigint :product_condition
      t.boolean :is_disposable, default: false
      t.integer :status, default: 1
      t.datetime :expiry_start_date
      t.datetime :expiry_end_date

      t.timestamps
    end
  end
end
