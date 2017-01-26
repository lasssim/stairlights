module Loxone
  module MessageHandler
    class EventFilter < Base
      attr_accessor :filters

      def initialize
        @filters = {}
      end

      def run(state_type:, message:)
        super(state_type: state_type, message: message) do |state, control|
          event = Event.new(state: state, control: control)
          Array(filters[state.uuid]).each { |f| f.call(event) }
        end
      end

      def register_filter(uuid:, &block)
        self.filters[uuid] ||= []
        self.filters[uuid] << block
      end

    end
  end
end

