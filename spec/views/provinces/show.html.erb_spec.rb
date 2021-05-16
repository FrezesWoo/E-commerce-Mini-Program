require 'rails_helper'

RSpec.describe "provinces/show", type: :view do
  before(:each) do
    @province = assign(:province, Province.create!(
      :name => "Name",
      :latitude => 2.5,
      :longitude => 3.5,
      :country => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(//)
  end
end
