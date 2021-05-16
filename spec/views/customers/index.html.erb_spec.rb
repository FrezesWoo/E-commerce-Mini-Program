require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(
        :gender => 2,
        :name => "Name",
        :open_id => "Open",
        :union_id => "Union",
        :wechat_data => "",
        :email => "Email",
        :phone => "Phone",
        :avatar => ""
      ),
      Customer.create!(
        :gender => 2,
        :name => "Name",
        :open_id => "Open",
        :union_id => "Union",
        :wechat_data => "",
        :email => "Email",
        :phone => "Phone",
        :avatar => ""
      )
    ])
  end

  it "renders a list of customers" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Open".to_s, :count => 2
    assert_select "tr>td", :text => "Union".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
