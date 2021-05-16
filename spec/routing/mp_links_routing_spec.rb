require "rails_helper"

RSpec.describe MpLinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/mp_links").to route_to("mp_links#index")
    end

    it "routes to #new" do
      expect(:get => "/mp_links/new").to route_to("mp_links#new")
    end

    it "routes to #show" do
      expect(:get => "/mp_links/1").to route_to("mp_links#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mp_links/1/edit").to route_to("mp_links#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/mp_links").to route_to("mp_links#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mp_links/1").to route_to("mp_links#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mp_links/1").to route_to("mp_links#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mp_links/1").to route_to("mp_links#destroy", :id => "1")
    end
  end
end
