require 'rails_helper'

RSpec.describe "media_flows/edit", type: :view do
  before(:each) do
    @media_flow = assign(:media_flow, MediaFlow.create!(
      name: "MyString",
      phone_number: "MyString",
      sla: 1,
      tra: 1,
      account: nil
    ))
  end

  it "renders the edit media_flow form" do
    render

    assert_select "form[action=?][method=?]", media_flow_path(@media_flow), "post" do

      assert_select "input[name=?]", "media_flow[name]"

      assert_select "input[name=?]", "media_flow[phone_number]"

      assert_select "input[name=?]", "media_flow[sla]"

      assert_select "input[name=?]", "media_flow[tra]"

      assert_select "input[name=?]", "media_flow[account_id]"
    end
  end
end
