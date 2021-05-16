require 'rails_helper'

RSpec.describe "mp_links/new", type: :view do
  before(:each) do
    assign(:mp_link, MpLink.new(
      :name => "MyString",
      :param => "MyString",
      :path => "MyString"
    ))
  end

  it "renders new mp_link form" do
    render

    assert_select "form[action=?][method=?]", mp_links_path, "post" do

      assert_select "input[name=?]", "mp_link[name]"

      assert_select "input[name=?]", "mp_link[param]"

      assert_select "input[name=?]", "mp_link[path]"
    end
  end
end
