
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

function buildWall()
  while turtle.detectDown() do
    refuelTurtle()
    selectSlot()

    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    turtle.turnRight()
    turtle.place()
    turtle.turnLeft()
    turtle.turnLeft()
  end

  turtle.turnRight()
  turtle.turnRight()
  turtle.dig()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
end

local x,y,z = gps.locate()
print("x=", x, ",y=", y, ",z=", z)

function buildThatShit()
  buildWall()

  local a,b,c = gps.locate()

  if a=x and b=y and c=z then
    print("Completed one round")
  else
    turtle.turnRight()  
  end
end

buildThatShit()

