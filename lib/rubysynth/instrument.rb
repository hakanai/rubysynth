module RubySynth
  class Instrument
    def initialize(beatsPerMinute, oscillator, vibratoLFO = nil, volumeLFO = nil)
      @beatsPerMinute = beatsPerMinute
      @oscillator = oscillator
      @vibratoLFO = vibratoLFO
      @volumeLFO = volumeLFO
      
      @prevVibratoSample = 0.0
      @prevVolumeSample = 0.0
      
      @samplesPerBeat = (oscillator.sampleRate * 60) / beatsPerMinute;
      @note = nil
      @noteSampleLength = 0
      @sampleIndex = 0
    end
    
    def updateFrequencies
      currentVibratoSample = @vibratoLFO.nextSample()
      vibratoDelta = currentVibratoSample - @prevVibratoSample
      @prevVibratoSample = currentVibratoSample

      # Adjust frequency of the oscillators by the vibrato delta
      @oscillator.frequency += vibratoDelta
    end
    
    def updateAmplitudes
      currentVolumeSample = @volumeLFO.nextSample()
      volumeDelta = currentVolumeSample - @prevVolumeSample
      @prevVolumeSample = currentVolumeSample

      @oscillator.amplitude += volumeDelta
      if @oscillator.amplitude > 1.0
        @oscillator.amplitude = 1.0
      end
    end
    
    def nextSample
      sample = 0.0
      
      if @note != nil && @sampleIndex < @noteSampleLength
        
        if @vibratoLFO != nil
          updateFrequencies()
        end
        
        if @volumeLFO != nil
          updateAmplitudes()
        end
        
        sample = @oscillator.nextSample()

        @sampleIndex += 1
        
        if(@sampleIndex >= @noteSampleLength)
          @note = nil
        end
      end
      
      sample
    end

    def nextSamples(numSamples)
      samples = Array.new(numSamples)
      
      (0..numSamples).each do |i|
        samples[i - 1] = nextSample()
      end
      
      samples
    end

    def note=(newNote)
      if(newNote != nil)
        @note = newNote
        @oscillator.frequency = newNote.frequency

        @sampleIndex = 0
        @noteSampleLength = @samplesPerBeat * (4.0 / newNote.duration)
      end
    end
    
    attr_reader :tempo, :beatsPerMinute, :note, :noteSampleLength, :samplesPerBeat
  end
end