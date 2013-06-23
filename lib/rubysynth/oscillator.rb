module RubySynth

  # Represents a waveform. A waveform might be a simple oscillator or a complex waveform.
  # Method wave_function defined by the subclass returns the value of the waveform for @period_offset.
  class Waveform
    def next_samples(num_samples)
      samples = Array.new(num_samples)

      (0..num_samples).each do |i|
        samples[i - 1] = next_sample()
      end

      samples
    end

    def wave_function
      raise "Forgot to implement wave_function in subclass: #{self.class}"
    end
  end

  class Oscillator < Waveform
    def initialize(sample_rate, frequency, amplitude)
      super()

      @sample_rate = sample_rate
      self.frequency = frequency
      self.amplitude = amplitude
      @period_offset = 0.0
    end

    # Called when a key is pressed (when a note starts.)
    def key_down
    end

    # Called when a key is released (when a note ends.)
    def key_up
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
    attr_reader :frequency, :sample_rate, :period_delta, :period_offset
  end


  class SineOscillator < Oscillator
    def wave_function(phase_modulation = 0)
      @amplitude * Math::sin(@period_offset * 2.0 * Math::PI + phase_modulation)
    end
  end


  class SquareOscillator < Oscillator
    def wave_function
      if @period_offset >= 0.5
        @amplitude
      else
        -@amplitude
      end
    end
  end


  class SawtoothOscillator < Oscillator
    def wave_function
      @amplitude * (1.0 - (@period_offset * 2.0))
    end
  end


  class NoiseOscillator < Oscillator
    def initialize(sample_rate, frequency, amplitude)
      super
      @rng = Random.new
    end

    def wave_function
      if @frequency == 0.0
        0.0
      else
        @amplitude * @rng.rand(-1.0..1.0)
      end
    end
  end
end