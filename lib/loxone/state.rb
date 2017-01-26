require_relative "state/base"
require_relative "state/fall_back"
require_relative "state/value"

module Loxone
  module State
    module_function
    
    def for(state_type:, message:)
      klass = begin
        const_get(state_type.to_s.capitalize)
      rescue NameError
        FallBack
      end
      klass.new(message: message) 
    end
  end
end
