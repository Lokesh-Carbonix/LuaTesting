gcs:send_text(0, "Process Init") ; 
local SerialProtocol_Scripting = 28;
-- local port = serial:find_serial(0)
local port = assert(serial:find_serial(0),"Could not find Scripting Serial Port");

port:begin(57600);
port:set_flow_control(0);

gcs:send_text(0, "Serial Init");  
-- begin the serial port

gcs:send_text(0, "Process Started");  
port:write(100);

local dataTowrite = "";
local logBuffer = "";
local logBufferCt = 0;

local function pmu_ser_HAL_read(byte)
    if byte > -1 then
        -- gcs:send_text(0, byte)
        local char = string.char(byte);
        if char == '\r' or char == '\n' then
            dataTowrite = logBuffer;
            logBuffer = "";
            return true;
        else
            logBuffer = logBuffer .. char;
            return false;
        end
    end
end

local function pmu_ser_HAL_write(dataTowrite)
    for i = 1, string.len(dataTowrite) do
        byteToWrite = tonumber(dataTowrite.sub(i,i));
        gcs:send_text(0, dataTowrite.sub(i,i));
        if byteToWrite ~= nil then
            port:write(byteToWrite);
        end
    end
    dataTowrite = "";
end

function update() -- this is the loop which periodically runs
    if not port then
        gcs:send_text(0, "No Scripting Serial Port");
        return update, 100;
    end
    local n_bytes = port:available();
    while n_bytes > 0 do
        local byte = port:read();
        if pmu_ser_HAL_read(byte) then
            gcs:send_text(0, "Got Command" .. dataTowrite);
            pmu_ser_HAL_write(dataTowrite);
        end        
    end
    return update, 10; -- reschedules the loop in 100 ms
end

return update(); -- run immediately before starting to reschedule