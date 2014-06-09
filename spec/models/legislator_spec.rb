require "spec_helper"

GOOGLE_CIVIC_CLIENT = Object.new

describe Legislator do
  describe ".lookup_by_zipcode" do
    let(:zipcode) { "12345" }
    let(:legislator) { double(:legislator) }
    let(:legislators) { [legislator, legislator] }
    let(:blank_array) { [] }

    it "creates a new Legislator" do
      expect(GOOGLE_CIVIC_CLIENT).to receive(:representative_info).with(zipcode).and_return(legislator)
      expect(described_class.lookup_by_zipcode(zipcode)).not_to be_nil
    end
  end
end
