require "rails_helper"

RSpec.describe DeliveryFeesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/delivery_fees").to route_to("delivery_fees#index")
    end

    it "routes to #new" do
      expect(:get => "/delivery_fees/new").to route_to("delivery_fees#new")
    end

    it "routes to #show" do
      expect(:get => "/delivery_fees/1").to route_to("delivery_fees#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/delivery_fees/1/edit").to route_to("delivery_fees#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/delivery_fees").to route_to("delivery_fees#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/delivery_fees/1").to route_to("delivery_fees#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/delivery_fees/1").to route_to("delivery_fees#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/delivery_fees/1").to route_to("delivery_fees#destroy", :id => "1")
    end
  end
end
