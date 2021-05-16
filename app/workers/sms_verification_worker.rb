class SmsVerificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options queue: 'default'

  def perform(phone)
    code = rand(100000..1000000)
    expired_at = Time.now + 2*60
    template = "【资生堂官方商城】请输入验证码%s完成会员注册。（2分钟内有效）"
    SmsVerification.create(code: code, expired_at: expired_at, phone: phone)
    sms = Sms::Shgmnets.new()
    sms.send_sms(phone, [code], template)
  end
end
