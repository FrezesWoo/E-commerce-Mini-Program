class CustomerCreateWorker
  include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options queue: 'default'

  def perform(phone)
    template = "【资生堂官方商城】感谢您注册成为资生堂官方精品店会员。您将尊享100%正品保障，获取最新产品资讯与官方独家特惠信息。"
    sms = Sms::Shgmnets.new()
    sms.send_sms(phone, [], template)
  end
end
