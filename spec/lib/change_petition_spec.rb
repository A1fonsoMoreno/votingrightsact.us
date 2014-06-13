require "rubygems"
require "faker"
require "change_petition"

describe ChangePetition do
  subject(:change_petition) { ChangePetition.new }
  let(:change_api_key) { "1234567890" }
  let(:change_secret_token) { "asdfghjkl1234567890" }
  let(:change_petition_id) { "987654321" }
  let(:change_client) { double(:change_client) }
  let(:signatures_collection) { double(:signatures_collection) }
  let(:signature_first_name) { Faker::Name.first_name }
  let(:signature_last_name)  { Faker::Name.last_name }
  let(:signature_email)  { Faker::Internet.free_email }
  let(:signature_zip_code) { Faker::Address.zip_code }
  let(:signature) {
    double(:signature, {
      first_name: signature_first_name,
      last_name: signature_last_name,
      email: signature_email,
      zipcode: signature_zip_code
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
        expect(signatures_collection).to receive(:add_signature)
        change_petition.sign(signature)
      end

      it do
        expect(Change::Requests::Client).to receive(:new).once
        expect(signatures_collection).to receive(:add_signature)
        change_petition.sign(signature)
      end

    end

    context "when an exception is thrown" do
      it do
        expect(Change::Requests::Client).to receive(:new).once
        expect(signatures_collection).to receive(:add_signature).and_throw(Change::Exceptions::ChangeException)
        expect(signature).to receive(:change_org_error=)
        expect(signature).to receive(:save)
        change_petition.sign(signature)
      end
    end
  end

  describe "#signature_count" do
    let(:signature_count) { 2 }
    let(:properties) {
      { 'signature_count' => signature_count }
    }

    def stub_properties
      petition.stub(:properties).and_return(properties)
    end

    before { stub_properties }
    it { expect(change_petition.signature_count).to eq signature_count }
  end
end