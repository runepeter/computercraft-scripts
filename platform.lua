local tArgs = {...}
local length = tonumber(tArgs[1]) 
local width = tonumber(tArgs[2])
local turnRight = true
local slot = 1

if width == nil then
    print("1. Place turtle facing direction of said platform on left side.")
    print("2. Load turtle with materials for the platform.")
    print("3. Type 'platform <length> <width>'")
end

function refuelTurtle()
  if turtle.getFuelLevel() <= 5 then
    print("Jeg er tom for brensel/bensin - fyll på og trykk ENTER for å fortsette.")
    read()
    for i = 1, 16, 1 do
      turtle.select(i)
      if turtle.refuel() then
        print("Refuel successful!")
        return
      end
    end
    refuelTurtle()
  end
end

function hentByggeklosser()
  for i = 1, 4, 1 do
    while turtle.suck() do
      print("Fyller på byggeklosser...")
    end
    turtle.turnRight()
  end
end

function selectSlot()

  if turtle.getItemCount(slot) > 0 then
    return
  end

  for i = 1, 16, 1 do
    if turtle.getItemCount(i) > 0 then
      slot = i
      turtle.select(i)
      return
    end
  end
  
  print("Tomt for byggematerialer. Fyll på for å fortsette byggingen.")
  hentByggeklosser()
  sleep(5)
  selectSlot()
end

refuelTurtle()
selectSlot()

turtle.dig()
turtle.forward()

for j = 1, width, 1 do

  for i = 1, length, 1 do

    refuelTurtle()
    selectSlot()

    turtle.digDown()
    turtle.placeDown()
    
    if i < length then
      turtle.dig()
      turtle.forward()
    end
  
  end
  
  if j < width then
 
    refuelTurtle()
    selectSlot()
 
    if turnRight == true then
      turtle.turnRight()
      turtle.dig()
      turtle.forward()
      turtle.turnRight()
      turnRight = false
    else
      turtle.turnLeft()
      turtle.dig()
      turtle.forward()
      turtle.turnLeft()
      turnRight = true
    end
    
  end
  
end
