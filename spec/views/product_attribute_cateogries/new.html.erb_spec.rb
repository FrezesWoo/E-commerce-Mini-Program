require 'rails_helper'

RSpec.describe "product_attribute_cateogries/new", type: :view do
  before(:each) do
    assign(:product_attribute_cateogry, ProductAttributeCateogry.new(
      :name => "MyString",
      :picture => ""
    ))
  end

  it "renders new product_attribute_cateogry form" do
    render

    assert_select "form[action=?][method=?]", product_attribute_cateogries_path, "post" do

      assert_select "input[name=?]", "product_attribute_cateogry[name]"

      assert_select "input[name=?]", "product_attribute_cateogry[picture]"
    end
  end
end
