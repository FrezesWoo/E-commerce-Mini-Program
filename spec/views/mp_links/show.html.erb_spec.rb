require 'rails_helper'

RSpec.describe "mp_links/show", type: :view do
  before(:each) do
    @mp_link = assign(:mp_link, MpLink.create!(
      :name => "Name",
      :param => "Param",
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Param/)
    expect(rendered).to match(/Path/)
  end
end
