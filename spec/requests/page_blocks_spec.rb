require 'rails_helper'

RSpec.describe "PageBlocks", type: :request do
  describe "GET /page_blocks" do
    it "works! (now write some real specs)" do
      get page_blocks_path
      expect(response).to have_http_status(200)
    end
  end
end
