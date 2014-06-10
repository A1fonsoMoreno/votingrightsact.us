class CallsController < ApplicationController
  respond_to :json

  def create
    @call = CallingService.call(self, params[:call])

    respond_with @call, location: nil
  rescue Twilio::REST::RequestError
    head :bad_request
  end

  def end
    @call = Call.find(params[:id])
    @call.end! params[:CallDuration]

    head :ok
  end

  def progress
    @call = Call.find(params[:id])

    render json: { ended: @call.ended? }
  end

  def survey
    @call = Call.find(params[:id])
    @call.survey_body = params[:survey]
    @call.save

    head :ok
  end
end
