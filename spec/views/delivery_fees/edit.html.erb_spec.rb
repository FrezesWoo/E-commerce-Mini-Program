require 'rails_helper'

RSpec.describe "delivery_fees/edit", type: :view do
  before(:each) do
    @delivery_fee = assign(:delivery_fee, DeliveryFee.create!(
      :price => 1.5
    ))
  end

  it "renders the edit delivery_fee form" do
    render

    assert_select "form[action=?][method=?]", delivery_fee_path(@delivery_fee), "post" do

      assert_select "input[name=?]", "delivery_fee[price]"
    end
  end
end
