module Loxone

  class Connection
    include Celluloid

    attr_reader :logger, :message_handler

    def initialize(logger: Loxone.config.logger, message_handler: )
      @logger = logger
      @message_handler = message_handler
      websocket_client.text("authenticate/#{hmac}")
      websocket_client.text("jdev/sps/enablebinstatusupdate")
    end

    
    # When WebSocket is opened, register callbacks
    def on_open
      puts "Websocket connection opened"
    end

    # When raw WebSocket message is received
    def on_message(message)
      begin
        @state_type ||= :header

        if @state_type == :header
          @state_type = [:text, :binary, :value, :text, :daytimer][message[1]]
        else
          message_handler.run(state_type: @state_type, message: message)
          @state_type = :header
        end

      rescue Exception => ex
        binding.pry
      end

    end

    # When WebSocket is closed
    def on_close(code, reason)
      puts "WebSocket connection closed: #{code.inspect}, #{reason.inspect}"
    end



    private

    def websocket_client
      url = "ws://#{Loxone.config.host}/ws/rfc6455"
      @websocket_client ||= Celluloid::WebSocket::Client.new url, Celluloid::Actor.current
    end

    def http_client
      @http_client ||= Faraday.new(:url => "http://#{Loxone.config.host}") do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.response :json, content_type: /\bjson$/
        faraday.basic_auth(Loxone.config.user, Loxone.config.password)
        faraday.adapter  Faraday.default_adapter
      end
    end


    def hmac
      @hmac ||= begin
        data = "#{Loxone.config.user}:#{Loxone.config.password}" 

        digest = OpenSSL::Digest.new('sha1')
        hmac = OpenSSL::HMAC.digest(digest, key, data).unpack("H*").first
      end
    end

    def key
      @key ||= begin
        [http_client.get("/jdev/sys/getkey").body["LL"]["value"]].pack("H*")
      end
    end




  end
end
