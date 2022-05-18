# == Schema Information
#
# Table name: intent_classifiers
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(TRUE)
#  name       :string
#  phrase     :string
#  phrases    :string           default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_intent_classifiers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class IntentClassifier < ApplicationRecord
  belongs_to :user, optional: true
end
