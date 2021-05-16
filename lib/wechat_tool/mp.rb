require 'uri'
require 'net/https'
require 'json'

module WechatTool
  class Mp < WechatTool::Base
    def initialize
      @app_id = ENV['APPID_WECHAT_MP']
      @app_secret = ENV['APPSECRET_WECHAT_MP']
      @login_url= ENV['GATEWAY_WECHAT_LOGIN']
    end

    def wechat_login(wechat_token)
      uri = URI("#{ENV['WECHAT_API']}/sns/jscode2session?appid=#{ENV['APPID_WECHAT_MP']}&secret=#{ENV['APPSECRET_WECHAT_MP']}&js_code=#{wechat_token}&grant_type=authorization_code")
      http = Net::HTTP.new(uri.host, uri.port)
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

    def check_message_signature(signature, timestamp, nonce)
      sign = [ENV['MP_MESSAGE_TOKEN'], timestamp, nonce].sort.join('')
      sha1 = Digest::SHA1.hexdigest(sign)
      sha1 == signature
    end

    def send_templating_message_to_user(visitor, template_id, form_id)
      # https://developers.weixin.qq.com/miniprogram/dev/api-backend/uniformMessage.send.html
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/cgi-bin/message/wxopen/template/uniform_send?access_token=#{token}")
      params = {
        touser: visitor.open_id,
        weapp_template_msg: {
          template_id: template_id,
          page: "pages/form/index",
          form_id: form_id,
          emphasis_keyword: "keyword1.DATA",
          data: {
            first: {
              value: "Dear #{visitor.name}"
            },
            keyword1: {
              value: "You've have successfully make an appointment for our event"
            }
          }
        }
      }
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}", initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      result = https.request(req)
      puts result.body
    end

    def generate_qr_code(path)
      # https://developers.weixin.qq.com/miniprogram/dev/api-backend/createWXAQRCode.html?search-key=qrcode
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/cgi-bin/wxaapp/createwxaqrcode?access_token=#{token}")
      params = {
        path: path,
        width: 1280
      }
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}", initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      result = https.request(req)
      result.body
    end

    def generate_qr_code_unlimited(path, path_params=nil)
      # https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/qr-code/wxacode.getUnlimited.html
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/wxa/getwxacodeunlimit?access_token=#{token}")
      params = {
        page: path,
        width: 280,
        scene: path_params || 'Shiseido',
        is_hyaline: true
      }
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}")
      req.body = params.to_json.gsub('\u0026', '&')
      result = https.request(req)
      result.body
    end

    def send_new_templating_message_to_user(visitor, params)
      # https://developers.weixin.qq.com/miniprogram/dev/api-backend/uniformMessage.send.html
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/cgi-bin/message/subscribe/send?access_token=#{token}")
      params = {
        touser: visitor.open_id,
        template_id: '-BHsJcmW4Sm-3h4l-kDF0J2o-FRC1smbA49ImDqGEks',
        page: "pages/index/index",
        data: params
      }
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}", initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      result = https.request(req)
      puts result.body
    end

    def import_product(params)
      token = self.get_token
      uri = URI.parse("#{ENV['WECHAT_API']}/mall/importproduct?access_token=#{token}")
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?access_token=#{token}", initheader = {'Content-Type' =>'application/json', 'accept-encoding' => '', 'accept' => 'json'})
      req.body = params.to_json.force_encoding('UTF-8')
      result = https.request(req)
      puts result.body
    end

    def user_actions_add(click_id, amount, url)
      wechat_query = ::CrmShiseido::WechatQuery.new()
      token = wechat_query.get_access_token
      uri = URI.parse("#{ENV['WECHAT_API']}/marketing/user_actions/add?version=v1.0&access_token=#{token}")
      params = {
          actions:[
              {
                  user_action_set_id: 1109902024,
                  url: url,
                  action_time: Time.now.utc.to_i,
                  action_type: "COMPLETE_ORDER",
                  trace: {
                    click_id: click_id
                  },
                  action_param: {
                    value: amount*100
                  }
              }
          ]
      }
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new("#{uri.path}?version=v1.0&access_token=#{token}", initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      result = https.request(req)
      JSON.parse(result.body)
    end

    def generate_wechat_payment(company_name, order_no, sum, open_id)
      params = generate_params_for_payment(company_name, order_no, sum, open_id)
      r1 = WxPay::Service.invoke_unifiedorder params
      new_params = {
        prepayid: r1[:raw]['xml']['prepay_id'],
        noncestr: SecureRandom.hex(16)
      }
      r2 = WxPay::Service.generate_js_pay_req new_params
      puts '############## payment params'
      puts params
      puts 'Wechat info'
      puts WxPay.appid, WxPay.key, WxPay.mch_id, WxPay.appsecret
      puts open_id, r1, r2
      return { r1: r1, r2: r2 }
    end

    def generate_params_for_payment(company_name, order_no, sum, open_id)
      params = Hash.new()
      params[:body] = company_name
      params[:out_trade_no] = order_no
      params[:total_fee] = sum.to_i * 100
      params[:spbill_create_ip] = '58.37.81.171'
      params[:notify_url] = "#{ENV['API_URL']}/wechat/notify"
      params[:trade_type] = 'JSAPI'
      params[:openid] = open_id
      params
    end
  end
end
