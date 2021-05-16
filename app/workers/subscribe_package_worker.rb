class SubscribePackageWorker
  include ApplicationHelper
  include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options queue: 'default'

  def perform
    package_subscriptions = ::PackageSubscription.all

    if !package_subscriptions.empty?
      sms = Sms::Shgmnets.new()
      template = "【资生堂官方商城】您的订阅%s已完成补货。如有任何疑问，请致电客服中心：400-821-6076。"

      package_subscriptions.each do |package_subscription|
        package = ::Product::Package.find(package_subscription.product_package_id)
        if !package.need_subscribe
          customer = ::Customer.find(package_subscription.customer_id)
          sms.send_sms(customer.phone, [package.name], template)
          package_subscription.destroy
        end
      end
    end
  end
end
