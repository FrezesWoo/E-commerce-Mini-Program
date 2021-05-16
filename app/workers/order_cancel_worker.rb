module OrderCancelWorker
  class Cancel
    include Sidekiq::Worker
    sidekiq_options retry: true
    sidekiq_options queue: 'order'

    def perform
      puts "#{Time.now}: delete unpaid orders initialize"
      orders = Order.get_to_cancel_orders
      if !orders.nil?
        orders.each do |order|
          puts "#{Time.now}: delete unpaid order (#order_number:#{order[:order_number]})"
          ::Order.find(order[:id]).destroy
        end
      end
      puts "#{Time.now}: delete unpaid orders end"
    end
  end
end