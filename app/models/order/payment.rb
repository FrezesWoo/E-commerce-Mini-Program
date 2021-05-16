class Order::Payment < ApplicationRecord
  belongs_to :order

  enum status: { in_process: 0, success: 1, failed: 2 }
  enum payment_type: { wechat_mp: 0, wechat_h5: 1, alipay: 2 }
end
