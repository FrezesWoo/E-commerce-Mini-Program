require 'rails_helper'

RSpec.describe "mp_links/index", type: :view do
  before(:each) do
    assign(:mp_links, [
      MpLink.create!(
        :name => "Name",
        :param => "Param",
        :path => "Path"
      ),
      MpLink.create!(
        :name => "Name",
        :param => "Param",
        :path => "Path"
      )
    ])
  end

  it "renders a list of mp_links" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Param".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
