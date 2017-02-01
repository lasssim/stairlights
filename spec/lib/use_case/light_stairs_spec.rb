module UseCase

  describe LighStairs do
    around do |ex|
      Celluloid.boot
      ex.run
      Celluloid.shutdown
    end


    let(:logger) { Logger.new(STDOUT) }

    subject { described_class.new }

    it "lights the stairs", :wip do
      subject.run
    end

  end
end
