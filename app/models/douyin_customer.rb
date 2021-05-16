require 'active_support'

class DouyinCustomer < ApplicationRecord
  include CustomerMethod
  has_many :douyin_customer_tokens, class_name: 'DouyinCustomer::Token', foreign_key: 'douyin_customer_id', dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :phone, allow_blank: true, uniqueness: true, format: {
      with: /[0-9]{7,15}/,
      message: 'Only valid phone allowed'
  }

  validates :open_id, uniqueness: true, presence: true

  attr_accessor :api_token

  ## static  Methods
  class << self
    include CustomerStaticMethod

    def by_auth_token(token)
      customer_token = DouyinCustomer::Token.where(token: token).first
      customer_token ? customer_token.douyin_customer : nil
    end

    def by_auth_token_and_id(token,douyin_customer_id)
      customer_token = DouyinCustomer::Token.where(token: token).where(douyin_customer_id: douyin_customer_id).first
      customer_token ? customer_token.douyin_customer : nil
    end

    def douyin_silent_login(code)
      douyin_data = ::DouyinTool::Mp.new().douyin_login(code)
      puts douyin_data
      customer = DouyinCustomer.find_or_create_by({ open_id: douyin_data[:open_id] })
      customer.douyin_session_key = douyin_data[:session_key]
      customer.save
      customer
    end
  end

  def api_token
    !douyin_customer_tokens.empty? && douyin_customer_tokens.last.token
  end

  def login!
    expire_at = DouyinCustomer::Token.arel_table[:expire_at]
    token = douyin_customer_tokens.where(expire_at.lt(DateTime.now)).first
    if token || douyin_customer_tokens.empty?
      douyin_customer_tokens.delete_all if !douyin_customer_tokens.empty?
      douyin_customer_tokens.create
    end
  end

end
