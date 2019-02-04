class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  DEFAULT_CURRENCY = "GBP"
  def sleeper
  	Resque.enqueue_at(2.minutes.from_now,Sleeper,user_id: "1")
    # Resque.enqueue(Sleeper, 5)
  end

end
