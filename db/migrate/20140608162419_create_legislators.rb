class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :zipcode
      t.text :representation

      t.timestamps
    end

    add_index :legislators, :zipcode
  end
end
