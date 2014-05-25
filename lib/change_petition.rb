require "change-ruby"

class ChangePetition
  include Change::Resources

  def sign(signature)
    petition.signatures.add_signature signatory_details_from_signature signature
  # rescue Change::Exceptions::ChangeException => e
  #   signature.change_org_error = true if e.message !~ /already signed/
  end

  def signature_count
    @signature_count ||= petition.properties.fetch('signature_count')
  end

  protected

  def petition
    @petition ||= begin
      petition = Petition.new(change_client)
      petition.load(petition_id)
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
    ENV.fetch('CHANGE_PETITION_ID')
  end

  def api_key
    ENV.fetch('CHANGE_API_ID')
  end

  def secret_token
    ENV.fetch('CHANGE_AUTH_TOKEN')
  end

  def signatory_details_from_signature(signature)
    {
      firstname: signature.first_name,
      lastname: signature.last_name,
      email: signature.email,
      postal_code: signature.zipcode,
      country_code: 'US'
    }
  end
end