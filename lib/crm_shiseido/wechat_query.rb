require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'digest/md5'

module CrmShiseido
  class WechatQuery
    def initialize
      @crm_wechat_path = ENV["CRM_WECHAT_PATH"]
      @crm_sys_code = ENV["CRM_SYS_CODE"]
      @crm_wechat_sys_key = ENV["CRM_WECHAT_SYS_KEY"]
      @crm_wechat_url = ENV["CRM_WECHAT_URL"]
    end

    def generate_signature(timestamp)
      souce_string = @crm_sys_code + "&" + timestamp + "&" + @crm_wechat_sys_key
      Digest::MD5.hexdigest(souce_string.force_encoding('UTF-8')).upcase
    end

    def get_access_token()
      timestamp = Time.now.getlocal.strftime("%Y%m%d%H%M%S")
      url = "#{@crm_wechat_path}?syscode=#{@crm_sys_code}&timestamp=#{timestamp}&signature=#{generate_signature(timestamp)}"
      res = build_request_query(url)
      res["access_token"]
    end

    def set_req_header(req, uri)
      req["Content-Type"] = 'application/json'
      req['Host'] = uri.host
      req
    end

    def build_request_query(url)
      uri = URI.parse("#{@crm_wechat_url}#{url}")
      http = Net::HTTP.new(uri.host, uri.port, nil, nil)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      resp = JSON.parse(response.body)
      resp
    end
  end
end
