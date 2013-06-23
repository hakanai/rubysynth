module RubySynth
  class EnvelopedOscillator < Oscillator
    def initialize(envelope, oscillator)
      @envelope = envelope
      @oscillator = oscillator

      @sample_rate = oscillator.sample_rate
      self.frequency = oscillator.frequency
      self.amplitude = oscillator.amplitude
    end

    def frequency=(freq)
      super
      @oscillator.frequency = freq
    end

    def amplitude=(ampl)
      super
      @oscillator.amplitude = ampl
    end

    def key_down
      @envelope.key_down
      @oscillator.key_down
    end

    def key_up
      @envelope.key_up
      @oscillator.key_up
    end

    def next_sample
      #TODO: This pattern should be refactored out as every Oscillator does it:
      #  sample = wave_function
      #  do stuff to advance
      #  return sample
      sample = wave_function
      @envelope.advance(1.0 / @sample_rate)
      @oscillator.next_sample
      sample
    end

    def wave_function
      @oscillator.wave_function * @envelope.wave_function
    end
  end

  # Base class for envelopes. Envelopes describe how the sound changes in response to the keys
  # of the instrument being pressed.
  class Envelope

    # Called when a key is pressed (when a note starts.)
    def key_down
      raise "Unimplemented"
    end

    # Called when a key is released (when a note ends.)
    def key_up
      raise "Unimplemented"
    end

    # Advances a given number of seconds into the timeline.
    def advance(seconds)
      raise "Unimplemented"
    end

    # Returns the current value of the function.
    def wave_function
      raise "Unimplemented"
    end

  end

  # The simplest useful envelope, where the amplitude is at 1.0 while the key is being pressed
  # and 0.0 at all other times.
  #
  # This is equivalent to an ADSR envelope with:
  #   attack_time = 0.0
  #   decay_time = 0.0
  #   sustain_level = 1.0
  #   release_time = 0.0
  #
  # However, the implementation is considerably simpler.
  class OnOffEnvelope < Envelope
    def initialize
      @state = :off
    end

    def key_down
      @state = :on
    end

    def key_up
      @state = :off
    end

    def advance(seconds)
    end

    def wave_function
      :on ? 1.0 : 0.0
    end
  end

  # Envelope following the traditional Attack -> Decay -> Sustain -> Release pattern.
  # I'm sure if you're reading this, you probably know what this means already, but it looks like this:
  #
  #   1.0 .....................................
  #                 /\decay
  #                /  \
  #         attack/    \_____________
  #              /         sustain   \release
  #             /                     \
  #   0.0 _____/.......................\_______
  #
  class ADSREnvelope < Envelope

    # Creates a new ADSR envelope with the specified parameters.
    #
    # When the key is pressed, we start a timer. While the key is held:
    #   Over attack_time seconds, amplitude is gradually increased from 0.0 to 1.0
    #   Over decay_time seconds, amplitude is gradually decreased from 1.0 to sustain_level
    #
    # When the key is released, we start another timer:
    #   Over release_time seconds, amplitude is gradually decreased from sustain_level to 0.0
    #
    # sustain_level should be between 0.0 and 1.0.
    # If you set sustain_level to 1.0 then decay_time might as well be set to 0.0.
    # If you set sustain_level to 0.0 then release_time might as well be set to 0.0.
    #
    # All of these transitions are currently linear.
    def initialize(attack_time, decay_time, sustain_level, release_time)
      @attack_time = attack_time
      @decay_time = decay_time
      @sustain_level = sustain_level
      @release_time = release_time
      @state = :off
      @value = 0
      @state_time = 0
    end

    def key_down
      @state = :attack
      @state_time = 0
      maybe_advance_to_next_state(@attack_time, :decay)
    end

    def key_up
      @state = :release
      @state_time = 0
      # Regardless of where we are in the curve, the release slopes down from the current value.
      @release_level = @value
      maybe_advance_to_next_state(@release_time, :off)
    end

    def advance(seconds)
      @state_time += seconds

      case @state
      when :attack
        @value = @state_time / @attack_time
        maybe_advance_to_next_state(@attack_time, :decay)
      when :decay
        @value = 1.0 - (1.0 - @sustain_level) * (@state_time / @decay_time)
        maybe_advance_to_next_state(@decay_time, :sustain)
      when :sustain
        # stays sustained until key_up
        @value = @sustain_level
      when :release
        @value = @release_level * (1.0 - (@state_time / @release_time))
        maybe_advance_to_next_state(@release_time, :off)
      when :off
        # stays off until key_down
        @value = 0.0
      end
    end

    # If the current time is past the length of the current state (threshold_time), move into next_state.
    #
    # The assumption here is that the seconds values are very short.
    # If it were longer, we'd potentially pass a significant time into the next state and would have to
    # calculate how far in, adjusting @value appropriately.
    def maybe_advance_to_next_state(threshold_time, next_state)
      if @state_time >= threshold_time
        @state = next_state
        @state_time = 0

        #TODO: Hack here to avoid divide by zero error when @attack_time and @decay_time are both 0.0.
        # A proper fix is to use something more like a state machine.
        if @state == :decay
          maybe_advance_to_next_state(@decay_time, :sustain)
        end
      end
    end

    def wave_function
      @value
    end
  end
end