require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :description => "MyString",
      :name => "MyString",
      :note => "MyString",
      :composition => "MyString",
      :product_category => nil
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input[name=?]", "product[description]"

      assert_select "input[name=?]", "product[name]"

      assert_select "input[name=?]", "product[note]"

      assert_select "input[name=?]", "product[composition]"

      assert_select "input[name=?]", "product[product_category_id]"
    end
  end
end
