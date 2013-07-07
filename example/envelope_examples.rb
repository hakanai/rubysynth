def linear_envelope_major_scale
  bpm = 140
  waveform = EnvelopedOscillator.new(
    LinearEnvelope.new(:key_down => {0.0 => 1.0, 0.6 => 0.0}, :key_up => {2.0 => 0.0}),
    SineOscillator.new(44100, 440.0, 0.5))
  instrument = Instrument.new(120, waveform, nil, nil)

  t = Track.new(instrument)
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
