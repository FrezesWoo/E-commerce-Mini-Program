require 'rails_helper'

RSpec.describe "delivery_fees/new", type: :view do
  before(:each) do
    assign(:delivery_fee, DeliveryFee.new(
      :price => 1.5
    ))
  end

  it "renders new delivery_fee form" do
    render

    assert_select "form[action=?][method=?]", delivery_fees_path, "post" do

      assert_select "input[name=?]", "delivery_fee[price]"
    end
  end
end
