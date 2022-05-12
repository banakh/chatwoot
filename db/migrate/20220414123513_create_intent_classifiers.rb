class CreateIntentClassifiers < ActiveRecord::Migration[6.1]
  def change
    create_table :intent_classifiers do |t|
      t.string :phrase
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
