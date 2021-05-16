class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.integer :gender
      t.string :name
      t.string :open_id
      t.string :union_id
      t.jsonb :wechat_data
      t.string :email
      t.string :phone
      t.attachment :avatar

      t.timestamps
    end
  end
end
