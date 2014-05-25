class SignaturesController < ApplicationController

  def create
    if signature.save
      respond_with_success
    else
      respond_with_failure
    end
  end

  private

  def signature
    @signature ||= Signature.new(signature_params)
  end

  def signature_params
    params.require(:signature).permit(:firstname, :lastname, :email, :zipcode)
  end

  def respond_with_success
    render json: signature
  end

  def respond_with_failure
    render json: signature.errors
  end
end