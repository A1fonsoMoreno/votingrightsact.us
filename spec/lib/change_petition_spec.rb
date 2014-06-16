require "rubygems"
require "faker"
require "change_petition"

describe ChangePetition do
  let(:change_api_key) { "1234567890" }
  let(:change_secret_token) { "asdfghjkl1234567890" }
  let(:change_petition_id) { "987654321" }
  let(:change_client) { double(:change_client) }
  let(:signatures_collection) { double(:signatures_collection) }
  let(:signature_firstname) { Faker::Name.first_name }
  let(:signature_lastname)  { Faker::Name.last_name }
  let(:signature_email)  { Faker::Internet.free_email }
  let(:signature_zipcode) { Faker::Address.zip_code }
  let(:signature) {
    double(:signature, {
      firstname: signature_firstname,
      lastname: signature_lastname,
      email: signature_email,
      zipcode: signature_zipcode
    })
  }

  let(:petition) {
    double(:petition, {
      signatures: signatures_collection
    })
  }

  def stub_env_vars
    allow(ENV).to receive(:fetch).with('CHANGE_API_ID').and_return(change_api_key)
    allow(ENV).to receive(:fetch).with('CHANGE_AUTH_TOKEN').and_return(change_secret_token)
    allow(ENV).to receive(:fetch).with('CHANGE_PETITION_ID').and_return(change_petition_id)
  end

  def stub_petition
    allow(described_class::Petition).to receive(:new).and_return(petition)
    allow(petition).to receive(:load)
  end

  def stub_change_client
    allow(Change::Requests::Client).to receive(:new).with({ api_key: change_api_key, secret_token: change_secret_token }).and_return(change_client)
  end

  before do
    stub_env_vars
    stub_petition
    stub_change_client
  end

  describe "#sign" do
    context "when an exception is not thrown" do
      it do
        expect(petition).to receive(:load).with(change_petition_id.to_i)
        expect(signatures_collection).to receive(:add_signature).with({
          firstname: signature_firstname,
          lastname: signature_lastname,
          email: signature_email,
          postal_code: signature_zipcode,
          country_code: 'US'
        }, change_secret_token)

        described_class.sign(signature)
      end

      it do
        expect(Change::Requests::Client).to receive(:new).once
        expect(signatures_collection).to receive(:add_signature)

        described_class.sign(signature)
      end
    end
  end

  describe "#signature_count" do
    let(:signature_count) { 2 }
    let(:properties) {
      { 'signature_count' => signature_count }
    }

    def stub_properties
      allow(petition).to receive(:properties).and_return(properties)
    end

    before { stub_properties }

    it { expect(described_class.signature_count).to eq signature_count }
  end
end