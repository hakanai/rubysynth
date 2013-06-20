module RubySynth

  # Represents a waveform. A waveform might be a simple oscillator or a complex waveform.
  # Method waveFunction defined by the subclass returns the value of the waveform for @periodOffset.
  class Waveform
    def initialize
      @periodOffset = 0.0
    end

    def nextSamples(numSamples)
      samples = Array.new(numSamples)

      (0..numSamples).each do |i|
        samples[i - 1] = nextSample()
      end

      samples
    end

    attr_reader :periodOffset
  end

  class Oscillator < Waveform
    def initialize(sampleRate, frequency, amplitude)
      super()

      @sampleRate = sampleRate
      self.frequency = frequency
      @amplitude = amplitude
    end

    def nextSample
      sample = waveFunction
      
      @periodOffset += @periodDelta
      if @periodOffset >= 1.0
        @periodOffset -= 1.0
      end
      
      return sample
    end

    def frequency
      @frequency
    end
    
    def frequency=(newFrequency)
      @frequency = newFrequency
      @periodDelta = @frequency / @sampleRate
    end
      
    attr_accessor :amplitude
    attr_reader :sampleRate, :periodDelta
  end


  class SineOscillator < Oscillator
    def waveFunction(phase_modulation = 0)
      @amplitude * Math::sin(@periodOffset * 2.0 * Math::PI + phase_modulation)
    end
  end


  class SquareOscillator < Oscillator
    def waveFunction
      if @periodOffset >= 0.5
        return @amplitude
      else
        return -@amplitude
      end
    end
  end


  class SawtoothOscillator < Oscillator
    def waveFunction
      (1.0 - (@periodOffset * 2.0)) / (1.0 / @amplitude)
    end
  end


  class NoiseOscillator < Oscillator
    def waveFunction
      if @frequency == 0.0
        return 0.0
      else
        return (1.0 - (rand() * 2.0)) / (1.0 / @amplitude)
      end
    end
  end
end