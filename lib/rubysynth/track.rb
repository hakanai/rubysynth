module RubySynth
  class Track
    def initialize(instrument)
      @instrument = instrument
      @notes = []
      @note_index = -1
      
    end

    def next_sample
      if @note_index == -1
        new_note = @notes[0]
        @note_index = 0
        @instrument.note = new_note
        @note_sample_length = @instrument.samples_per_beat * (4.0 / new_note.duration)
        @note_sample_index = 0
      end

      #TODO: I don't see any code here using Rest and Rest doesn't extend Note or anything,
      #      so I'm assuming that rests are unimplemented. But without rests, the release logic
      #      for envelopes will basically never be used.

      #TODO: There is some duplication of logic between Track and Instrument. Both of them have
      #      code to check if the note is starting or ending. The correct move is probably to move
      #      all note start/stop logic into Track.

      if @note_sample_index < @note_sample_length
        sample = @instrument.next_sample
        @note_sample_index += 1
      else
        if @note_index < @notes.length - 1
          @note_index += 1
          new_note = @notes[@note_index]
          @instrument.note = new_note
          @note_sample_length = @instrument.samples_per_beat * (4.0 / new_note.duration)
          @note_sample_index = 0

          sample = @instrument.next_sample()
          @note_sample_index += 1
        else
          sample = 0.0
        end
      end
      
      sample
    end

    def current_note_ended?
      @sample_index >= @note_sample_length
    end

    def next_samples(num_samples)
      (0..num_samples).map do |i|
        next_sample
      end
    end
    
    def sample_length()
      @notes.map {|note| (@instrument.samples_per_beat * (4.0 / note.duration)) }.inject(:+)
    end
    
    attr_accessor :notes, :instrument
  end
end