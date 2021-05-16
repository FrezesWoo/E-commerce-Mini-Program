require 'uri'
require 'net/http'
require 'net/https'
require 'json'

module WechatTool
  class H5
    def initialize
      @app_id = ENV['APP_H5_ID_WECHAT']
      @app_secret = ENV['APP_H5_SECRET_WECHAT']
      @mch_id = ENV['WECHAT_H5_MERCHANT_NUMBER']
      @key = ENV['WECHAT_H5_MERCHANT_KEY']
    end

    def get_open_id(wechat_code)
      uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{@app_id}&secret=#{@app_secret}&code=#{wechat_code}&grant_type=authorization_code")
      wechat_info = Net::HTTP.get(uri)
      resp = JSON.parse(wechat_info)
      {
        :opend_id => resp['openid'],
        :access_token =>  resp['access_token'],
        :union_id => resp['unionid']
      }
    end

    def get_more_user_info(access_token, open_id)
      uri = URI("https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{open_id}&lang=zh_CN")
      wechat_info = Net::HTTP.get(uri)
      resp = JSON.parse(wechat_info)
      resp
    end

    def generate_wechat_payment(company_name, order_no, sum)
      official_account = {
          appid: @app_id,
          appsecret: @app_secret,
          mch_id: @mch_id,
          key: @key
      }.freeze
      params = generate_params_for_payment(company_name, order_no, sum)
      r1 = WxPay::Service.invoke_unifiedorder params, official_account.dup
      new_params = {
          prepayid: r1[:raw]['xml']['prepay_id'],
          noncestr: SecureRandom.hex(16)
      }
      r2 = WxPay::Service.generate_js_pay_req new_params
      return { r1: r1, r2: r2 }
    end

    def generate_params_for_payment(company_name, order_no, sum)
      params = Hash.new()
      params[:body] = company_name
      params[:out_trade_no] = order_no
      params[:total_fee] = (sum.to_f * 100).round(0)
      params[:spbill_create_ip] = '58.37.81.171'
      params[:notify_url] = "#{ENV['API_URL']}/wechat/notify"
      params[:trade_type] = 'MWEB'
      params
    end
  end
end
