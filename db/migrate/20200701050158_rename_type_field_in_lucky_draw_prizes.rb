class RenameTypeFieldInLuckyDrawPrizes < ActiveRecord::Migration[5.2]
  def change
    rename_column :lucky_draw_prizes, :type, :prize_type
  end
end
