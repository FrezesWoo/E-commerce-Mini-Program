require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :description => "Description",
        :name => "Name",
        :note => "Note",
        :composition => "Composition",
        :product_category => nil
      ),
      Product.create!(
        :description => "Description",
        :name => "Name",
        :note => "Note",
        :composition => "Composition",
        :product_category => nil
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
    assert_select "tr>td", :text => "Composition".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
