require 'rails_helper'

RSpec.describe "mp_links/edit", type: :view do
  before(:each) do
    @mp_link = assign(:mp_link, MpLink.create!(
      :name => "MyString",
      :param => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit mp_link form" do
    render

    assert_select "form[action=?][method=?]", mp_link_path(@mp_link), "post" do

      assert_select "input[name=?]", "mp_link[name]"

      assert_select "input[name=?]", "mp_link[param]"

      assert_select "input[name=?]", "mp_link[path]"
    end
  end
end
