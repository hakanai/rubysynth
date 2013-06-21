module RubySynth
  class Song
    def initialize
      @tracks = []
    end
    
    def next_sample
      sample = @tracks.inject(0.0) {|sum, track| sum += track.next_sample() }
      sample = sample / @tracks.length
    end

    def next_samples(num_samples)
      samples = Array.new(num_samples)

      (0..num_samples).each do |i|
        samples[i - 1] = next_sample()
      end

      samples
    end
    
    def sample_length()
      @tracks.inject(0) {|longest, track| (longest > track.sample_length) ? longest : track.sample_length}
    end
    
    attr_accessor :tracks
  end
end