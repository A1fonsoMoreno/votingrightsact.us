require "rubygems"
require "change-ruby"

class ChangePetition
  include Change::Resources

  class << self
    def sign(*args)
      new.sign(*args)
    end

    def signature_count
      new.signature_count
    end
  end

  def sign(signature)
    petition.signatures.add_signature(signatory_details_from_signature(signature))
  end

  def signature_count
    @signature_count ||= petition.properties.fetch('signature_count')
  end

  protected

  def petition
    @petition ||= begin
      petition = Petition.new(change_client)
      petition.load(petition_id)
      petition.request_auth_key({
        requester_email: requester_email,
        source: "http://votingrightsact.us",
        source_description: "Gathering signatures to help the petition"
      })
      petition
    end
  end

  def change_client
    @change_client ||= begin
      Change::Requests::Client.new({
        api_key: api_key,
        secret_token: secret_token
      })
    end
  end

  def petition_id
    ENV.fetch('CHANGE_PETITION_ID').to_i
  end

  def api_key
    ENV.fetch('CHANGE_API_ID')
  end

  def secret_token
    ENV.fetch('CHANGE_AUTH_TOKEN')
  end

  def auth_key
    ENV.fetch('CHANGE_AUTH_KEY')
  end

  def requester_email
    ENV.fetch('CHANGE_REQUESTER_EMAIL')
  end

  def signatory_details_from_signature(signature)
    {
      first_name: signature.firstname,
      last_name: signature.lastname,
      email: signature.email,
      city: signature.city,
      postal_code: signature.zipcode,
      country_code: 'US'
    }
  end
end