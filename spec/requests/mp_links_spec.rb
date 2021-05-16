require 'rails_helper'

RSpec.describe "MpLinks", type: :request do
  describe "GET /mp_links" do
    it "works! (now write some real specs)" do
      get mp_links_path
      expect(response).to have_http_status(200)
    end
  end
end
