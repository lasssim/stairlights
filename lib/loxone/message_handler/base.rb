module Loxone
  module MessageHandler
    class Base
      
      def run(state_type:, message:)
        if message.is_a? Array
          
          begin
            state   = State.for(state_type: state_type, message: message)
            control = nil #Control.for(uuid: state.uuid, http_client: http_client)
            yield state, control if block_given?
          rescue Control::NotFound
          end
        end
      end
    end
  end
end

