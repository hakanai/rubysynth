$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'includes'

start_time = Time.now
#data = sine_beep()
#data = phase_modulated_major_scale()
#data = linear_envelope_major_scale()
data = demo_song()
#data = sweet_child_o_mine()
#data = sweet_dreams()
stop_time = Time.now

puts "Total samples: #{data.length}"
puts "Max sample: #{data.max}"
puts "Min sample: #{data.min}"
puts "Time to generate sample data: #{stop_time - start_time} seconds."

start_time = Time.now
wave = WaveFile.new(1, 44100, 8)
wave.sample_data = data
wave.save(ARGV[0])
stop_time = Time.now
puts "Time to save wave file: #{stop_time - start_time} seconds."
