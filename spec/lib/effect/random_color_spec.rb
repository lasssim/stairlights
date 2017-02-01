require 'spec_helper'

module Effect
  describe RandomColor do
    around do |ex|
      Celluloid.boot
      ex.run
      Celluloid.shutdown
    end



    subject { described_class.new(printer: printer, opts: opts) }
    
    let(:printer) do
      Printer::SDL.new(
        canvas: canvas, 
        logger: logger
      )
    end

    let(:logger) { Logger.new(STDOUT) }

    let(:opts) do 
      { 
        time_till_change: 1
      }
    end

    let(:canvas) do
      Canvas::Rectangle.new(
        opts: {
          width: 10, 
          height: 10
        }
      )
    end

    let(:total_frames) { 600 }

    it "runs the effect" do
      frames = total_frames
      start_time = Time.now
     
      p = Proc.new do
        frames -= 1
        run = frames > 0
        [run, nil]
      end
      
      subject.async.loop(p)

      end_time = Time.now
      fps = total_frames/(end_time - start_time)
      expect(fps).to be_within(1).of(60)
    end

  end
end
