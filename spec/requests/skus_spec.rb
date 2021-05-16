require 'rails_helper'

RSpec.describe "Skus", type: :request do
  describe "GET /skus" do
    it "works! (now write some real specs)" do
      get skus_path
      expect(response).to have_http_status(200)
    end
  end
end
