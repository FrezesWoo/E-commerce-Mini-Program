class CreateLuckyDrawPrizeCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :lucky_draw_prize_codes do |t|
      t.string :code
      t.references :lucky_draw_prize, foreign_key: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
