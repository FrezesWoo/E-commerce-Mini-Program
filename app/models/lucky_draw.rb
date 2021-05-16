class LuckyDraw < ApplicationRecord
  belongs_to :customer, class_name: '::Customer', foreign_key: 'customer_id', optional: true
  belongs_to :lucky_draw_prize_code, class_name: '::LuckyDraw::Prize::Code', foreign_key: 'lucky_draw_prize_code_id', optional: true
  belongs_to :lucky_draw_prize,  class_name: '::LuckyDraw::Prize', foreign_key: 'lucky_draw_prize_id', optional: true

  # Datasets
  class << self
    def to_csv
      attributes = %w[id name mobile ship_address prize_name customer_name customer_gender customer_mobile created_at updated_at]
      "\uFEFF" + CSV.generate(headers: true, encoding: 'UTF-8') do |csv|
        csv << attributes
        all.each do |draw|
          csv << attributes.map{ |attr| draw.send(attr) }
        end
      end
    end

  end

  def ship_address
    (province && city && area && (province != city ? province + city + area + address : city + area + address)) || address
  end

  def encode_mobile
    mobile && mobile.dup.tap{|p| p[3...8] = "*****"}
  end

  def prize_name
    lucky_draw_prize && lucky_draw_prize.product_package.name
  end

  def customer_name
    (customer && customer.name) || name
  end

  def customer_mobile
    customer && customer.phone
  end

  def customer_gender
    !customer.gender.nil? ? (customer.gender == 1 ? '男' : '女') : (!customer.wechat_data.nil? && !customer.wechat_data['gender'].nil?) ? (customer.wechat_data['gender']  == 1 ? '男' : '女') : '未知'
  end

  def remaining_count
    count = ::LuckyDraw.where(customer_id: customer.id).count()
    lucky_draw_date = '2020-07-16 12:00:00'
    return (2 - count) if customer.created_at.to_s >= lucky_draw_date

    (1-count)
  end
end
