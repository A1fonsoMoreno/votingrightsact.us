class AddBodyToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :body, :string
  end
end
