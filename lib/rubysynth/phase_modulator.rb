module RubySynth
	# Represents application of phase modulation (PM).
	# The modulator is used to modulate the phase of the carrier signal.
	# For this to work, the carrier waveform's waveFunction must support a parameter for the modulation.
	class PhaseModulator < Oscillator
		def initialize(carrier, modulator)
			@carrier = carrier
			@modulator = modulator
			@sampleRate = carrier.sampleRate

			@ratio = modulator.frequency / carrier.frequency
		end

		def frequency=(freq)
			super
			@carrier.frequency = freq
			@modulator.frequency = freq * @ratio
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
