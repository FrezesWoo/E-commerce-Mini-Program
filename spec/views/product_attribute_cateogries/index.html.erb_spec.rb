require 'rails_helper'

RSpec.describe "product_attribute_cateogries/index", type: :view do
  before(:each) do
    assign(:product_attribute_cateogries, [
      ProductAttributeCateogry.create!(
        :name => "Name",
        :picture => ""
      ),
      ProductAttributeCateogry.create!(
        :name => "Name",
        :picture => ""
      )
    ])
  end

  it "renders a list of product_attribute_cateogries" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
