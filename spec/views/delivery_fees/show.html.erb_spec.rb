require 'rails_helper'

RSpec.describe "delivery_fees/show", type: :view do
  before(:each) do
    @delivery_fee = assign(:delivery_fee, DeliveryFee.create!(
      :price => 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
  end
end
