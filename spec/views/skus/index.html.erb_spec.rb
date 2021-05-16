require 'rails_helper'

RSpec.describe "skus/index", type: :view do
  before(:each) do
    assign(:skus, [
      Sku.create!(
        :price => 2.5,
        :product => nil,
        :shipping_price => 3.5,
        :currency => 4,
        :description => "MyText",
        :composition => "MyText"
      ),
      Sku.create!(
        :price => 2.5,
        :product => nil,
        :shipping_price => 3.5,
        :currency => 4,
        :description => "MyText",
        :composition => "MyText"
      )
    ])
  end

  it "renders a list of skus" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
