require 'rails_helper'

RSpec.describe "media_flows/show", type: :view do
  before(:each) do
    @media_flow = assign(:media_flow, MediaFlow.create!(
      name: "Name",
      phone_number: "Phone Number",
      sla: 2,
      tra: 3,
      account: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
