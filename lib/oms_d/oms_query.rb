require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'securerandom'
require 'rest-client'

module OmsD
  class OmsQuery < OmsD::OmsSign
    def initialize
      @oms_app_key = ENV['OMS_APP_KEY']
      @aes_key = ENV['OMS_AES_KEY']
      @oms_app_secret = ENV['OMS_APP_SECRET']
      @oms_base_url = ENV["OMS_BASE_URL"]
      # douyin config
      @oms_douyin_app_key = ENV['OMS_DOUYIN_APP_KEY']
      @oms_douyin_app_secret = ENV['OMS_DOUYIN_APP_SECRET']
      @douyin_aes_key = ENV['OMS_DOUYIN_AES_KEY']
    end

    def create_order(order_id)
      order = ::Order.find(order_id)
      params = Hash.new()
      params['order_bn'] = order.order_number
      params['shop_id'] = order.source == "wechat" ? "8e50673b386d7645318b8e93f22032cc" : "4c54a42d295fb3680912ab2bc894d90c"
      params['createtime'] = order.created_at.to_i.to_s
      params['paytime'] = order.payment_info && order.payment_info.created_at.to_i.to_s
      params['pay_bn'] = order.payment_method == 'alipay' ? 'alipay' : 'wechatpay'
      params['pay'] = order.total_price + order.get_delivery
      params['trade_no'] = order.payment_info && order.payment_info.transaction_id
      params['cost_freight'] = order.get_delivery
      params['order_memo'] = ''
      params['address_id'] = "#{order.province}-#{order.city}-#{order.area}"
      params['order_refer_source'] = 'ecmp'
      params['is_tax'] = order.need_invoice || 'false'
      params['has_gift_message'] = 'false'
      params['wechat_openid'] = order.source == "wechat" ? order.customer.open_id : order.douyin_customer.open_id
      params['products'] = order.gather_product_info
      params['consignee'] = order.gather_address
      params['account'] = order.source == "wechat" ? order.customer.gather_account_info : order.douyin_customer.gather_account_info
      params['invoice'] = order.gather_invoice if order.need_invoice
      params['has_gift_message'] = order.has_gift_message if order.has_gift_message
      params['gift_from'] = order.gift_card.from if order.has_gift_message && order.gift_card
      params['gift_to'] = order.gift_card.to if order.has_gift_message && order.gift_card
      params['gift_message'] = order.gift_card.content if order.has_gift_message && order.gift_card
      params['logi_name'] = order.need_trial ? 'ZTO' : order.shipping_company
      res = build_post_query("index.php/mp/service", params, 'order.add', order.source)
      res
    end

    def get_tracking(params, source)
      res = build_post_query("index.php/mp/service", params, 'waybill.update', source)
      res
    end

    def get_inventory
      res = build_post_query("index.php/mp/service", {}, 'stock.update', source)
      res
    end

    private

    def set_req_header(req, uri)
      req["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
      req["Content-Type"] = 'application/x-www-form-urlencoded'
      req["Content-Type"] = 'application/json'
      req['Host'] = uri.host
      req
    end

    def set_params(method, query_params, source)
      params = Hash.new()
      params["appkey"] = source == "wechat" ? @oms_app_key : @oms_douyin_app_key
      params["method"] = method
      params["timestamp"] = Time.now.utc.to_i
      params["random"] = SecureRandom.alphanumeric(8)
      params["format"] = "json"
      params["version"] = "1.0"
      params['params'] = self.encrypt_params(query_params, source)
      params["sign"] = self.get_sign(params, source)
      params
    end

    def build_post_query(url, params, method, source)
      uri = URI.parse("#{@oms_base_url}#{url}")
      https = Net::HTTP.new(uri.host, uri.port, nil,nil)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE if https.use_ssl?
      req = Net::HTTP::Post.new(uri.path)
      req = set_req_header(req, uri)
      req.set_form_data(set_params(method, params, source))
      puts '##################### WE ARE TRYING to debug OMS FOR'
      puts uri
      puts params
      puts '$$$$$$$$$$$$ And the response is'
      res = https.request(req)
      puts res.body
      JSON.parse(res.body)
    end
  end
end
