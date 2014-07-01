require "change_petition"

class Signature < ActiveRecord::Base

  before_create :sign_change_petition, if: -> { Rails.env.production? }
  before_create :make_secure_key

  has_many :calls

  private

  def make_secure_key
    self.secure_key = SecureRandom.hex(8)
  end

  def sign_change_petition
    ChangePetition.sign(self)
  rescue Change::Exceptions::ChangeException => e
    self.change_org_error = e.message
  end
end
