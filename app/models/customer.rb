require 'active_support'

class Customer < ApplicationRecord
  include CustomerMethod
  has_many :customer_tokens, class_name: 'Customer::Token', dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :phone, allow_blank: true, uniqueness: true, format: {
      with: /[0-9]{7,15}/,
      message: 'Only valid phone allowed'
  }

  validates :open_id, uniqueness: true, presence: true
  validates :union_id, uniqueness: true, allow_blank: true

  attr_accessor :api_token, :avatar_picture

  ## static  Methods
  class << self
    include CustomerStaticMethod

    def by_auth_token(token)
      customer_token = Customer::Token.where(token: token).first
      customer_token ? customer_token.customer : nil
    end

    def by_auth_token_and_id(token,customer_id)
      customer_token = Customer::Token.where(token: token).where(customer_id: customer_id).first
      customer_token ? customer_token.customer : nil
    end

    def wechat_silent_login(wechat_token)
      wechat = ::WechatTool::Mp.new()
      wechat_data = wechat.wechat_login(wechat_token)
      puts wechat_data
      customer = Customer.find_or_create_by({ open_id: wechat_data[:open_id] })
      customer.wechat_session_key = wechat_data[:session_key]
      customer.save
      customer
    end

    def order_by_day(from=nil, to=nil)
      customers = Customer.all
      if !from.nil? && from != ""
        date_from = Customer.arel_table[:created_at]
        customers = customers.where(date_from.gt(from))
      end
      if !to.nil? && to != ""
        date_to = Customer.arel_table[:created_at]
        customers = customers.where(date_to.lt(to))
      end
      self.default_timezone = :utc
      count = customers.group_by_day(:created_at).count
      self.default_timezone = :local
      count
    end

    def stats
      statistics = Hash.new()
      statistics['total'] = Customer.count
      statistics['order'] = Order.select(:customer_id).distinct.count
      statistics['wechat'] = Customer.count(:wechat_data)
      statistics['phone'] = Customer.count(:phone)
      statistics
    end

  end

  def format_wechat_userinfo
    format = {
        openid: wechat_data && wechat_data['openId'] || open_id,
        nickname: wechat_data && wechat_data['nickName'] || name,
        sex: wechat_data && wechat_data['gender'] || (gender || 0),
        province: wechat_data && wechat_data['province'] || '',
        city: wechat_data && wechat_data['city'] || '',
        country: wechat_data && wechat_data['country'] || '',
        headimgurl: wechat_data && wechat_data['avatarUrl'] || ''
    }
    format.to_json
  end

  def api_token
    !customer_tokens.empty? && customer_tokens.last.token
  end

  def login!
    expire_at = Customer::Token.arel_table[:expire_at]
    token = customer_tokens.where(expire_at.lt(DateTime.now)).first
    if token || customer_tokens.empty?
      customer_tokens.delete_all if !customer_tokens.empty?
      customer_tokens.create
    end
  end

  def avatar_picture
    return avatar.url
  end

  def validate_customer_draw
    count = ::LuckyDraw.where(customer_id: id).count()
    lucky_draw_date = '2020-07-16 12:00:00'
    if created_at.to_s >= lucky_draw_date
      return false if count >= 2
    else
      return false if count >= 1
    end

    true
  end

end
