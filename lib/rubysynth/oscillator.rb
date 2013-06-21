module RubySynth

  # Represents a waveform. A waveform might be a simple oscillator or a complex waveform.
  # Method wave_function defined by the subclass returns the value of the waveform for @period_offset.
  class Waveform
    def initialize
      @period_offset = 0.0
    end

    def next_samples(num_samples)
      samples = Array.new(num_samples)

      (0..num_samples).each do |i|
        samples[i - 1] = next_sample()
      end

      samples
    end

    attr_reader :period_offset
  end

  class Oscillator < Waveform
    def initialize(sample_rate, frequency, amplitude)
      super()

      @sample_rate = sample_rate
      self.frequency = frequency
      self.amplitude = amplitude
    end

    def next_sample
      sample = wave_function
      
      @period_offset += @period_delta
      if @period_offset >= 1.0
        @period_offset -= 1.0
      end
      
      return sample
    end
    
    def frequency=(freq)
      @frequency = freq
      @period_delta = @frequency / @sample_rate
    end
      
    attr_accessor :amplitude
    attr_reader :frequency, :sample_rate, :period_delta
  end


  class SineOscillator < Oscillator
    def wave_function(phase_modulation = 0)
      @amplitude * Math::sin(@period_offset * 2.0 * Math::PI + phase_modulation)
    end
  end


  class SquareOscillator < Oscillator
    def wave_function
      if @period_offset >= 0.5
        return @amplitude
      else
        return -@amplitude
      end
    end
  end


  class SawtoothOscillator < Oscillator
    def wave_function
      (1.0 - (@period_offset * 2.0)) / (1.0 / @amplitude)
    end
  end


  class NoiseOscillator < Oscillator
    def wave_function
      if @frequency == 0.0
        return 0.0
      else
        return (1.0 - (rand() * 2.0)) / (1.0 / @amplitude)
      end
    end
  end
end