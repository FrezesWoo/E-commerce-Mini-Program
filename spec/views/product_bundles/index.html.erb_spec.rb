require 'rails_helper'

RSpec.describe "product_bundles/index", type: :view do
  before(:each) do
    assign(:product_bundles, [
      ProductBundle.create!(
        :name => "Name",
        :condition => 2,
        :price => 3.5,
        :price_condition => 4.5,
        :product_sku => nil
      ),
      ProductBundle.create!(
        :name => "Name",
        :condition => 2,
        :price => 3.5,
        :price_condition => 4.5,
        :product_sku => nil
      )
    ])
  end

  it "renders a list of product_bundles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
