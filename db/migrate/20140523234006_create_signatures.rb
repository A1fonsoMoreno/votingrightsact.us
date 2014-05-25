class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :zipcode
      t.text :change_org_error

      t.timestamps
    end
  end
end
