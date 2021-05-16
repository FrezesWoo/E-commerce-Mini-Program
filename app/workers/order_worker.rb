class OrderWorker
  include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options queue: 'order'

  def perform(order_id)
    products = ::OmsD::OmsQuery.new()
    sync = products.create_order(order_id)
    order = Order.find(order_id)
    order.update({is_synced: true}) if sync["code"] == 200
    # order.is_synced = true if sync["code"] == 200
  end
end
