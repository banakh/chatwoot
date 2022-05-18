# == Schema Information
#
# Table name: media_flows
#
#  id           :bigint           not null, primary key
#  name         :string
#  phone_number :string
#  sla          :integer
#  tra          :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint           not null
#
# Indexes
#
#  index_media_flows_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class MediaFlow < ApplicationRecord
  belongs_to :account
end
