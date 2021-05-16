require 'rails_helper'

RSpec.describe "product_bundles/edit", type: :view do
  before(:each) do
    @product_bundle = assign(:product_bundle, ProductBundle.create!(
      :name => "MyString",
      :condition => 1,
      :price => 1.5,
      :price_condition => 1.5,
      :product_sku => nil
    ))
  end

  it "renders the edit product_bundle form" do
    render

    assert_select "form[action=?][method=?]", product_bundle_path(@product_bundle), "post" do

      assert_select "input[name=?]", "product_bundle[name]"

      assert_select "input[name=?]", "product_bundle[condition]"

      assert_select "input[name=?]", "product_bundle[price]"

      assert_select "input[name=?]", "product_bundle[price_condition]"

      assert_select "input[name=?]", "product_bundle[product_sku_id]"
    end
  end
end
