require 'rails_helper'

RSpec.describe "delivery_fees/index", type: :view do
  before(:each) do
    assign(:delivery_fees, [
      DeliveryFee.create!(
        :price => 2.5
      ),
      DeliveryFee.create!(
        :price => 2.5
      )
    ])
  end

  it "renders a list of delivery_fees" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
  end
end
