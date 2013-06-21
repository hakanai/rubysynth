include RubySynth

def sine_beep
  return SineOscillator.new(44100, 440.0, 0.5).next_samples(44100)
end

def square_beep
  return SquareOscillator.new(44100, 440.0, 0.5).next_samples(44100)
end

def sawtooth_beep
  return SawtoothOscillator.new(44100, 440.0, 0.5).next_samples(44100)
end

def noise_beep
  return NoiseOscillator.new(44100, 440.0, 0.5).next_samples(44100)
end

def major_scale
  bpm = 140
  saw = Instrument.new(120, SineOscillator.new(44100, 220.0, 0.5), nil, nil)
  
  t = Track.new(saw)
  t.notes << Note.new("A", 4, 4)
  t.notes << Note.new("B", 4, 4)
  t.notes << Note.new("C#", 4, 4)
  t.notes << Note.new("D", 4, 4)
  t.notes << Note.new("E", 4, 4)
  t.notes << Note.new("F#", 4, 4)
  t.notes << Note.new("G#", 4, 4)
  t.notes << Note.new("A", 5, 4)
  
  return t.next_samples(t.sample_length)
end

def minor_scale
  bpm = 140
  saw = Instrument.new(120, SineOscillator.new(44100, 220.0, 0.5), nil, nil)
  
  t = Track.new(saw)
  t.notes << Note.new("A", 3, 4)
  t.notes << Note.new("B", 3, 4)
  t.notes << Note.new("C", 3, 4)
  t.notes << Note.new("D", 3, 4)
  t.notes << Note.new("E", 3, 4)
  t.notes << Note.new("F", 3, 4)
  t.notes << Note.new("G#", 3, 4)
  t.notes << Note.new("A", 4, 4)
  
  return t.next_samples(t.sample_length)
end

def triads
  bottom = Instrument.new(120, SineOscillator.new(44100, 220.0, 0.5), nil, nil)
  middle = Instrument.new(120, SineOscillator.new(44100, 220.0, 0.5), nil, nil)
  top = Instrument.new(120, SineOscillator.new(44100, 220.0, 0.5), nil, nil)

  bottom_track = Track.new(bottom)
  bottom_track.notes << Note.new("C", 3, 2)
  bottom_track.notes << Note.new("C", 3, 2)
  bottom_track.notes << Note.new("D", 3, 2)
  bottom_track.notes << Note.new("C", 3, 2)
  
  middle_track = Track.new(middle)
  middle_track.notes << Note.new("E", 3, 2)
  middle_track.notes << Note.new("F", 3, 2)
  middle_track.notes << Note.new("G", 3, 2)
  middle_track.notes << Note.new("E", 3, 2)
  
  top_track = Track.new(top)
  top_track.notes << Note.new("G", 3, 2)
  top_track.notes << Note.new("A", 4, 2)
  top_track.notes << Note.new("B", 4, 2)
  top_track.notes << Note.new("G", 3, 2)
  
  s = Song.new()
  s.tracks = [bottom_track, middle_track, top_track]
  
  return s.next_samples(s.sample_length)  
end

def vibrato_example
  normal = Instrument.new(120, SawtoothOscillator.new(44100, 220.0, 0.3), nil, nil)
  vibrato = Instrument.new(120, SawtoothOscillator.new(44100, 220.0, 0.3), SineOscillator.new(44100, 9.0, 15.0), nil)

  normal_track = Track.new(normal)
  normal_track.notes << Note.new("A", 3, 1)

  vibrato_track = Track.new(vibrato)
  vibrato_track.notes << Note.new("", 3, 1)
  vibrato_track.notes << Note.new("A", 3, 1)
  
  s = Song.new()
  s.tracks = [normal_track, vibrato_track]
  
  return s.next_samples(s.sample_length)
end

def tremolo_example
  normal = Instrument.new(120, SawtoothOscillator.new(44100, 220.0, 0.3), nil, nil)
  tremolo = Instrument.new(120, SawtoothOscillator.new(44100, 220.0, 0.3), nil, SineOscillator.new(44100, 5.0, 0.3))

  normal_track = Track.new(normal)
  normal_track.notes << Note.new("A", 3, 1)

  tremolo_track = Track.new(tremolo)
  tremolo_track.notes << Note.new("", 3, 1)
  tremolo_track.notes << Note.new("A", 3, 1)
  
  s = Song.new()
  s.tracks = [normal_track, tremolo_track]
  
  return s.next_samples(s.sample_length)
end