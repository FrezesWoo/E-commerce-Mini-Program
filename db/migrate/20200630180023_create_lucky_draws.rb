class CreateLuckyDraws < ActiveRecord::Migration[5.2]
  def change
    create_table :lucky_draws do |t|
      t.references :customer, foreign_key: true
      t.references :lucky_draw_prize, foreign_key: true
      t.references :lucky_draw_prize_code, foreign_key: true
      t.string :name
      t.string :mobile
      t.string :province
      t.string :city
      t.string :area
      t.string :address
      t.integer :status

      t.timestamps
    end
  end
end
