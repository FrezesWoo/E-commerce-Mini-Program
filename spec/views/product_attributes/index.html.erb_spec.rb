require 'rails_helper'

RSpec.describe "product_attributes/index", type: :view do
  before(:each) do
    assign(:product_attributes, [
      ProductAttribute.create!(
        :name => "Name",
        :value => "Value",
        :picture => "",
        :product_attribute_category => nil
      ),
      ProductAttribute.create!(
        :name => "Name",
        :value => "Value",
        :picture => "",
        :product_attribute_category => nil
      )
    ])
  end

  it "renders a list of product_attributes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
