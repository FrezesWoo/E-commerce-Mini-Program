require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :gender => 2,
      :name => "Name",
      :open_id => "Open",
      :union_id => "Union",
      :wechat_data => "",
      :email => "Email",
      :phone => "Phone",
      :avatar => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Open/)
    expect(rendered).to match(/Union/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(//)
  end
end
