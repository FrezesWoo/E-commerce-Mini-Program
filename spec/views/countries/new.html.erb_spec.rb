require 'rails_helper'

RSpec.describe "countries/new", type: :view do
  before(:each) do
    assign(:country, Country.new(
      :name => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders new country form" do
    render

    assert_select "form[action=?][method=?]", countries_path, "post" do

      assert_select "input[name=?]", "country[name]"

      assert_select "input[name=?]", "country[latitude]"

      assert_select "input[name=?]", "country[longitude]"
    end
  end
end
