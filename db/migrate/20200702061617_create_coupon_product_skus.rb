class CreateCouponProductSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_product_skus do |t|
      t.references :coupon, foreign_key: true
      t.references :product_sku, foreign_key: true
      t.integer :quantity
    end
  end
end
