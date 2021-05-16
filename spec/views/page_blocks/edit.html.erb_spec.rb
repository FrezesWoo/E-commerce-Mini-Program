require 'rails_helper'

RSpec.describe "page_blocks/edit", type: :view do
  before(:each) do
    @page_block = assign(:page_block, PageBlock.create!(
      :template => 1,
      :name => "MyString",
      :created_by_id => 1,
      :updated_by_id => 1
    ))
  end

  it "renders the edit page_block form" do
    render

    assert_select "form[action=?][method=?]", page_block_path(@page_block), "post" do

      assert_select "input[name=?]", "page_block[template]"

      assert_select "input[name=?]", "page_block[name]"

      assert_select "input[name=?]", "page_block[created_by_id]"

      assert_select "input[name=?]", "page_block[updated_by_id]"
    end
  end
end
