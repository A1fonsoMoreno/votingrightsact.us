class Signature < ActiveRecord::Base
  before_create :sign_change_petition, if: -> { Rails.env.production? }

  private

  def sign_change_petition(petition = nil)
    petition ||= ChangePetition.new
    petition.sign(self)
  end
end
