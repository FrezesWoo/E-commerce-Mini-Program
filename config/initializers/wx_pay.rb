WxPay.appid = ENV['APPID_WECHAT_MP']
WxPay.key = ENV['WECHAT_MERCHANT_KEY']
WxPay.mch_id = ENV['WECHAT_MERCHANT_NUMBER']
WxPay.debug_mode = true # default is `true`
WxPay.sandbox_mode = false # default is `false`

# cert, see https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=4_3
# using PCKS12
# WxPay.set_apiclient_by_pkcs12(File.read(pkcs12_filepath), pass)

# if you want to use `generate_authorize_req` and `authenticate`
WxPay.appsecret = ENV['APPSECRET_WECHAT_MP']

# optional - configurations for RestClient timeout, etc.
WxPay.extra_rest_client_options = {timeout: 5, open_timeout: 6}


# WxPay.appid = ENV['APPID_WECHAT']
# WxPay.mch_id = ENV['MERCHANT_NUMBER']
# WxPay.debug_mode = true # default is `true`
# WxPay.sandbox_mode = true # default is `false`
# result = WxPay::Service.get_sandbox_signkey
# WxPay.key = result['sandbox_signkey']

# WxPay::Service.module_eval do
#   def self.get_gateway_url
#     return SANDBOX_GATEWAY_URL if WxPay.sandbox_mode?
#     ENV['GATEWAY_WECHAT_PAY']
#   end
#   def self.invoke_remote(url, payload, options = {})
#     options = WxPay.extra_rest_client_options.merge(options)
#     gateway_url = options.delete(:gateway_url) || get_gateway_url
#     url = "#{gateway_url}#{url}"
#     RestClient::Request.execute(
#       {
#         method: :post,
#         url: url,
#         payload: payload,
#         headers: { content_type: 'application/xml' }
#       }.merge(options)
#     )
#   end
#   def self.invoke_unifiedorder(params, options = {})
#      params = {
#        appid: options.delete(:appid) || WxPay.appid,
#        mch_id: options.delete(:mch_id) || WxPay.mch_id,
#        key: options.delete(:key) || WxPay.key,
#        nonce_str: SecureRandom.uuid.tr('-', '')
#      }.merge(params)
#
#      check_required_options(params, [:body, :out_trade_no, :total_fee, :spbill_create_ip, :notify_url, :trade_type])
#      r = WxPay::Result.new(Hash.from_xml(invoke_remote(ENV['GATEWAY_WECHAT_PAY_PATH'], make_payload(params), options)))
#
#      yield r if block_given?
#
#      r
#    end
# end
