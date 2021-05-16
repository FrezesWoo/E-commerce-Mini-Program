require "rails_helper"

RSpec.describe SkusController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/skus").to route_to("skus#index")
    end

    it "routes to #new" do
      expect(:get => "/skus/new").to route_to("skus#new")
    end

    it "routes to #show" do
      expect(:get => "/skus/1").to route_to("skus#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/skus/1/edit").to route_to("skus#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/skus").to route_to("skus#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/skus/1").to route_to("skus#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/skus/1").to route_to("skus#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/skus/1").to route_to("skus#destroy", :id => "1")
    end
  end
end
