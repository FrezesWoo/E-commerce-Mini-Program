require 'rails_helper'

RSpec.describe "page_blocks/index", type: :view do
  before(:each) do
    assign(:page_blocks, [
      PageBlock.create!(
        :template => 2,
        :name => "Name",
        :created_by_id => 3,
        :updated_by_id => 4
      ),
      PageBlock.create!(
        :template => 2,
        :name => "Name",
        :created_by_id => 3,
        :updated_by_id => 4
      )
    ])
  end

  it "renders a list of page_blocks" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
