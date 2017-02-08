
require File.expand_path("../config/environment.rb", __FILE__)

class ThreadMonitor
  include Celluloid

  def monitor
    every(1) do
      ap Thread.list
    end
  end
end

#ThreadMonitor.new.monitor

UseCase::LightStairs.new.run

