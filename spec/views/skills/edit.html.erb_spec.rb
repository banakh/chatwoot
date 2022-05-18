require 'rails_helper'

RSpec.describe "skills/edit", type: :view do
  before(:each) do
    @skill = assign(:skill, Skill.create!(
      account: nil,
      skill: "MyString",
      routing_weight: 1,
      threshold: 1,
      self_administered: false
    ))
  end

  it "renders the edit skill form" do
    render

    assert_select "form[action=?][method=?]", skill_path(@skill), "post" do

      assert_select "input[name=?]", "skill[account_id]"

      assert_select "input[name=?]", "skill[skill]"

      assert_select "input[name=?]", "skill[routing_weight]"

      assert_select "input[name=?]", "skill[threshold]"

      assert_select "input[name=?]", "skill[self_administered]"
    end
  end
end
