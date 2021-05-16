require 'rails_helper'

RSpec.describe "product_attributes/edit", type: :view do
  before(:each) do
    @product_attribute = assign(:product_attribute, ProductAttribute.create!(
      :name => "MyString",
      :value => "MyString",
      :picture => "",
      :product_attribute_category => nil
    ))
  end

  it "renders the edit product_attribute form" do
    render

    assert_select "form[action=?][method=?]", product_attribute_path(@product_attribute), "post" do

      assert_select "input[name=?]", "product_attribute[name]"

      assert_select "input[name=?]", "product_attribute[value]"

      assert_select "input[name=?]", "product_attribute[picture]"

      assert_select "input[name=?]", "product_attribute[product_attribute_category_id]"
    end
  end
end
