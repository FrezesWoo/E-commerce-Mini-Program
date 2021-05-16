require 'rails_helper'

RSpec.describe "provinces/new", type: :view do
  before(:each) do
    assign(:province, Province.new(
      :name => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :country => nil
    ))
  end

  it "renders new province form" do
    render

    assert_select "form[action=?][method=?]", provinces_path, "post" do

      assert_select "input[name=?]", "province[name]"

      assert_select "input[name=?]", "province[latitude]"

      assert_select "input[name=?]", "province[longitude]"

      assert_select "input[name=?]", "province[country_id]"
    end
  end
end
