module API
    module Entities
        class Orders < Grape::Entity
          expose :id
          expose :status
          expose :created_at
          expose :order_number
          expose :customer, if:{ platform: 'wechat' }
          expose :douyin_customer, if:{ platform: 'douyin' }
          expose :amount
          expose :province
          expose :city
          expose :area
          expose :has_gift_message
          expose :gift_card
          expose :zip
          expose :mobile
          expose :name
          expose :address
          expose :total_price
          expose :email
          expose :get_delivery
          expose :tax_number
          expose :invoice_title
          expose :need_trial
          expose :source
          expose :payment_method
          expose :order_skus, using: API::Entities::Order::Skus
          expose :order_bundles, using: API::Entities::Order::Bundles
          expose :order_packages, using: API::Entities::Order::Packages
          expose :order_coupons, using: API::Entities::Order::Coupons
        end
    end
end
