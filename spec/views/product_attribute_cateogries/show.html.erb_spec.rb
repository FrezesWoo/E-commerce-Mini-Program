require 'rails_helper'

RSpec.describe "product_attribute_cateogries/show", type: :view do
  before(:each) do
    @product_attribute_cateogry = assign(:product_attribute_cateogry, ProductAttributeCateogry.create!(
      :name => "Name",
      :picture => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
