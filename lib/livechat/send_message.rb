require 'uri'
require 'net/http'
require 'net/https'
require 'active_support'

module Livechat
  class SendMessage
    def initialize
      @livechat_message_url = ENV['LIVECHAT_MESSAGE_URL']
      @livechat_brand = ENV['LIVECHAT_BRAND']
      @livechat_skill_group = ENV['LIVECHAT_SKILL_GROUP']
    end

    def push(params)
      puts params
      post_xml = change_params_to_xml(params)
      puts post_xml
      uri = "/livechat/chat/#{@livechat_brand}/miniProgram/sendMessage/#{@livechat_skill_group}"
      req = build_post_xml(uri, post_xml)
      req
    end

    private

    def change_params_to_xml(params)
      params.except('Encrypt').to_xml(root: 'xml', dasherize: false, skip_instruct: true, skip_types: true)
    end

    def set_req_header(req, uri)
      req["Content-Type"] = 'application/xml'
      req['Host'] = uri.host
      req
    end

    def build_post_xml(url, xml)
      uri = URI.parse("#{@livechat_message_url}#{url}")
      https = Net::HTTP.new(uri.host, uri.port, nil, nil)
      https.use_ssl = false
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE if https.use_ssl?
      req = Net::HTTP::Post.new(uri.path)
      req = set_req_header(req, uri)
      req.body = xml
      req.content_type = 'application/xml;charset=utf-8'
      res = https.request(req)
      puts '####################### We are querying this endpoint'
      puts uri
      puts res.body
      res.body
    end

  end
end
