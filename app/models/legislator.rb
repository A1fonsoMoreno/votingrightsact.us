class Legislator < ActiveRecord::Base
  def self.lookup_by_zipcode(zipcode)
    GOOGLE_CIVIC_CLIENT.representative_info(zipcode)
  end
end
