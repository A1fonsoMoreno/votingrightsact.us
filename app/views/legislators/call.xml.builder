xml.instruct!
xml.Response do
  xml.Say "Connecting you with #{@legislator.fullname}. Please wait a few moments."
  xml.Dial @legislator.phone, callerId: @from
end
