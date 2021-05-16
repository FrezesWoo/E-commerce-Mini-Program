class LuckyDraw::Prize < ApplicationRecord
  has_many :lucky_draw_prize_codes, class_name: '::LuckyDraw::Prize::Code', foreign_key: 'lucky_draw_prize_id', inverse_of: :lucky_draw_prize, dependent: :destroy
  belongs_to :product_package, class_name: '::Product::Package', foreign_key: 'product_package_id', optional: true

  enum prize_type: { '一等奖': 1, '二等奖': 2, '三等奖': 3, '四等奖': 4 }

  after_create :generate_codes

  def generate_codes
    if sample_prize && quantity > 0
      (1..quantity).each { lucky_draw_prize_codes.create() }
    end
  end

  def remaining_quantity
    qt = quantity || 0
    ::LuckyDraw.where(lucky_draw_prize_id: id).each { qt -= 1 }
    qt
  end

  # customer lucky draw logic
  def self.get_random_lucky_draw_prize(customer_id)
    lucky_draw_prize = { lucky_draw_prize_id: nil, lucky_draw_prize_code_id: nil }
    prize_id = self.set_lucky_draw_prize_pool.sample
    # for nil prize_id
    return lucky_draw_prize if prize_id.nil?

    # for only one time
    get_prize_count = ::LuckyDraw.where(customer_id: customer_id).where.not(lucky_draw_prize_id: nil).count()
    return lucky_draw_prize if get_prize_count > 0

    # validate sample prize id exists
    sample_prize_id = self.where(prize_type: 4).first&.id
    return lucky_draw_prize if !sample_prize_id
    # for new customer
    lucky_draw_date = '2020-07-16 12:00:00'
    customer = ::Customer.find(customer_id)
    count = ::LuckyDraw.where(customer_id: customer_id).count()
    prize_id = sample_prize_id if customer.created_at.to_s >= lucky_draw_date && count === 0 && prize_id != sample_prize_id

    prize = self.find(prize_id)
    return lucky_draw_prize if prize.remaining_quantity <= 0
    # for sample prize
    code_id = prize.sample_prize ? prize.lucky_draw_prize_codes.where(status: true).pluck(:id).sample : nil
    LuckyDraw::Prize::Code.find(code_id).update({status: false}) if !code_id.nil?
    { lucky_draw_prize_id: prize_id, lucky_draw_prize_code_id: code_id }
  end

  def self.set_lucky_draw_prize_pool
    lucky_draw_prize = self.where(status: true)
    number = 30000 - lucky_draw_prize.sum('quantity')
    lucky_draw_prize_pool = Rails.cache.fetch("lucky_draw_prize_pool", expires_in: 604800) do
      pool = Array.new(number)
      lucky_draw_prize.each { |prize| (1..prize.quantity).map { pool << prize.id } }
      pool
    end

    lucky_draw_prize_pool
  end
end
