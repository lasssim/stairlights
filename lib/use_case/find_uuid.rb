module UseCase
  class FindUuid

    def initialize
    end
    

    def run
      loxone_connection

      10.times do
        sleep(1)
        print "."
      end
      puts
    
      loxone_connection.terminate

      puts uuid_stats.inspect
    end

    private

    def uuid_stats 
      @uuid_stats ||= Loxone::MessageHandler::UuidStats.new
    end

    def loxone_connection
      @loxone_connection ||= Loxone::Connection.new(message_handler: uuid_stats)
    end
  end
end
