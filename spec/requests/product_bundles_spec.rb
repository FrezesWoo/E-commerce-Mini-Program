require 'rails_helper'

RSpec.describe "ProductBundles", type: :request do
  describe "GET /product_bundles" do
    it "works! (now write some real specs)" do
      get product_bundles_path
      expect(response).to have_http_status(200)
    end
  end
end
