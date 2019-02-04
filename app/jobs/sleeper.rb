class Sleeper
  @queue = :sleep

  def self.perform(seconds)
  	puts "Sleep...>> #{Time.now}"
  end
end
