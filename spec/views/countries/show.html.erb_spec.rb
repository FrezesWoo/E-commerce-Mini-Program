require 'rails_helper'

RSpec.describe "countries/show", type: :view do
  before(:each) do
    @country = assign(:country, Country.create!(
      :name => "Name",
      :latitude => 2.5,
      :longitude => 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
  end
end
