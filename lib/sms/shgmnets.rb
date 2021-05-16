require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'digest/md5'
require 'base64'

module Sms
  class Shgmnets
    def initialize
      @api_base_url = ENV['SMS_BASE_URL']
      @api_base_user = ENV['SMS_API_USER']
      @api_base_password = ENV['SMS_API_PASSWORD']
    end

    def send_sms(phone, params, template)
      params.each do |param|
        template.sub!(/%s/, param.to_s)
      end
      puts 'The message is ', template
      params = {
        'account': @api_base_user,
        'password': @api_base_password,
        'msg': template.force_encoding('UTF-8'),
        'phone': phone,
        'report': true
      }
      res = build_post_query(params)
      res
    end

    def set_req_header(req, uri)
      req["Content-Type"] = 'application/json'
      req['Host'] = uri.host
      req
    end

    def build_post_query(params)
      uri = URI.parse("#{@api_base_url}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE if https.use_ssl?
      req = Net::HTTP::Post.new(uri.path)
      req = set_req_header(req, uri)
      req.body = params.to_json
      res = https.request(req)
      puts 'testing the sms for avrato'
      puts uri
      puts 'the response is'
      puts res.body
      # JSON.parse(res.body)
    end
  end
end
