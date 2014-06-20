require "change_petition"

class Signature < ActiveRecord::Base
  before_create :sign_change_petition, if: -> { Rails.env.production? }

  has_many :calls

  private

  def sign_change_petition
    ChangePetition.sign(self)
  rescue Change::Exceptions::ChangeException => e
    self.change_org_error = e.message
  end
end
