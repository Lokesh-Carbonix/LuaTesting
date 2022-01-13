local timeout = 3000
local usage_sec1 = 0
local usage_sec2 = 0
local usage_sec3 = 0
local usage_sec4 = 0

function update() -- this is the loop which periodically runs
    usage_sec1 = esc_telem:get_rpm(1)
    usage_sec2 = esc_telem:get_rpm(2)
    usage_sec3 = esc_telem:get_rpm(3)
    usage_sec4 = esc_telem:get_rpm(4)
    gcs:send_text(0, "ESC Reading")
    gcs:send_text(0, string.format("ESCrpm " .. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_motor_temperature(1)
    usage_sec2 = esc_telem:get_motor_temperature(2)
    usage_sec3 = esc_telem:get_motor_temperature(3)
    usage_sec4 = esc_telem:get_motor_temperature(4)
    gcs:send_text(0, string.format("ESCmtrTemp " .. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_voltage(1)
    usage_sec2 = esc_telem:get_voltage(2)
    usage_sec3 = esc_telem:get_voltage(3)
    usage_sec4 = esc_telem:get_voltage(4)
    gcs:send_text(0, string.format("ESCvoltage " .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    usage_sec1 = esc_telem:get_temperature(1)
    usage_sec2 = esc_telem:get_temperature(2)
    usage_sec3 = esc_telem:get_temperature(3)
    usage_sec4 = esc_telem:get_temperature(4)
    gcs:send_text(0, string.format("ESCtemp "  .." / ".. tostring(usage_sec1).. ": " .. tostring(usage_sec2).. ": " .. tostring(usage_sec3).. ": " .. tostring(usage_sec4)))
    return update, 1000 -- reschedules the loop in 5 seconds
end

return update() -- run immediately before starting to reschedule