require 'rails_helper'

RSpec.describe "media_flows/new", type: :view do
  before(:each) do
    assign(:media_flow, MediaFlow.new(
      name: "MyString",
      phone_number: "MyString",
      sla: 1,
      tra: 1,
      account: nil
    ))
  end

  it "renders new media_flow form" do
    render

    assert_select "form[action=?][method=?]", media_flows_path, "post" do

      assert_select "input[name=?]", "media_flow[name]"

      assert_select "input[name=?]", "media_flow[phone_number]"

      assert_select "input[name=?]", "media_flow[sla]"

      assert_select "input[name=?]", "media_flow[tra]"

      assert_select "input[name=?]", "media_flow[account_id]"
    end
  end
end
