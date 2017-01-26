module Loxone
  module State
    class Base
      attr_reader :message
      def initialize(message:)
        @message = message.map { |e| "%02x" % e }
      end

      def inspect
        raise NotImplementedError
      end

      def uuid
        [decode32(0..3), decode16(4..5), decode16(6..7), message[8..15].join].join("-")
      end


      def value
        raise NotImplementedError
      end

      private
      def decode32(range)
        str = message[range].join
        [str].pack('H*').unpack('N*').pack('V*').unpack('H*')
      end

      def decode16(range)
        str = message[range].join
        [str].pack('H*').unpack('n*').pack('v*').unpack('H*')
      end

    end
  end
end
