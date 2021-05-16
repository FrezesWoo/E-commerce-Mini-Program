require 'rails_helper'

RSpec.describe "provinces/index", type: :view do
  before(:each) do
    assign(:provinces, [
      Province.create!(
        :name => "Name",
        :latitude => 2.5,
        :longitude => 3.5,
        :country => nil
      ),
      Province.create!(
        :name => "Name",
        :latitude => 2.5,
        :longitude => 3.5,
        :country => nil
      )
    ])
  end

  it "renders a list of provinces" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
