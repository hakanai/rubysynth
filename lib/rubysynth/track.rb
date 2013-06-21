module RubySynth
  class Track
    def initialize(instrument)
      @instrument = instrument
      @notes = []
      @note_index = -1
      @sample_length = 0
    end

    def next_sample
      if @note_index == -1
          @instrument.note = @notes[0]
          @note_index = 0
      end

      if @instrument.note
        sample = @instrument.next_sample
      else      
        if @note_index < @notes.length
          @note_index += 1

          @instrument.note = @notes[@note_index]        
          sample = @instrument.next_sample()
        else
          sample = 0.0
        end
      end
      
      sample
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