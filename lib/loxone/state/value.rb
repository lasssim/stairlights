module Loxone
  module State
    class Value < Base

      def inspect
        [
          "+-- Value State --------",
          "| UUID: #{uuid}",
          "| Value: #{value}",
          "+-----------------------"
        ].join("\n")
      end

      def value
        decodefloat64(16..-1)
      end

      private

      def decodefloat64(range)
        str = message[range].join
        [str].pack('H*').unpack("E").first
      end



    end
  end
end
