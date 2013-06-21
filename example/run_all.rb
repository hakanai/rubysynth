$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'includes'

# Generates wave files for all examples as a kind of coverage or smoke test.

method_names = %w(
  sine_beep
  square_beep
	sawtooth_beep
	noise_beep
	major_scale
	minor_scale
	triads
	vibrato_example
	tremolo_example
	phase_modulated_major_scale
	demo_song
	sweet_child_o_mine
	sweet_dreams
)

method_names.each do |method_name|
	data = self.send(method_name.to_sym)
	wave = WaveFile.new(1, 44100, 8)
	wave.sample_data = data
	wave.save("#{method_name}.wav")
end

