require 'uri'
require 'net/https'
require 'json'

module DouyinTool
  class Mp < DouyinTool::Base
    def initialize
      @app_id = ENV['APPID_DOUYIN']
      @app_secret = ENV['APPSECRET_DOUYIN']
      @pay_app_id = ENV['APPID_DOUYIN_PAY']
      @pay_app_secret = ENV['APPSECRET_DOUYIN_PAY']
      @merchant_id = ENV['MERCHANT_ID_DOUYIN']
    end

    def douyin_login(code)
      uri = URI("#{ENV['DOUYIN_API']}/api/apps/jscode2session?appid=#{@app_id}&secret=#{@app_secret}&code=#{code}")
      http = Net::HTTP.new(uri.host, uri.port, nil, nil)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      resp = JSON.parse(response.body)
      {
        open_id: resp['openid'],
        session_key: resp['session_key']
      }
    end

    def generate_douyin_payment(company_name, order_no, sum, wx_url, alipay_url, order_create_time, ip)
      params = Hash.new()
      params['merchant_id'] = @merchant_id
      params['app_id'] = @pay_app_id
      params['sign_type'] = 'MD5'
      params['timestamp'] = Time.now.utc.to_i
      params['version'] = '2.0'
      params['trade_type'] = 'H5'
      params['product_code'] = 'pay'
      params['payment_type'] = 'direct'
      params['out_order_no'] = order_no
      params['uid'] = Time.now().strftime("%Y%m%d%H")
      params['total_amount'] = sum.to_i * 100
      params['currency'] = 'CNY'
      params['subject'] = company_name
      params['body'] = company_name
      params['trade_time'] = order_create_time.to_i.to_s
      params['valid_time'] = 60*60*24
      params['notify_url'] = ENV['API_URL']
      params['alipay_url'] = alipay_url
      params['wx_url'] = wx_url
      params['wx_type'] = 'MWEB'
      params['sign'] = self.get_payment_sign(params)
      params['risk_info'] = {ip: ip}.to_json

      params
    end
  end
end