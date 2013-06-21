def sweet_child_o_mine
  bpm = 140
  lead = Instrument.new(bpm, SawtoothOscillator.new(44100, 220.0, 0.3), nil, nil)
    
  lead_track = Track.new(lead)
  2.times {
    lead_track.notes << Note.new("A", 3, 8)
    lead_track.notes << Note.new("A", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("D", 3, 8)
    lead_track.notes << Note.new("D", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("C#", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
  }
  2.times {
    lead_track.notes << Note.new("B", 3, 8)
    lead_track.notes << Note.new("A", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("D", 3, 8)
    lead_track.notes << Note.new("D", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("C#", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
  }
  2.times {
    lead_track.notes << Note.new("D", 3, 8)
    lead_track.notes << Note.new("A", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("D", 3, 8)
    lead_track.notes << Note.new("D", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("C#", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
  }
  2.times {
    lead_track.notes << Note.new("A", 3, 8)
    lead_track.notes << Note.new("A", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("D", 3, 8)
    lead_track.notes << Note.new("D", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
    lead_track.notes << Note.new("C#", 4, 8)
    lead_track.notes << Note.new("E", 3, 8)
  }
  lead_track.notes << Note.new("A", 3, 2)

  
  s = Song.new()
  s.tracks = [lead_track]
  
  return s.next_samples(s.sample_length)
end