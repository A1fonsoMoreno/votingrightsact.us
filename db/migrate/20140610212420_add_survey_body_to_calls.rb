class AddSurveyBodyToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :survey_body, :text
  end
end
