class AddCouponReferenceInLuckyDrawPrizeCodes < ActiveRecord::Migration[5.2]
  def change
    remove_column :lucky_draw_prize_codes, :code
    add_reference :lucky_draw_prize_codes, :coupon, foreign_key: true
  end
end
