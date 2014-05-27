class Signature < ActiveRecord::Base
  before_create :sign_change_petition, if: -> { Rails.env.production? }

  def self.find_or_initialize_by_email(signature_email)
    where(email: signature_params.fetch(:email)).find_or_initialize
  end

  private

  def sign_change_petition
    ChangePetition.new.sign(self)
  end
end
