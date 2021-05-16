require 'rails_helper'

RSpec.describe "product_bundles/show", type: :view do
  before(:each) do
    @product_bundle = assign(:product_bundle, ProductBundle.create!(
      :name => "Name",
      :condition => 2,
      :price => 3.5,
      :price_condition => 4.5,
      :product_sku => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(//)
  end
end
