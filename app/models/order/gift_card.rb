class Order::GiftCard < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :gift_card, optional: true
end
