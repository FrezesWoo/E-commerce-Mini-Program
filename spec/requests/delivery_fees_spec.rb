require 'rails_helper'

RSpec.describe "DeliveryFees", type: :request do
  describe "GET /delivery_fees" do
    it "works! (now write some real specs)" do
      get delivery_fees_path
      expect(response).to have_http_status(200)
    end
  end
end
