class LegislatorsController < ApplicationController

  before_filter :ensure_zipcode, only: :show
  respond_to :json

  def show
    legislators = Legislator.lookup_by_zipcode(@zipcode)
    if legislators.blank?
      head :not_found
      return
    else
      @legislator = legislators[rand(legislators.length)]
      respond_with @legislator
    end
  end

  def call
    @legislator = Legislator.find(params[:id])
    @from = Rails.application.secrets.twilio.fetch("phone_number")
    render formats: :xml, layout: false
  end

  private

  def ensure_zipcode
    @zipcode = params["zipcode"]

    if @zipcode.blank?
      head :not_found
      return
    end
  end
end
