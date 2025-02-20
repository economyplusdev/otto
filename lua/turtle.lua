-- turtle.lua
rednet.open("right")
rednet.broadcast('{"operation": "Starting"}')

local totalBlocks = 500
local blocksBroken = 0

local function returnToStart(distance)
  turtle.turnLeft()
  turtle.turnLeft()
  for i = 1, distance do
    while not turtle.forward() do
      turtle.dig()
      sleep(0.5)
    end
  end
  turtle.turnLeft()
  turtle.turnLeft()
end

for i = 1, totalBlocks do
  local fuelLevel = turtle.getFuelLevel()
  if fuelLevel ~= "unlimited" and fuelLevel < (blocksBroken + 1) then
    rednet.broadcast(textutils.serializeJSON({
      operation = "Returning",
      reason = "Low Fuel",
      count = blocksBroken
    }))
    returnToStart(blocksBroken)
    return
  end

  turtle.dig()
  while not turtle.forward() do
    turtle.dig()
    sleep(0.5)
  end
  turtle.digUp()
  sleep(0.5)
  blocksBroken = blocksBroken + 1
  rednet.broadcast(textutils.serializeJSON({operation = "Update", count = blocksBroken}))
end

rednet.broadcast(textutils.serializeJSON({
  operation = "Returning",
  reason = "Completed",
  count = blocksBroken
}))

turtle.turnLeft()
turtle.turnLeft()
for i = 1, blocksBroken do
  while not turtle.forward() do
    turtle.dig()
    sleep(0.5)
  end
end
turtle.turnLeft()
turtle.turnLeft()
