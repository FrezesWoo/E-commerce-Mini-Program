class LuckyDraw::Prize::Code < ApplicationRecord
  belongs_to :lucky_draw_prize,  class_name: '::LuckyDraw::Prize', foreign_key: 'lucky_draw_prize_id', inverse_of: :lucky_draw_prize_codes, optional: true
  belongs_to :lucky_draw,  class_name: '::LuckyDraw', foreign_key: 'lucky_draw_prize_code_id', optional: true
  has_one :coupon, class_name: '::Coupon', dependent: :destroy

  after_create :generate_coupon

  def generate_coupon
    expiry_end_date = Time.at(Time.now.to_i + 10.years)
    coupon = ::Coupon.create({ condition: 0, is_disposable: true, expiry_start_date: Time.now, expiry_end_date: expiry_end_date, created_at: Time.now, updated_at: Time.now })
    product_sku_id = self.lucky_draw_prize.product_package.product_package_products.first.skus.first.product_sku.id
    coupon.coupons_product_skus.create({ product_sku_id: product_sku_id, quantity: 1 })
    update(coupon_id: coupon.id)
  end

  def coupon_code
    ::Coupon.find(coupon_id).code
  end

  def coupon_status
    ::Order::Coupon.where(coupon_id: coupon_id).first ? true : false
  end
end
