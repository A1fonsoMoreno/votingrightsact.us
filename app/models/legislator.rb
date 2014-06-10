class Legislator < ActiveRecord::Base
  def self.lookup_by_zipcode(zipcode)
    legislators = Legislator.where(zipcode: zipcode)

    if legislators.blank?
      Sunlight::Legislator.all_in_zipcode(zipcode).each do |l|
        fields = {
          zipcode: zipcode,
          bioguide_id: l.bioguide_id,
          congress_office: l.congress_office,
          congresspedia_url: l.congresspedia_url,
          district: l.district,
          email: l.email,
          facebook_id: l.facebook_id,
          fax: l.fax,
          fec_id: l.fec_id,
          firstname: l.firstname,
          gender: l.gender,
          govtrack_id: l.govtrack_id,
          lastname: l.lastname,
          party: l.party,
          phone: l.phone,
          senate_class: l.senate_class,
          state: l.state,
          title: l.title,
          twitter_id: l.twitter_id,
          votesmart_id: l.votesmart_id,
          webform: l.webform,
          website: l.website,
          youtube_url: l.youtube_url
        }

        fields['body'] = "house"  if l.website.include? "house.gov"
        fields['body'] = "senate" if l.website.include? "senate.gov"
        legislators << Legislator.create!(fields)
      end
    end

    legislators.select { |l| l.body.eql?("house") }
  end

  def image
    "/assets/legislators/#{self.bioguide_id}.jpg"
  end
end