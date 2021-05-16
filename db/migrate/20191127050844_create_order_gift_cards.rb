class CreateOrderGiftCards < ActiveRecord::Migration[5.2]
  def change
    create_table :order_gift_cards do |t|
      t.string :to
      t.text :content
      t.string :from
      t.references :gift_card, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
