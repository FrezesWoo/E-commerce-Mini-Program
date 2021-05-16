require 'rails_helper'

RSpec.describe "page_blocks/new", type: :view do
  before(:each) do
    assign(:page_block, PageBlock.new(
      :template => 1,
      :name => "MyString",
      :created_by_id => 1,
      :updated_by_id => 1
    ))
  end

  it "renders new page_block form" do
    render

    assert_select "form[action=?][method=?]", page_blocks_path, "post" do

      assert_select "input[name=?]", "page_block[template]"

      assert_select "input[name=?]", "page_block[name]"

      assert_select "input[name=?]", "page_block[created_by_id]"

      assert_select "input[name=?]", "page_block[updated_by_id]"
    end
  end
end
