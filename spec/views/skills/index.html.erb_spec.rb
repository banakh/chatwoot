require 'rails_helper'

RSpec.describe "skills/index", type: :view do
  before(:each) do
    assign(:skills, [
      Skill.create!(
        account: nil,
        skill: "Skill",
        routing_weight: 2,
        threshold: 3,
        self_administered: false
      ),
      Skill.create!(
        account: nil,
        skill: "Skill",
        routing_weight: 2,
        threshold: 3,
        self_administered: false
      )
    ])
  end

  it "renders a list of skills" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Skill".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
