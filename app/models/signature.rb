class Signature < ActiveRecord::Base
  before_create :sign_change_petition, if: -> { Rails.env.production? }

  has_many :calls

  private

  def sign_change_petition
    ChangePetition.new.sign(self)
  end
end
