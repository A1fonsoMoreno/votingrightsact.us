class AddSunlightMatchedFieldsToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :bioguide_id, :string
    add_column :legislators, :title, :string
    add_column :legislators, :gender, :string
    add_column :legislators, :firstname, :string
    add_column :legislators, :lastname, :string
    add_column :legislators, :congress_office, :string
    add_column :legislators, :state, :string
    add_column :legislators, :party, :string
    add_column :legislators, :district, :string
    add_column :legislators, :senate_class, :string
    add_column :legislators, :phone, :string
    add_column :legislators, :fax, :string
    add_column :legislators, :email, :string
    add_column :legislators, :twitter_id, :string
    add_column :legislators, :votesmart_id, :string
    add_column :legislators, :website, :string
    add_column :legislators, :webform, :string
    add_column :legislators, :youtube_url, :string
    add_column :legislators, :congresspedia_url, :string
    add_column :legislators, :facebook_id, :string
    add_column :legislators, :fec_id, :string
    add_column :legislators, :govtrack_id, :string
  end
end
