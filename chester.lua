local tArgs = {...}
local block = "STONE"

if #tArgs > 0 then
  block = tArgs[1]
end

function refuelTurtle()
  while turtle.getFuelLevel() <= 5 do
    turtle.select(16)
    if turtle.refuel() then
      print("Successfull refuel!")
    else
      print("Put fuel in slot 16 to refuel.")
      sleep(5)
    end
  end
end

print("GPS Location in progress...")
local x,y,z = gps.locate(10, true)
print("x=",x,",y=",y,",z=",z)

refuelTurtle()

-- place main chest
turtle.select(1)
turtle.digUp()
turtle.up()
turtle.placeDown()

-- place additional chest
turtle.turnRight()
turtle.dig()
turtle.forward()
turtle.digDown()
turtle.turnLeft()
turtle.placeDown()

-- initiate wireless broadcast
rednet.open("right")
rednet.broadcast("Chester serving ", block, " ready for duty!")

-- wait for incoming requests
while true do
  local sender, msg, distance = rednet.receive()
  print("Received [", msg, "] from ", sender, ".")

  local array = {}
  for w in string.gmatch(msg, "%a+") do
    array[#array + 1] = w 
  end
  
  print("Command: ",array[1],", block: ",array[2],".")

  if "DELIVERY" == array[1] then
    print("Processing DELIVERY request...")

    if block == array[2] then
      print("Yes, we can deliver ",block,".")
    else
      print("Sorry, we cannot deliver [",array[2],"] as requested. We only deliver [",block,"].")
    end
  end
end


