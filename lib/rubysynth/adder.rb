module RubySynth
  # Represents application of waveform addition.
  class Adder < Oscillator
    def initialize(waveforms)
      @waveforms = waveforms

      first = @waveforms[0]
      @frequency = first.frequency
      @amplitude = first.amplitude
      @sample_rate = first.sample_rate
      @frequency_ratios = @waveforms.map { |w| w.frequency / @frequency }
      @amplitude_ratios = @waveforms.map { |w| w.amplitude / @amplitude }
    end

    def frequency=(freq)
      super
      @waveforms.each_with_index { |w, i| w.frequency = @frequency * @frequency_ratios[i] }
    end

    def amplitude=(ampl)
      super
      @waveforms.each_with_index { |w, i| w.amplitude = @amplitude * @amplitude_ratios[i] }
    end

    def next_sample
      sample = wave_function
      @waveforms.each { |w| w.next_sample }
      sample
    end

    def wave_function
      @waveforms.map { |w| w.wave_function }.inject(:+) / @waveforms.size
    end
  end

  # A special case of adding waveforms where you're just adding overtones of the waveforms,
  # so you can simply specify the relative amplitudes of the overtones.
  class OvertoneAdder < Adder
    def initialize(oscillator, overtones)
      oscillators = [ oscillator ]
      overtones.each_with_index do |overtone, i|
        overtone_oscillator = oscillator.clone
        overtone_oscillator.frequency = oscillator.frequency * (i + 2)
        overtone_oscillator.amplitude = overtone
        oscillators << overtone_oscillator
      end
      super(oscillators)
    end
  end
end
