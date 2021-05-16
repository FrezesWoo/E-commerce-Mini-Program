class ProductImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options queue: 'default'

  def perform(params)
    puts "#{Time.now}: upload wechat product initializing..."
    puts params
    puts "#{Time.now}: upload wechat product end..."
    wechat = ::WechatTool::Mp.new()
    wechat.import_product(params)
  end
end
