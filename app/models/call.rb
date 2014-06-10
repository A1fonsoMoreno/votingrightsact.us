class Call < ActiveRecord::Base

  belongs_to :signature
  belongs_to :legislator

  def end!(call_duration)
    self.ended = true
    self.call_duration = call_duration
    save
  end
end
