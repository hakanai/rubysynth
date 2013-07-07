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
  # We generalise this so that you can have multiple attack, decay and release segments where
  # each segment is linear. This allows shaping the trivial ADSR envelopes as well as envelopes
  # which have more segments during each stage.
  #
  #     LinearEnvelope.new(:key_down => {0.1 => 1.0, 0.3 => 0.7, 0.6 => 0.5},
  #                        :key_up => {1.0 => 0.0})
  # 
  # The key for the map is the time offset and the value is the level (0.0~1.0.)
  # Times are absolute from the event which caused the transitions to start, not relative to
  # a single segment of the envelope.
  class LinearEnvelope < Envelope
    def initialize(params)
      @key_down_transitions = params[:key_down].to_a
      @key_up_transitions = params[:key_up].to_a
      @state = :hold
      @value = 0
      @state_time = 0
    end

#    def on_key_down(hash)
#      @key_down_transitions = hash.to_a
#      self
#    end

#    def on_key_up(hash)
#      @key_up_transitions = hash.to_a
#      self
#    end

    def key_down
      @state = :key_down
      @state_time = 0
      @zero_level = 0
      update_value(@key_down_transitions)
    end

    def key_up
      @state = :key_up
      @state_time = 0
      # release level starts from current level, not the sustain value
      @zero_level = @level
      update_value(@key_up_transitions)
    end

    def advance(seconds)
      @state_time += seconds

      case @state
      when :key_down
        update_value(@key_down_transitions)
      when :key_up
        update_value(@key_up_transitions)
      when :hold
        # stay at the same level until an event
      end
    end

    def update_value(transitions)
      new_value = 0.0
      transitions.each_with_index do |(time, level), index|
        if @state_time > time
          if index == transitions.size - 1
            @value = level # past the end of the last transition
          end
        else # found the transition we're in.
          # values for (p)revious (t)ransition:
          pt_time = 0.0
          pt_level = @zero_level
          if index > 0
            pt = transitions[index - 1]
            pt_time = pt[0]
            pt_level = pt[1]
          end
          # Dodging a division by zero. If we're still at the time of the previous transition
          # (e.g. a transition at 0.0 immediately goes to 1.0) yet we're in this transition,
          # we must be right at the start of the transition, so use the level of the previous
          # transition.
          if time == pt_time
            @value = pt_level
          else
            @value = pt_level + (level - pt_level) * ((@state_time - pt_time) / (time - pt_time))
          end
          break
        end
      end
    end

    def wave_function
      @value
    end
  end

end