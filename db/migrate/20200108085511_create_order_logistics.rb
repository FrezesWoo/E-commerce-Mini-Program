class CreateOrderLogistics < ActiveRecord::Migration[5.2]
  def change
    create_table :order_logistics do |t|
      t.references :order, foreign_key: true
      t.string :shipping_number

      t.timestamps
    end
  end
end