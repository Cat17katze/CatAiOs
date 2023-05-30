args = {...}
if #args < 1 then
    file = read()
else
    file = args[1]
end
if fs.exists(file) then
else
    return false
end
local dfpwm = require("cc.audio.dfpwm")
local NetList = peripheral.getNames()
speakers={}
for i=1,#NetList do
    if peripheral.getType(NetList[i]) == "speaker" then
        speakers[#speakers+1] = peripheral.wrap(NetList[i])
    end
end
if #speakers == 0 then
    speakers[1] = peripheral.find("speaker")
end
function play(buff)
    state=false
    for i=1,#speakers do
        state = speakers[i].playAudio(buff)
    end
    return state
end
-- Speakers play at 48kHz, so 1.5 seconds is 72k samples. We first fill our buffer
-- with 0s, as there's nothing to echo at the start of the track!
local samples_i, samples_n = 1, 48000 * 1.5
local samples = {}
for i = 1, samples_n do samples[i] = 0 end

local decoder = dfpwm.make_decoder()
for chunk in io.lines(file, 16 * 1024) do
    local buffer = decoder(chunk)

    for i = 1, #buffer do
        local original_value = buffer[i]

        buffer[i] = original_value

        -- Now store the current sample, and move the "head" of our ring buffer forward one place.
        samples[samples_i] = original_value
        samples_i = samples_i + 1
        if samples_i > samples_n then samples_i = 1 end
    end

    while not play(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
    sleep(0)
end
