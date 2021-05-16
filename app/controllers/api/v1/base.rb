require "grape-swagger"

module API
  module V1
    class Base < Grape::API
      mount API::V1::Products
      mount API::V1::Product::Skus
      mount API::V1::Product::Categories
      mount API::V1::Package::Categories
      mount API::V1::Verifications
      mount API::V1::Customers
      mount API::V1::Customer::Orders
      mount API::V1::Notify
      mount API::V1::Message
      mount API::V1::Pages
      mount API::V1::Bundles
      mount API::V1::DeliveryFees
      mount API::V1::GiftCards
      mount API::V1::Product::Packages
      mount API::V1::Alipay

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )

    end
  end
end
