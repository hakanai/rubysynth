
def phaseModulatedMajorScale
  bpm = 140
  waveform = PhaseModulator.new(
    SineOscillator.new(44100, 440.0, 0.5),
    SineOscillator.new(44100, 440.0*3.9, 1))
  saw = Instrument.new(120, waveform, nil, nil)
  
  t = Track.new(saw)
  t.notes << Note.new("A", 4, 4)
  t.notes << Note.new("B", 4, 4)
  t.notes << Note.new("C#", 4, 4)
  t.notes << Note.new("D", 4, 4)
  t.notes << Note.new("E", 4, 4)
  t.notes << Note.new("F#", 4, 4)
  t.notes << Note.new("G#", 4, 4)
  t.notes << Note.new("A", 5, 4)
  
  return t.nextSamples(t.sampleLength)
end
