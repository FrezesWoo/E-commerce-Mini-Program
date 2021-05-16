require 'uri'
require 'net/http'
require 'net/https'
require 'digest'
require 'date'
require 'openssl'
require 'active_support'

module CrmShiseido
  class Query < CrmShiseido::Sign
    def initialize
      @crm_ec_path = ENV["CRM_EC_PATH"]
      @crm_sys_code = ENV["CRM_SYS_CODE"]
      @crm_owner_id = ENV["CRM_OWNER_ID"]
      @crm_sys_key = ENV["CRM_SYS_KEY"]
      @crm_rsa_iv = ENV["CRM_RSA_IV"]
      @crm_base_url = ENV["CRM_BASE_URL"]
      # douyin config
      @crm_douyin_owner_id = ENV["CRM_DOUYIN_OWNER_ID"]
    end

    def create_new_customer(params, source)
      params["marital_status"] = "03"
      params["check_policy_status"] = 3
      params["registe_campaing_tag"] = source == "wechat" ? "ECMP" : "Douyin MP"
      params["registe_type"] = source == "wechat" ? "40" : "82 "
      req = ec_api('EC_MemberRegist', params, source)
      res = Hash.from_xml(req)["Result"]
      res['MemberNo']
    end

    def ec_api(method, post_arg, source)
      key =  @crm_sys_key
      iv = @crm_rsa_iv
      @crm_owner_id = source == "wechat" ? @crm_owner_id : @crm_douyin_owner_id
      post_arg['owner_id'] = @crm_owner_id
      post_xml = change_params_to_xml(method, post_arg)
      param = Hash.new()
      param['SysCode'] = @crm_sys_code
      param['Method'] = method
      param['OwnerId'] = @crm_owner_id
      param['PosId'] = "1"
      param['DeviceId'] = "0"
      param['Token'] = (Time.now.getlocal + 3600 * 8).strftime("%Y%m%d%H%M%S%L")
      param['Sign'] = self.generate_signature_base64(
        param['OwnerId'],
        param['PosId'],
        param['DeviceId'],
        param['Token'],
        param['SysCode'],
        ""
      )
      puts '############ params are'
      puts param, post_arg
      uri = "#{@crm_ec_path}?SysCode=#{@crm_sys_code}&OwnerId=#{@crm_owner_id}&PosId=#{param['PosId']}&DeviceId=#{param['DeviceId']}&Token=#{param['Token']}&Sign=#{CGI.escape(param['Sign'])}&Method=#{param['Method']}"
      post_string = self.encrypt_to_base64(post_xml, key, iv)
      req = build_post_xml(uri, post_string)
      sv_result= ''
      if req.index("<?xml") and req.index("<?xml") >= 0
        sv_result = req.force_encoding('UTF-8')
      else
        sv_result = self.decrypt_from_base64(req, key, iv)
      end
      puts '######## here is the decrypted result'
      puts sv_result
      puts 'we check uri', uri
      sv_result
    end

    private

    def change_params_to_xml(method, params)
      capitalize = params.transform_keys{ |key| key.capitalize.split('_').map(&:capitalize).join('') }
      capitalize.to_xml(:root => method, :dasherize => false)
    end

    def set_req_header(req, uri)
      req["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
      req["Content-Type"] = 'application/x-www-form-urlencoded'
      req["Content-Type"] = 'application/json'
      req['Host'] = uri.host
      req
    end

    def build_post_xml(url, xml)
      uri = URI.parse("#{@crm_base_url}#{url}")
      # proxy_uri = URI.parse(ENV['http_proxy'])
      # https = Net::HTTP.new(uri.host, uri.port, proxy_uri.host, proxy_uri.port)
      https = Net::HTTP.new(uri.host, uri.port, nil, nil)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE if https.use_ssl?
      req = Net::HTTP::Post.new(uri.path + '?' + uri.query)
      req = set_req_header(req, uri)
      req.body = xml
      req.content_type = 'application/x-www-form-urlencoded;charset=utf-8'
      res = https.request(req)
      puts '####################### We are querying this endpoint'
      puts uri
      # puts proxy_uri, proxy_uri.host, proxy_uri.port
      puts '########## here the encrypted result'
      puts res.body
      res.body
    end

  end
end
