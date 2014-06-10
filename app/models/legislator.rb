class Legislator < ActiveRecord::Base

  has_many :calls

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

  def image_url
    "/assets/legislators/#{self.bioguide_id}.jpg"
  end

  def fullname
    [self.firstname, self.lastname].compact.join(' ')
  end

  def twitter_url
    "https://twitter.com/#{self.twitter_id}" if self.twitter_id.present?
  end

  def facebook_url
    "https://facebook.com/#{self.facebook_id}" if self.facebook_id.present?
  end

  def as_json(opts={})
    {
      id: self.id,
      fullname: self.fullname,
      congress_office: self.congress_office,
      congresspedia_url: self.congresspedia_url,
      district: self.district,
      email: self.email,
      facebook_url: self.facebook_url,
      fax: self.fax,
      fec_id: self.fec_id,
      firstname: self.firstname,
      gender: self.gender,
      govtrack_id: self.govtrack_id,
      lastname: self.lastname,
      party: self.party,
      phone: self.phone,
      senate_class: self.senate_class,
      state: self.state,
      title: self.title,
      twitter_url: self.twitter_url,
      twitter_id: self.twitter_id,
      webform: self.webform,
      website: self.website,
      youtube_url: self.youtube_url,
      image_url: self.image_url
    }
  end
end