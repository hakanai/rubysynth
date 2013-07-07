module RubySynth
  class MusicTheory
    NOTE_RATIOS =
    {
      "A"  => 1.0,
      "A#" => 2.0**(1/12.0),
      "B"  => 2.0**(2/12.0),
      "C"  => 2.0**(3/12.0),
      "C#" => 2.0**(4/12.0),
      "D"  => 2.0**(5/12.0),
      "D#" => 2.0**(6/12.0),
      "E"  => 2.0**(7/12.0),
      "F"  => 2.0**(8/12.0),
      "F#" => 2.0**(9/12.0),
      "G"  => 2.0**(10/12.0),
      "G#" => 2.0**(11/12.0)
    }
  
    ENHARMONIC_EQUIVALENTS =
    {
      "A"   => "A",
      "G##" => "A",
      "Bbb" => "A",
    
      "A#"  => "A#",
      "Bb"  => "A#",
      "Cbb" => "A#",
    
      "B"   => "B",
      "A##" => "B",
      "Cb"  => "B",
    
      "C"   => "C",
      "B#"  => "C",
      "Dbb" => "C",
    
      "C#"  => "C#",
      "B##" => "C#",
      "Db"  => "C#",
    
      "D"   => "D",
      "C##" => "D",
      "Ebb" => "D",
    
      "D#"  => "D#",
      "Eb"  => "D#",
      "Fbb" => "D#",
  
      "E"   => "E",
      "D##" => "E",
      "Fb"  => "E",
    
      "F"   => "F",
      "E#"  => "F",
      "Gbb" => "F",
    
      "F#"  => "F#",
      "E##" => "F#",
      "Gb"  => "F#",
    
      "G"   => "G",
      "F##" => "G",
      "Abb" => "G",
    
      "G#"  => "G#",
      "Ab"  => "G#"
    }
  
    def MusicTheory.note_ratio(note_name)
      NOTE_RATIOS[note_name]
    end

    def MusicTheory.enharmonic_equivalent(note_name)
      ENHARMONIC_EQUIVALENTS[note_name]
    end
  end
end