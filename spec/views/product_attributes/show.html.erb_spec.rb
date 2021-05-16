require 'rails_helper'

RSpec.describe "product_attributes/show", type: :view do
  before(:each) do
    @product_attribute = assign(:product_attribute, ProductAttribute.create!(
      :name => "Name",
      :value => "Value",
      :picture => "",
      :product_attribute_category => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
