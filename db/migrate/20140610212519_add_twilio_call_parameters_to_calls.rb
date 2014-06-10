class AddTwilioCallParametersToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :sid, :string
    add_column :calls, :ended, :boolean
    add_column :calls, :call_duration, :integer
  end
end
