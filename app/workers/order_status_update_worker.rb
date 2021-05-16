module OrderStatusUpdateWorker
  class OrderPaid
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform(order_id)
      # template = "【资生堂官方商城】感谢您在资生堂官方精品店购物，您的订单号为%s，我们将尽快为您配送。您可以在官方精品店查询订单状态。如有任何疑问，请致电客服中心4008216076。期待您再次光临！"
      template = "【资生堂官方商城】感谢您在资生堂精品店购物，您的订单号为%s，我们将尽快为您配送。资生堂集团已启动“爱心接力 RELAY OF LOVE 项目“，您本次消费的1%将投入该爱心项目，全力支援每一个需要关怀的角落。让我们一起守护美丽中国！再次感谢您对资生堂的支持！"
      order = Order.find(order_id)
      params = [order.order_number]
      sms = Sms::Shgmnets.new()
      phone = order.source == 'wechat' ? order.customer.phone : order.douyin_customer.phone
      sms.send_sms(phone, params, template)
    end
  end

  class OrderShipped
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform(order_id)
      template = "【资生堂官方商城】您的订单%s已由顺丰（或中通）配送，运单号为：%s。您也可以在官方精品店查询订单状态，感谢您的耐心等待！如有任何疑问，请致电客服中心4008216076。"
      order = Order.find(order_id)
      params = [order.order_number, order.order_logistics.first.shipping_number]
      sms = Sms::Shgmnets.new()
      phone = order.source == 'wechat' ? order.customer.phone : order.douyin_customer.phone
      sms.send_sms(phone, params, template)
    end
  end

  class OrderReturnReceived
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform(order_id)
      template = "【资生堂官方商城】已经收到您对于订单%s的退货申请，我们将尽快为您处理。如有任何疑问，请致电客服中心4008216076。"
      order = Order.find(order_id)
      params = [order.order_number]
      sms = Sms::Shgmnets.new()
      phone = order.source == 'wechat' ? order.customer.phone : order.douyin_customer.phone
      sms.send_sms(phone, params, template)
    end
  end

  class OrderReturnRejected
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform(order_id)
      template = "【资生堂官方商城】非常抱歉，您的订单%s退货申请已被拒绝。如有任何疑问，请致电客服中心4008216076。"
      order = Order.find(order_id)
      params = [order.order_number]
      sms = Sms::Shgmnets.new()
      phone = order.source == 'wechat' ? order.customer.phone : order.douyin_customer.phone
      sms.send_sms(phone, params, template)
    end
  end

  class OrderRefunded
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform(order_id)
      template = "【资生堂官方商城】您的订单%s已完成退款，退款实际到帐日期请留意您所选付款渠道的通知。如有任何疑问，请致电客服中心4008216076。"
      order = Order.find(order_id)
      params = [order.order_number]
      sms = Sms::Shgmnets.new()
      phone = order.source == 'wechat' ? order.customer.phone : order.douyin_customer.phone
      sms.send_sms(phone, params, template)
    end
  end
end
