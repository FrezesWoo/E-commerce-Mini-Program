require 'rails_helper'

RSpec.describe "product_attribute_cateogries/edit", type: :view do
  before(:each) do
    @product_attribute_cateogry = assign(:product_attribute_cateogry, ProductAttributeCateogry.create!(
      :name => "MyString",
      :picture => ""
    ))
  end

  it "renders the edit product_attribute_cateogry form" do
    render

    assert_select "form[action=?][method=?]", product_attribute_cateogry_path(@product_attribute_cateogry), "post" do

      assert_select "input[name=?]", "product_attribute_cateogry[name]"

      assert_select "input[name=?]", "product_attribute_cateogry[picture]"
    end
  end
end
