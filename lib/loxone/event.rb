module Loxone
  class Event
    attr_reader :control, :state 
    def initialize(control:, state:)
      @control = control
      @state   = state
    end

    def inspect(compact=true)
      if compact
        [
          "+-- Event --------------",
          "| #{state.uuid}: #{state.value}",
          "+-----------------------"
        ].join("\n")
      else
        [control, state].map(&:inspect).join("\n")
      end + "\n\n"
    end
  end
end

