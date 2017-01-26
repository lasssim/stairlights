module Loxone
  module State
    class FallBack < Base
      def inspect
        [
          "+-- Falback State ------",
          "| UUID: #{uuid}",
          "+-----------------------"
        ].join("\n")
      end

      def value
        "?"
      end
    end
  end
end
