require 'rails_helper'

RSpec.describe "ProductAttributeCateogries", type: :request do
  describe "GET /product_attribute_cateogries" do
    it "works! (now write some real specs)" do
      get product_attribute_cateogries_path
      expect(response).to have_http_status(200)
    end
  end
end
