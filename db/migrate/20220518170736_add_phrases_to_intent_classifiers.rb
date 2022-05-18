class AddPhrasesToIntentClassifiers < ActiveRecord::Migration[6.1]
  def change
    add_column :intent_classifiers, :phrases, :string, array: true, default: []
  end
end
