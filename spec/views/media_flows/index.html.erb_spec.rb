require 'rails_helper'

RSpec.describe "media_flows/index", type: :view do
  before(:each) do
    assign(:media_flows, [
      MediaFlow.create!(
        name: "Name",
        phone_number: "Phone Number",
        sla: 2,
        tra: 3,
        account: nil
      ),
      MediaFlow.create!(
        name: "Name",
        phone_number: "Phone Number",
        sla: 2,
        tra: 3,
        account: nil
      )
    ])
  end

  it "renders a list of media_flows" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Phone Number".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
