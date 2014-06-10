class CallingService
  FROM = '+12025090197'
  include Rails.application.routes.url_helpers

  delegate :params, :url_options, to: :@controller

  def self.call(controller, params)
    new(controller, params).call
  end

  def initialize(controller, params)
    @controller = controller
    @call = Call.create(params)
  end

  def call
    @call.sid = make_call(@call)
    @call.save
    @call
  end

  private

    def make_call(call)
      return "TEST_CALL_#{Time.now.to_i}" unless Rails.env.production?

      TWILIO_CLIENT.account.calls.create(
        from: FROM,
        to:  @call.number,
        url: call_legislator_url(@call.legislator),
        status_callback: end_call_url(@call)
      ).sid
    end
end
