require 'rails_helper'

RSpec.describe "customers/new", type: :view do
  before(:each) do
    assign(:customer, Customer.new(
      :gender => 1,
      :name => "MyString",
      :open_id => "MyString",
      :union_id => "MyString",
      :wechat_data => "",
      :email => "MyString",
      :phone => "MyString",
      :avatar => ""
    ))
  end

  it "renders new customer form" do
    render

    assert_select "form[action=?][method=?]", customers_path, "post" do

      assert_select "input[name=?]", "customer[gender]"

      assert_select "input[name=?]", "customer[name]"

      assert_select "input[name=?]", "customer[open_id]"

      assert_select "input[name=?]", "customer[union_id]"

      assert_select "input[name=?]", "customer[wechat_data]"

      assert_select "input[name=?]", "customer[email]"

      assert_select "input[name=?]", "customer[phone]"

      assert_select "input[name=?]", "customer[avatar]"
    end
  end
end
