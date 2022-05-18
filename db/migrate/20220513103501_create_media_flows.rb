class CreateMediaFlows < ActiveRecord::Migration[6.1]
  def change
    create_table :media_flows do |t|
      t.string :name
      t.string :phone_number
      t.integer :sla
      t.integer :tra
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
