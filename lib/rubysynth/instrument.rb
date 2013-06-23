module RubySynth
  class Instrument
    def initialize(beats_per_minute, oscillator, vibrato_lfo = nil, volume_lfo = nil)
      @beats_per_minute = beats_per_minute
      @oscillator = oscillator
      @vibrato_lfo = vibrato_lfo
      @volume_lfo = volume_lfo
      
      @prev_vibrato_sample = 0.0
      @prev_volume_sample = 0.0
      
      @samples_per_beat = (oscillator.sample_rate * 60) / beats_per_minute;
      @note = nil
      @note_sample_length = 0
      @sample_index = 0

      @key_state = :up
    end
    
    def update_frequencies
      current_vibrato_sample = @vibrato_lfo.next_sample()
      vibrato_delta = current_vibrato_sample - @prev_vibrato_sample
      @prev_vibrato_sample = current_vibrato_sample

      # Adjust frequency of the oscillators by the vibrato delta
      @oscillator.frequency += vibrato_delta
    end
    
    def update_amplitudes
      current_volume_sample = @volume_lfo.next_sample()
      volumeDelta = current_volume_sample - @prev_volume_sample
      @prev_volume_sample = current_volume_sample

      @oscillator.amplitude += volumeDelta
      if @oscillator.amplitude > 1.0
        @oscillator.amplitude = 1.0
      end
    end
    
    def next_sample
      sample = 0.0
      
      if @note
        # Even though the note has ended, the oscillator might still have samples.
        if @key_state == :down && @sample_index >= @note_sample_length
          @key_state = :up
          @oscillator.key_up
        end

        if @vibrato_lfo
          update_frequencies()
        end
        
        if @volume_lfo
          update_amplitudes()
        end
        
        sample = @oscillator.next_sample()

        @sample_index += 1
        
        #TODO: It would be nice to clean it up eventually but notes don't currently have any way
        #      to tell us when they run out of samples.
        #if @sample_index >= @note_sample_length
        #  @note = nil
        #end
      end
      
      sample
    end

    def next_samples(num_samples)
      (0..num_samples).map do |i|
        next_sample()
      end
    end

    def note=(new_note)
      if new_note
        @note = new_note
        @oscillator.frequency = new_note.frequency

        @sample_index = 0
        @note_sample_length = @samples_per_beat * (4.0 / new_note.duration)

        @key_state = :down
        @oscillator.key_down
      end
    end
    
    attr_reader :tempo, :beats_per_minute, :note, :note_sample_length, :samples_per_beat
  end
end