module API
    module Serializers
        class Orders < ActiveModel::Serializer
          attributes :id, :status, :created_at, :order_number, :province, :city, :address, :area, :zip, :customer, :douyin_customer, :name, :amount, :total_price, :email, :need_trial, :invoice_title, :tax_number, :get_delivery
          has_many :order_skus, serializer: Order::Skus
          has_many :order_bundles, serializer: Order::Bundles
          has_many :order_packages, serializer: Order::Packages
        end
    end
end
