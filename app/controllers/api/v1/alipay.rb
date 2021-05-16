# encoding: utf-8

module API
  module V1
    class Alipay < Grape::API
      include API::V1::Defaults

      resource :alipay do
        desc "notify an order for alipay"
        post "notify" do
          order = Order.where(order_number: params['out_trade_no']).first!
          return if order.status == 'paid'
          status 200
          if params['trade_status'] == 'TRADE_SUCCESS'
            order.order_paid(params, 'alipay')
            return {return_code: "SUCCESS"}
          else
            order.order_failed(params, 'alipay')
            return {return_code: "FAIL", return_msg: "签名失败"}
          end
        end
      end
    end
  end
end
