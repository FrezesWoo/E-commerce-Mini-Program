require "rails_helper"

RSpec.describe ProductAttributeCateogriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/product_attribute_cateogries").to route_to("product_attribute_cateogries#index")
    end

    it "routes to #new" do
      expect(:get => "/product_attribute_cateogries/new").to route_to("product_attribute_cateogries#new")
    end

    it "routes to #show" do
      expect(:get => "/product_attribute_cateogries/1").to route_to("product_attribute_cateogries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_attribute_cateogries/1/edit").to route_to("product_attribute_cateogries#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/product_attribute_cateogries").to route_to("product_attribute_cateogries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/product_attribute_cateogries/1").to route_to("product_attribute_cateogries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/product_attribute_cateogries/1").to route_to("product_attribute_cateogries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_attribute_cateogries/1").to route_to("product_attribute_cateogries#destroy", :id => "1")
    end
  end
end
