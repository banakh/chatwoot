# == Schema Information
#
# Table name: skills
#
#  id                :bigint           not null, primary key
#  routing_weight    :integer
#  self_administered :boolean
#  skill             :string
#  threshold         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint           not null
#
# Indexes
#
#  index_skills_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Skill < ApplicationRecord
  belongs_to :account
end
