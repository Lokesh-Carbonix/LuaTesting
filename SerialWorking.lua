gcs:send_text(0, "Process Init")  
local SerialProtocol_Scripting = 28
local port = serial:find_serial(0)
port:begin(57600)
port:set_flow_control(0)

gcs:send_text(0, "Serial Init")  
-- begin the serial port

gcs:send_text(0, "Process Started")  

function update() -- this is the loop which periodically runs
    gcs:send_text(0, "Process Still Runiing")  
    if port:available() > 0 then
        read = port:read()
        gcs:send_text(0, string.char(read))
    end
    -- port:write(100)
    return update, 1000 -- reschedules the loop in 5 seconds
end

return update() -- run immediately before starting to reschedule
