class CreateCustomerTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_tokens do |t|
      t.datetime :set_expire_at
      t.string :token
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
