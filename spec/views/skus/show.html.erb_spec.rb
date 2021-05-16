require 'rails_helper'

RSpec.describe "skus/show", type: :view do
  before(:each) do
    @sku = assign(:sku, Sku.create!(
      :price => 2.5,
      :product => nil,
      :shipping_price => 3.5,
      :currency => 4,
      :description => "MyText",
      :composition => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
