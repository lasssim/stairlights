require 'spec_helper'

module Effect
  describe SingleColor do
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
        pixel: Canvas::Pixel.new([123, 123, 123]) 
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

    let(:total_frames) { 10 }

    it "runs the effect" do
      frames = total_frames
      start_time = Time.now
      
      subject.loop do
        frames -= 1
        run = frames > 0
        [run, nil]
      end

      end_time = Time.now
      fps = total_frames/(end_time - start_time)
      expect(fps).to be_within(1).of(60)
    end

  end
end
