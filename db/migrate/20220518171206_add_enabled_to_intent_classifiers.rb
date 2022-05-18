class AddEnabledToIntentClassifiers < ActiveRecord::Migration[6.1]
  def change
    add_column :intent_classifiers, :enabled, :boolean , default: true
  end
end
