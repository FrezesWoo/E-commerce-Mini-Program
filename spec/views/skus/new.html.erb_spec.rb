require 'rails_helper'

RSpec.describe "skus/new", type: :view do
  before(:each) do
    assign(:sku, Sku.new(
      :price => 1.5,
      :product => nil,
      :shipping_price => 1.5,
      :currency => 1,
      :description => "MyText",
      :composition => "MyText"
    ))
  end

  it "renders new sku form" do
    render

    assert_select "form[action=?][method=?]", skus_path, "post" do

      assert_select "input[name=?]", "sku[price]"

      assert_select "input[name=?]", "sku[product_id]"

      assert_select "input[name=?]", "sku[shipping_price]"

      assert_select "input[name=?]", "sku[currency]"

      assert_select "textarea[name=?]", "sku[description]"

      assert_select "textarea[name=?]", "sku[composition]"
    end
  end
end
