require 'rails_helper'

RSpec.describe "page_blocks/show", type: :view do
  before(:each) do
    @page_block = assign(:page_block, PageBlock.create!(
      :template => 2,
      :name => "Name",
      :created_by_id => 3,
      :updated_by_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
