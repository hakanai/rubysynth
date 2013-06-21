def demo_song
  bpm = 120
  noise_drum = Instrument.new(bpm, NoiseOscillator.new(44100, 220.0, 1.0))
  synth_bass = Instrument.new(bpm, OvertoneAdder.new(SquareOscillator.new(44100, 220.0, 0.3), [1.0]), nil, nil)
  #voice = Instrument.new(bpm, SawtoothOscillator.new(44100, 220.0, 0.3), SineOscillator.new(44100, 3.0, 5.0), nil)
  #voice = Instrument.new(bpm, SawtoothOscillator.new(44100, 220.0, 0.3), nil, SineOscillator.new(44100, 10.0, 0.3))
  voice = Instrument.new(bpm, SawtoothOscillator.new(44100, 220.0, 0.3), nil, nil)
  
  drum_track = Track.new(noise_drum)
  2.times {
    7.times {
      drum_track.notes << Note.new("", 0, 4)
      drum_track.notes << Note.new("A", 0, 16)
      drum_track.notes << Note.new("", 0, 16)
      drum_track.notes << Note.new("", 0, 8)
    }
    drum_track.notes << Note.new("", 0, 4)
    drum_track.notes << Note.new("A", 0, 16)
    drum_track.notes << Note.new("", 0, 16)
    drum_track.notes << Note.new("A", 0, 32)
    drum_track.notes << Note.new("", 0, 32)
    drum_track.notes << Note.new("A", 0, 16)
  }
  4.times {
    3.times {
      drum_track.notes << Note.new("", 0, 4)
      drum_track.notes << Note.new("A", 0, 16)
      drum_track.notes << Note.new("", 0, 16)
      drum_track.notes << Note.new("", 0, 8)
    }
    drum_track.notes << Note.new("", 0, 4)
    4.times {
      drum_track.notes << Note.new("A", 0, 32)
      drum_track.notes << Note.new("", 0, 32)
    }
  }


  bass_track = Track.new(synth_bass)
  2.times {
    4.times {
      bass_track.notes << Note.new("A", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("D", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("C", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("B", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("A", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("D", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("C", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    3.times {
      bass_track.notes << Note.new("E", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
      bass_track.notes << Note.new("Eb", 1, 16)
      bass_track.notes << Note.new("E", 1, 16)
  }
  2.times {
    4.times {
      bass_track.notes << Note.new("A", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("D", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("C", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("B", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("A", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("D", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    2.times {
      bass_track.notes << Note.new("C", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    2.times {
      bass_track.notes << Note.new("D", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
    4.times {
      bass_track.notes << Note.new("A", 1, 16)
      bass_track.notes << Note.new("", 1, 16)
    }
  }


  voice_track = Track.new(voice)
  2.times {
    voice_track.notes << Note.new("A", 3, 4)
    voice_track.notes << Note.new("E", 3, 8)
    voice_track.notes << Note.new("F#", 3, 4)
    voice_track.notes << Note.new("E", 3, 8)
    voice_track.notes << Note.new("D", 3, 8)
    voice_track.notes << Note.new("E", 3, 4)
    voice_track.notes << Note.new("D", 3, 8)
    voice_track.notes << Note.new("C", 3, 8)
    voice_track.notes << Note.new("E", 3, 2)
    voice_track.notes << Note.new("", 3, 8)

    voice_track.notes << Note.new("A", 3, 4)
    voice_track.notes << Note.new("E", 3, 8)
    voice_track.notes << Note.new("F#", 3, 4)
    voice_track.notes << Note.new("E", 3, 8)
    voice_track.notes << Note.new("D", 3, 8)
    voice_track.notes << Note.new("E", 3, 1)
    voice_track.notes << Note.new("", 3, 8)
  }
  2.times {
    voice_track.notes << Note.new("A", 4, 4)
    voice_track.notes << Note.new("F#", 3, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("B", 4, 8)
    voice_track.notes << Note.new("C#", 4, 8)
    voice_track.notes << Note.new("B", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("G", 3, 8)
    voice_track.notes << Note.new("G", 3, 8)
    voice_track.notes << Note.new("E", 3, 2)

    voice_track.notes << Note.new("A", 4, 4)
    voice_track.notes << Note.new("F#", 3, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("B", 4, 8)
    voice_track.notes << Note.new("C#", 4, 8)
    voice_track.notes << Note.new("B", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("A", 4, 8)
    voice_track.notes << Note.new("G", 3, 8)
    voice_track.notes << Note.new("G", 3, 8)
    voice_track.notes << Note.new("A", 4, 2)
  }
  
  
  s = Song.new()
  s.tracks = [drum_track, bass_track, voice_track]
  
  return s.next_samples(s.sample_length)
end