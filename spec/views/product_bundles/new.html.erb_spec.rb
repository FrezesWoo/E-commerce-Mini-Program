require 'rails_helper'

RSpec.describe "product_bundles/new", type: :view do
  before(:each) do
    assign(:product_bundle, ProductBundle.new(
      :name => "MyString",
      :condition => 1,
      :price => 1.5,
      :price_condition => 1.5,
      :product_sku => nil
    ))
  end

  it "renders new product_bundle form" do
    render

    assert_select "form[action=?][method=?]", product_bundles_path, "post" do

      assert_select "input[name=?]", "product_bundle[name]"

      assert_select "input[name=?]", "product_bundle[condition]"

      assert_select "input[name=?]", "product_bundle[price]"

      assert_select "input[name=?]", "product_bundle[price_condition]"

      assert_select "input[name=?]", "product_bundle[product_sku_id]"
    end
  end
end
