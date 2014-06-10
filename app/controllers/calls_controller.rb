require "calling_service"

class CallsController < ApplicationController
  respond_to :json

  def create
    @call = CallingService.call(self, calling_service_params)

    respond_with @call, location: nil
  rescue Twilio::REST::RequestError
    head :bad_request
  end

  def end
    @call = Call.find(params.fetch(:id))
    @call.end! params.fetch(:CallDuration)

    head :ok
  end

  def progress
    @call = Call.find(params.fetch(:id))

    render json: { ended: @call.ended? }
  end

  def survey
    @call = Call.find(params.fetch(:id))
    @call.survey_body = params.fetch(:survey)
    @call.save

    head :ok
  end

  private

  def call_params
    @call_params ||= params.permit(:area_code, :prefix_number, :line_number, :legislator_id, :signature_id)
  end

  def calling_service_params
    {
      number: phone_number,
      legislator_id: call_params.fetch(:legislator_id),
      signature_id:  call_params.fetch(:signature_id)
    }
  end

  def phone_number
    number  = ""
    number += call_params.fetch(:area_code)
    number += call_params.fetch(:prefix_number)
    number += call_params.fetch(:line_number)
    number
  end
end
