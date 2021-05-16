require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'alipay'

module Alipay
  class Base

    attr_accessor :alipay_client

    def initialize
      self.alipay_client = Alipay::Client.new(
        url: ENV['ALIPAY_API_URL'],
        app_id: ENV['ALIPAY_APP_ID'],
        app_private_key: ENV['ALIPAY_PRIVATE_KEY'],
        alipay_public_key: ENV['ALIPAY_PUBLIC_KEY']
      )
    end

    def generate_payment(out_trade_no, amount)
      params = {
        out_trade_no: out_trade_no,
        product_code: 'QUICK_MSECURITY_PAY',
        total_amount: amount,
        subject: 'ShiSeido'
      }
      puts '############ We are doing alipay payment we check what is going on', amount
      self.alipay_client.sdk_execute(
        method: 'alipay.trade.app.pay',
        biz_content: JSON.generate(params, ascii_only: true),
        timestamp: Time.now().strftime("%Y-%m-%d %H:%d:%M"),
        notify_url: "#{ENV['API_URL']}/alipay/notify"
      )
    end

  end
end
