module Loxone
  module MessageHandler
    class UuidStats < Base
    
      attr_reader :stats
      def initialize
        @stats = {}
      end

      def run(state_type:, message:)
        super(state_type: state_type, message: message) do |state, _|
          inc(state.uuid, state.value)
        end
      end

      def inspect
        possible_uuids = stats.select do |uuid, values|
          nr_of_values_met = values.count > 1 
          count_met = values.any? { |value, count| count == 7 }
          nr_of_values_met || count_met
        end

        possible_uuids_str = possible_uuids.map do |uuid, values|
          "| #{uuid}: #{values.map { |v, c| "#{v}(#{c})"}.join(", ") }"
        end

        [
          "+-- Possible UUIDs -------------------", 
          possible_uuids_str,
          "+-------------------------------------"
        ].join("\n") + "\n\n"

      end

      private

      def inc(uuid, value)
        stats[uuid] ||= {}
        stats[uuid][value] ||= 0
        stats[uuid][value] += 1
      end

    end
  end
end

