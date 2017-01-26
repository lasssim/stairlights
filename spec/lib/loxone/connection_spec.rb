module Loxone

  describe Connection do
    around do |ex|
      Celluloid.boot
      ex.run
      Celluloid.shutdown
    end


    let(:logger) { Logger.new(STDOUT) }

    subject { described_class.new(message_handler: nil) }

    it "connects" do
      subject
      sleep 10
    end

  end
end
