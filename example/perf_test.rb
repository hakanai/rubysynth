$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'includes'

SAMPLES_PER_SECOND = 44100

def timer(&block)
  start_time = Time.now
  yield  
  return Time.now - start_time
end

# Test performance of basic oscillators
sine = SineOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
square = SquareOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
saw = SawtoothOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
noise = NoiseOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)

o = SineOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
time = timer { o.next_samples(SAMPLES_PER_SECOND * 10) }
puts "Sine Oscillator: #{time} seconds"

o = SquareOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
time = timer { o.next_samples(SAMPLES_PER_SECOND * 10) }
puts "Square Oscillator: #{time} seconds"

o = SawtoothOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
time = timer { o.next_samples(SAMPLES_PER_SECOND * 10) }
puts "Sawtooth Oscillator: #{time} seconds"

o = NoiseOscillator.new(SAMPLES_PER_SECOND, 440.0, 0.5)
time = timer { o.next_samples(SAMPLES_PER_SECOND * 10) }
puts "Noise Oscillator: #{time} seconds"

=begin
tests = [["Sine Oscillator", { sine.next_samples(SAMPLES_PER_SECOND) }],
             ["Square Oscillator", { square.next_samples(SAMPLES_PER_SECOND) }],
             ["Sawtooth Oscillator", { sawtooth.next_samples(SAMPLES_PER_SECOND) }],
             ["Noise Oscillator", { noise.next_samples(SAMPLES_PER_SECOND) }]]


time = timer { o.next_samples(SAMPLES_PER_SECOND) }
puts time
=end