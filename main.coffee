portAudio = require 'portaudio'

# create a sine wave lookup table
sampleRate = 44100
period1 = 209
period2 = 211
tableSize = period1 * period2
buffer = new Buffer tableSize

i = 0
while i++ < tableSize
  buffer[i] = 127 * Math.sin((i / period1) * 3.1415 * 2.0) + 127 * Math.sin((i / period2) * 3.1415 * 2.0) + 255

portAudio.getDevices (err, devices) ->
                       console.log devices

options =
  channelCount: 1
  sampleFormat: portAudio.SampleFormat8Bit
  sampleRate: sampleRate

player = (err, pa) ->
  # send samples to be played
           i = 0

           while i < 5 * sampleRate / tableSize
             pa.write buffer
             i++

           # start playing
           pa.start()

           # stop playing 1 second later
           setTimeout ( () ->
                          pa.stop()
                      ),
                      4000
portAudio.open options,
               player