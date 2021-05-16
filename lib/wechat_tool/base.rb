require 'uri'
require 'net/http'
require 'net/https'
require 'json'

module WechatTool
  class Base
    def initialize
      @app_id = ENV['APPID_WECHAT']
      @app_secret = ENV['APPSECRET_WECHAT']
    end

    def get_token
      uri = URI("#{ENV['WECHAT_API']}/cgi-bin/token?grant_type=client_credential&appid=#{@app_id}&secret=#{@app_secret}");
      wechat_info = Rails.cache.fetch("wechat_access_token", expires_in: 7200) do
        Net::HTTP.get(uri)
      end
      resp = JSON.parse(wechat_info)
      resp["access_token"]
    end

    def get_message_template_list
      # https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1433751277
      token = self.get_token
      uri = URI("#{ENV['WECHAT_API']}/cgi-bin/template/get_all_private_template?access_token=#{token}")
      wechat_info = Net::HTTP.get(uri)
      JSON.parse(wechat_info)
    end

    def send_templating_message_to_user(customer, template_id)
      # https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1433751277
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/cgi-bin/message/template/send?access_token=#{token}")
      params = {
        touser: customer.open_id,
        template_id: template_id,
        appid: @app_id,
        url: "#{ENV["APP_URL"]}/thank-you",
        data: {
          first: {
            value: "Dear #{customer.inquiry.name}"
          },
          keyword1: {
            value: "You've have been selected for our event please click on the following link to have more details"
          }
        }
      }
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}", initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      https.request(req)
    end

    def is_client_subscribe_ao(open_id)
      # https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140839
      token = self.get_token
      uri = URI("#{ENV['WECHAT_API']}/cgi-bin/user/info?access_token=#{token}&openid=#{open_id}&lang=zh_CN")
      wechat_info = Net::HTTP.get(uri)
      JSON.parse(wechat_info)
    end
  end
end
