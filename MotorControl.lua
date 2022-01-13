
local motor1_channel = SRV_Channels:find_channel(33)
local motor2_channel = SRV_Channels:find_channel(34)
local servo1_channel = SRV_Channels:find_channel(4)
local servo2_channel = SRV_Channels:find_channel(19)
local timeout = 3000
function update() -- this is the loop which periodically runs
    gcs:send_text(0,motor1_channel .. " " .. motor2_channel .. " "  .. servo1_channel .. " " .. servo2_channel) 
    local usage_sec1 = esc_telem:get_rpm(1)
    local usage_sec2 = esc_telem:get_rpm(2)
    local usage_sec3 = esc_telem:get_rpm(3)
    local usage_sec4 = esc_telem:get_rpm(4)
    local pwm = math.floor(math.random(1100, 1900))
    local pwm1 = math.floor(math.random(1100, 1300))

    SRV_Channels:set_output_pwm_chan_timeout(servo1_channel, pwm, timeout)
    SRV_Channels:set_output_pwm_chan_timeout(servo2_channel, pwm, timeout)
    SRV_Channels:set_output_pwm_chan_timeout(motor1_channel, pwm1, timeout)
    SRV_Channels:set_output_pwm_chan_timeout(motor2_channel, pwm1, timeout)

    gcs:send_text(0, string.format("ESCrpm " .. tostring(pwm) .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_motor_temperature(1)
    usage_sec2 = esc_telem:get_motor_temperature(2)
    usage_sec3 = esc_telem:get_motor_temperature(3)
    usage_sec4 = esc_telem:get_motor_temperature(4)
    gcs:send_text(0, string.format("ESCmtrTemp " .. tostring(pwm) .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_voltage(1)
    usage_sec2 = esc_telem:get_voltage(2)
    usage_sec3 = esc_telem:get_voltage(3)
    usage_sec4 = esc_telem:get_voltage(4)
    gcs:send_text(0, string.format("ESCvoltage " .. tostring(pwm) .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_temperature(1)
    usage_sec2 = esc_telem:get_temperature(2)
    usage_sec3 = esc_telem:get_temperature(3)
    usage_sec4 = esc_telem:get_temperature(4)
    gcs:send_text(0, string.format("ESCtemp " .. tostring(pwm) .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    return update, 10000 -- reschedules the loop in 5 seconds
end

return update() -- run immediately before starting to reschedule