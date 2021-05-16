require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :description => "Description",
      :name => "Name",
      :note => "Note",
      :composition => "Composition",
      :product_category => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Note/)
    expect(rendered).to match(/Composition/)
    expect(rendered).to match(//)
  end
end
