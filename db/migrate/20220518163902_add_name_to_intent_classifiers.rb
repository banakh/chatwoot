class AddNameToIntentClassifiers < ActiveRecord::Migration[6.1]
  def change
    add_column :intent_classifiers, :name, :string
    add_column :intent_classifiers, :app_id, :string
  end

  def up
    change_column :intent_classifiers, :phrase, :string, array: true, default: [], using: "(string_to_array(phrase, ','))"
  end

  def down
    change_column :intent_classifiers, :phrase, :string, array: false, default: nil, using: "(array_to_string(phrase, ','))"
  end
end
