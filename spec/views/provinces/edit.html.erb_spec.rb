require 'rails_helper'

RSpec.describe "provinces/edit", type: :view do
  before(:each) do
    @province = assign(:province, Province.create!(
      :name => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :country => nil
    ))
  end

  it "renders the edit province form" do
    render

    assert_select "form[action=?][method=?]", province_path(@province), "post" do

      assert_select "input[name=?]", "province[name]"

      assert_select "input[name=?]", "province[latitude]"

      assert_select "input[name=?]", "province[longitude]"

      assert_select "input[name=?]", "province[country_id]"
    end
  end
end
