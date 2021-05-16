require "rails_helper"

RSpec.describe PageBlocksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/page_blocks").to route_to("page_blocks#index")
    end

    it "routes to #new" do
      expect(:get => "/page_blocks/new").to route_to("page_blocks#new")
    end

    it "routes to #show" do
      expect(:get => "/page_blocks/1").to route_to("page_blocks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/page_blocks/1/edit").to route_to("page_blocks#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/page_blocks").to route_to("page_blocks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/page_blocks/1").to route_to("page_blocks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/page_blocks/1").to route_to("page_blocks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/page_blocks/1").to route_to("page_blocks#destroy", :id => "1")
    end
  end
end
