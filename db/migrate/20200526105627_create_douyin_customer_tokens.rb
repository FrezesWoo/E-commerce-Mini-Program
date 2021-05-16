class CreateDouyinCustomerTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :douyin_customer_tokens do |t|
      t.string :token
      t.datetime :expire_at
      t.references :douyin_customer, foreign_key: true

      t.timestamps
    end
  end
end
