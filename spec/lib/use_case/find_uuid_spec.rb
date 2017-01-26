module UseCase

  describe FindUuid do
    around do |ex|
      Celluloid.boot
      ex.run
      Celluloid.shutdown
    end


    let(:logger) { Logger.new(STDOUT) }

    subject { described_class.new }

    it "finds the uuid" do
      subject.run
    end

  end
end
