rednet.open("back")
local monitor = peripheral.find("monitor")
monitor.clear()
monitor.setCursorPos(1, 1)
monitor.setTextColor(colors.green)
monitor.write("CNC: Is now online")

while true do
  local sender, message, protocol = rednet.receive()
  print("Message from turtle: " .. message)
  local data = textutils.unserializeJSON(message)
  if data then
    if data.operation == "Starting" then
      monitor.setCursorPos(1, 2)
      monitor.write("Connected to robot: " .. sender)
    elseif data.operation == "Update" then
      monitor.setCursorPos(1, 3)
      monitor.write("Blocks broken: " .. data.count)
    elseif data.operation == "Returning" then
      monitor.setCursorPos(1, 4)
      monitor.setTextColor(colors.red)
      monitor.write("Returning: " .. data.reason .. " at " .. data.count .. " blocks")
    end
  end
end
