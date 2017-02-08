module Loxone
  class Event
    attr_reader :control, :state 
    def initialize(control:, state:)
      @control = control
      @state   = state
    end

    def inspect(compact=true)
      if compact
          "Loxone Event: #{state.uuid}: #{state.value}"
      else
        [control, state].map(&:inspect).join("\n")
      end
    end
  end
end

