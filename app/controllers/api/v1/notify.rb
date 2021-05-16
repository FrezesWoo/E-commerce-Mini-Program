# encoding: utf-8

module API
  module V1
    class Notify < Grape::API
      content_type :xml, 'text/xml'
      format :xml
      prefix "api"
      version "v1", using: :path
      formatter :xml, lambda { |object, env| object.to_xml(root: 'xml', dasherize: false) }

      resource :wechat do

        desc "notify an order"
        post "notify", root: :wechat do
          result = params["xml"]
          order = Order.where(order_number: result['out_trade_no']).first!
          status 200
          if WxPay::Sign.verify?(result)
            order.update_sku_quantity if order.status == 'unpaid'
            order.order_paid(result, 'wechat')
            return {return_code: "SUCCESS"}
          else
            order.order_failed(result, 'wechat')
            return {return_code: "FAIL", return_msg: "签名失败"}
          end
        end
      end
    end
  end
end
