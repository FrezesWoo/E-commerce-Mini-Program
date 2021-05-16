class CreateLuckyDrawPrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :lucky_draw_prizes do |t|
      t.string :name
      t.references :product_sku, foreign_key: true
      t.integer :quantity
      t.boolean :sample_prize, default: false
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
