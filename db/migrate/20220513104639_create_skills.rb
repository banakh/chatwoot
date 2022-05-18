class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.references :account, null: false, foreign_key: true
      t.string :skill
      t.integer :routing_weight
      t.integer :threshold
      t.boolean :self_administered

      t.timestamps
    end
  end
end
