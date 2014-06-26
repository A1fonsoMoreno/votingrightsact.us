require "change_petition"

class SignaturesController < ApplicationController

  def create
    if save_signature
      respond_with_success
    else
      respond_with_failure
    end
  end

  def count
    render json: { count: ChangePetition.signature_count }
  end

  private

  def signature
    @signature ||= Signature.find_or_initialize_by(email: signature_email)
  end

  def signature_params
    params.require(:signature).permit(:firstname, :lastname, :email, :city, :zipcode)
  end

  def signature_email
    signature_params.fetch(:email)
  end

  def save_signature
    signature.update_attributes signature_params
  end

  def respond_with_success
    render json: signature
  end

  def respond_with_failure
    render json: signature.errors
  end
end