require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :customer => nil,
      :order_number => "MyString",
      :status => 1,
      :address => nil,
      :fapiao => nil,
      :amount => 1.5
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input[name=?]", "order[customer_id]"

      assert_select "input[name=?]", "order[order_number]"

      assert_select "input[name=?]", "order[status]"

      assert_select "input[name=?]", "order[address_id]"

      assert_select "input[name=?]", "order[fapiao_id]"

      assert_select "input[name=?]", "order[amount]"
    end
  end
end
