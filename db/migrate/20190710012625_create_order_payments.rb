class CreateOrderPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :order_payments do |t|
      t.references :order, foreign_key: true
      t.integer :status
      t.text :error
      t.jsonb :data
      t.string :transaction_id

      t.timestamps
    end
  end
end
