require 'uri'
require 'net/http'
require 'net/https'
require 'json'

module DouyinTool
  class Base
    def initialize
      @app_id = ENV['APPID_DOUYIN']
      @app_secret = ENV['APPSECRET_DOUYIN']
      @pay_app_id = ENV['APPID_DOUYIN_PAY']
      @pay_app_secret = ENV['APPSECRET_DOUYIN_PAY']
    end

    def get_token
      uri = URI("#{ENV['DOUYIN_API']}/api/apps/token?grant_type=client_credential&appid=#{@app_id}&secret=#{@app_secret}");
      douyin_info = Rails.cache.fetch("douyin_access_token", expires_in: 7200) do
        Net::HTTP.get(uri)
      end
      resp = JSON.parse(douyin_info)
      resp["access_token"]
    end

    def get_payment_sign(param)
      sign = ''
      sign_param = Hash[param.sort]
      sign_param.each do |k, v|
        sign += '&' if sign.length > 0
        sign_str = k + '=' + v.to_s if k != 'risk_info' && !v.blank?
        sign += sign_str
      end
      sign += @pay_app_secret
      puts 'douyin payment signature is', sign
      puts 'signature is', Digest::MD5.hexdigest(sign)
      Digest::MD5.hexdigest(sign)
    end
  end
end