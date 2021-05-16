require 'rails_helper'

RSpec.describe "product_attributes/new", type: :view do
  before(:each) do
    assign(:product_attribute, ProductAttribute.new(
      :name => "MyString",
      :value => "MyString",
      :picture => "",
      :product_attribute_category => nil
    ))
  end

  it "renders new product_attribute form" do
    render

    assert_select "form[action=?][method=?]", product_attributes_path, "post" do

      assert_select "input[name=?]", "product_attribute[name]"

      assert_select "input[name=?]", "product_attribute[value]"

      assert_select "input[name=?]", "product_attribute[picture]"

      assert_select "input[name=?]", "product_attribute[product_attribute_category_id]"
    end
  end
end
