class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.string :order_number
      t.integer :status
      t.float :amount

      t.timestamps
    end
  end
end
