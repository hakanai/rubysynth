module RubySynth
  class Note
    MIDDLEA_FREQUENCY = 440.0
    MIDDLE_OCTAVE = 4.0
    
    def initialize(note_name, octave, duration)
      @note_name = note_name
      @octave = octave
      @duration = duration
      
      if @note_name != ""
        octave_multiplier = 2.0 ** (octave - MIDDLE_OCTAVE)
        note_ratio = MusicTheory.note_ratio(MusicTheory.enharmonic_equivalent(note_name)) * octave_multiplier
        @frequency = note_ratio * MIDDLEA_FREQUENCY
      else
        @frequency = 0.0
      end
    end
    
    attr_reader :note_name, :octave, :duration, :frequency
  end
end