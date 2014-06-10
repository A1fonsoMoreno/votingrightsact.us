class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :number
      t.integer :legislator_id
      t.integer :signature_id

      t.timestamps
    end
    add_index :calls, :legislator_id
    add_index :calls, :signature_id
  end
end
