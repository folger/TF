general_blue = 0x007AFF
function click(p, x, y)--{{{
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
  mSleep(1000)
end --}}}
function click1(x, y)--{{{
  click(1, x, y)
end--}}}
function touch(func, p, x, y, vertical)--{{{
  if vertical then
    func(p, x, y)
  else
    func(p, y, x)
  end
end--}}}
function slide(p, x, y1, y2, vertical, step)--{{{
  touch(touchDown, p, x, y1, vertical)
  mSleep(500)
  if step > 0 then
    if y1 > y2 then
      step = -step
    end
    count = (y2 - y1) / step
    for i=1,count do
      touch(touchMove, p, x, y1 + i * step, vertical)
      mSleep(30)
    end
  else
    touch(touchMove, p, x, y2, vertical)
    mSleep(500)
  end
  touch(touchUp, p, x, y2, vertical)
end--}}}
function vslide1(x, y1, y2, step)--{{{
  slide(1, x, y1, y2, true, step)
end--}}}
function hslide1(x1, x2, y, step)--{{{
  slide(1, y, x1, x2, false, step)
end--}}}
function allPointsFoundInRegionFuzzy(points)--{{{
  for k, v in ipairs(points) do
    x, y = findColorInRegionFuzzy(v.c, 100, v.p[1], v.p[2], v.p[3], v.p[4])
    if x < 0 then
      return false
    end
  end
  return true
end--}}}
function readOneAccount()--{{{
  TBAccounts = io.open('/User/Media/TouchSprite/lua/TBAccounts.txt')
  line = TBAccounts:read()
  comma = string.find(line, ",")
  username = string.sub(line, 0, comma-1)
  password = string.sub(line, comma+1)
  TBAccounts:close()
  return username, password
end--}}}
function resetVPN()--{{{
  runApp("com.apple.Preferences")
  mSleep(3000)
  while true do
    x,y = findColorInRegionFuzzy(general_blue, 50, 51, 66, 120, 100)
    if x < 0 then
      break
    end
    click1(x, y) --check "Back"
  end
  click1(320, 10) --titlebar
  click1(58, 1084) --General
  for i=1, 2 do --slide to the end
    vslide1(300, 950, 150, 10)
    mSleep(700)
  end
  click1(54, 858) --VPN
end--}}}
function oneKeyNewMachine()--{{{
  runApp("org.ioshack.iGrimace")
  mSleep(3000)
  click1(237, 427) --program list
  click1(566, 82) --select all
  click1(38, 83) --back
  click1(475, 820) --one key new machine
  mSleep(2000)
  click1(475, 956) --quit
end--}}}
function taofen8()--{{{
  runApp("com.taofen8.TfClient")
  mSleep(3000)

  while true do
    hslide1(600, 100, 500, -1)
    mSleep(2000)
    points = {
      {c=0xFFFFFF, p={221, 997, 262, 1036}},
      {c=0xFFFFFF, p={264, 997, 304, 1036}},
      {c=0xFFFFFF, p={305, 997, 348, 1036}},
      {c=0xFFFFFF, p={349, 997, 389, 1036}},
    }
    if allPointsFoundInRegionFuzzy(points) then
      click1(300, 1000) --try now
      break
    end
  end

  mSleep(1000)
  x, y = findColorInRegionFuzzy(0xD3B00D, 90, 594, 168, 601, 175)
  if x > 0 then
    click1(x, y) --hint close button
  end

  mSleep(1000)
  click1(62, 465) --login

  for i=1,100 do
    mSleep(500)
    x,y = findColorInRegionFuzzy(0xFF5000, 90, 47, 166, 211, 209)
    if x > 0 then
      break
    end
  end

  username, password = readOneAccount()

  mSleep(500)
  click1(113, 279)
  inputText(username)
  mSleep(500)
  click1(319, 369)
  inputText(password)
  mSleep(500)
  click1(319, 490)
end--}}}
function main()--{{{
  init("0", 0)
  --resetVPN()
  oneKeyNewMachine()
  taofen8()
end--}}}

main()
