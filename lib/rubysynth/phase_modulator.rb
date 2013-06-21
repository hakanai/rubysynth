module RubySynth
	# Represents application of phase modulation (PM).
	# The modulator is used to modulate the phase of the carrier signal.
	# For this to work, the carrier waveform's wave_function must support a parameter for the modulation.
	class PhaseModulator < Oscillator
		def initialize(carrier, modulator)
			@carrier = carrier
			@modulator = modulator
			@sample_rate = carrier.sample_rate

			@frequency_ratio = modulator.frequency / carrier.frequency
			#I think including this would cause weird behaviour, but for symmetry...
			#@amplitude_ratio = modulator.amplitude / carrier.amplitude
		end

		def frequency=(freq)
			super
			@carrier.frequency = freq
			@modulator.frequency = freq * @frequency_ratio
		end

		def amplitude=(ampl)
			super
			@carrier.amplitude = ampl
		end

    def next_sample
    	sample = wave_function
    	@carrier.next_sample
    	@modulator.next_sample
    	sample
    end

		def wave_function
			@carrier.wave_function(@modulator.wave_function)
		end
	end
end
