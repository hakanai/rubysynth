module RubySynth
	# Represents application of phase modulation (PM).
	# The modulator is used to modulate the phase of the carrier signal.
	# For this to work, the carrier waveform's waveFunction must support a parameter for the modulation.
	class PhaseModulator < Oscillator
		def initialize(carrier, modulator)
			@carrier = carrier
			@modulator = modulator
			@sampleRate = carrier.sampleRate

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

    def nextSample
    	sample = waveFunction
    	@carrier.nextSample
    	@modulator.nextSample
    	sample
    end

		def waveFunction
			@carrier.waveFunction(@modulator.waveFunction)
		end
	end
end
