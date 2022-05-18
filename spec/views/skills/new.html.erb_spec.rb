require 'rails_helper'

RSpec.describe "skills/new", type: :view do
  before(:each) do
    assign(:skill, Skill.new(
      account: nil,
      skill: "MyString",
      routing_weight: 1,
      threshold: 1,
      self_administered: false
    ))
  end

  it "renders new skill form" do
    render

    assert_select "form[action=?][method=?]", skills_path, "post" do

      assert_select "input[name=?]", "skill[account_id]"

      assert_select "input[name=?]", "skill[skill]"

      assert_select "input[name=?]", "skill[routing_weight]"

      assert_select "input[name=?]", "skill[threshold]"

      assert_select "input[name=?]", "skill[self_administered]"
    end
  end
end
