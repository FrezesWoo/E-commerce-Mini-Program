class RemoveProductSkuSelectionToLuckyDrawPrizes < ActiveRecord::Migration[5.2]
  def change
    remove_column :lucky_draw_prizes, :product_sku_id
    add_reference :lucky_draw_prizes, :product_package, foreign_key: true
    add_column :lucky_draw_prizes, :type, :integer
  end
end
