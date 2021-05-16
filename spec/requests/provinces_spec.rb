require 'rails_helper'

RSpec.describe "Provinces", type: :request do
  describe "GET /provinces" do
    it "works! (now write some real specs)" do
      get provinces_path
      expect(response).to have_http_status(200)
    end
  end
end
