class AddSecureKeyToSignatures < ActiveRecord::Migration
  def change
    add_column :signatures, :secure_key, :string
  end
end
