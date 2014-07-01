require "calling_service"

class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:end, :progress]

  respond_to :json

  def create
    @call = CallingService.call(self, calling_service_params)

    respond_with @call, location: nil
  rescue => e
    logger.info e.inspect
    head :bad_request
  end

  def update
    @call = Call.find(params.fetch(:id))
    @call.survey_body = params.fetch(:survey)
    @call.save

    head :ok
  end

  def end
    @call = Call.find(params.fetch(:id))
    @call.end! params.fetch(:CallDuration) unless @call.ended?

    head :ok
  end

  def progress
    @call = Call.find(params.fetch(:id))

    render json: { ended: @call.ended? }
  end

  private

  def call_params
    @call_params ||= params.permit(:area_code, :prefix_number, :line_number, :legislator_id, :signature_id)
  end

  def calling_service_params
    {
      number: phone_number,
      legislator_id: call_params.fetch(:legislator_id),
      signature_id:  signature.id
    }
  end

  def phone_number
    number  = ""
    number += call_params.fetch(:area_code)
    number += call_params.fetch(:prefix_number)
    number += call_params.fetch(:line_number)
    number
  end

  def signature
    Signature.where(secure_key: call_params.fetch(:signature_id)).first
  end
end
