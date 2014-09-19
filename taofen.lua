--constants{{{
general_blue = 0x007AFF
--}}}
function click(p, x, y)--{{{
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
  mSleep(1000)
end
--}}}
function click1(x, y)--{{{
  click(1, x, y)
end
--}}}
function touch(func, p, x, y, vertical)--{{{
  if vertical then
    func(p, x, y)
  else
    func(p, y, x)
  end
end
--}}}
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
end
--}}}
function vslide1(x, y1, y2, step)--{{{
  slide(1, x, y1, y2, true, step)
end
--}}}
function hslide1(x1, x2, y, step)--{{{
  slide(1, y, x1, x2, false, step)
end
--}}}
function allPointsFoundInRegionFuzzy(points)--{{{
  for k, v in ipairs(points) do
    x, y = findColorInRegionFuzzy(v.c, 100, v.p[1], v.p[2], v.p[3], v.p[4])
    if x < 0 then
      return false
    end
  end
  return true
end
--}}}
function allPointsColorMatch(points)--{{{
  for k, v in ipairs(points) do
    if v.c ~= getColor(v.p[1], v.p[2]) then
      return false
    end
  end
  return true
end
--}}}
function doFindColorInRegionFuzzy(color, degree, x1, y1, x2, y2, times)--{{{
  for i=1,times do
    mSleep(500)
    x,y = findColorInRegionFuzzy(color, degree, x1, y1, x2, y2)
    if x > 0 then
      return true
    end
  end
  return false
end
--}}}
function readOneAccount()--{{{
  TBAccounts = io.open('/User/Media/TouchSprite/lua/TBAccounts.txt')
  line = TBAccounts:read()
  comma = string.find(line, ",")
  username = string.sub(line, 0, comma-1)
  password = string.sub(line, comma+1)
  TBAccounts:close()
  return username, password
end
--}}}
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
end
--}}}
function oneKeyNewMachine()--{{{
  runApp("org.ioshack.iGrimace")
  mSleep(3000)
  click1(237, 427) --program list
  click1(566, 82) --select all
  click1(38, 83) --back
  click1(475, 820) --one key new machine
  mSleep(2000)
  click1(475, 956) --quit
end
--}}}
function prepareTasks(tasks)--{{{
  for k, v in ipairs(tasks) do
    if not v.found then
      x, y = findImageInRegionFuzzy(v.image, 50, 5, 135, 111, 1135, 0xFFFFFF)
      if x > 0 then
        v.found = true
      end
    end
  end
end
--}}}
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

  ::click_close::
  mSleep(1500)
  if doFindColorInRegionFuzzy(0xD3B00D, 70, 594, 168, 601, 175, 3) then
    mSleep(500)
    click1(x, y)
  else
    vslide1(200, 150, 950, 10)
    mSleep(2000)
  end

  mSleep(1000)
  click1(62, 465) --login
  mSleep(1000)

  if not doFindColorInRegionFuzzy(0xFF5000, 90, 47, 166, 211, 209, 25) then
    dialog("fail to load taobao login page", 5)
    return
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
  mSleep(3000)

  points = {
    {c=0x788FD1, p={203, 684}},
    {c=0x788FD1, p={203, 779}},
    {c=0x788FD1, p={299, 779}},
    {c=0xEB0A0A, p={299, 686}},
    {c=0xFFFFFF, p={249, 731}},
  }
  if allPointsColorMatch(points) then
    mSleep(500)
    click1(249, 731) --fen zhuang
  end

  points = {
    {c=0xF73D7F, p={145, 791}},
    {c=0xF73D7F, p={145, 860}},
    {c=0xF73D7F, p={493, 791}},
    {c=0xF73D7F, p={493, 860}},
    {c=0xFFFFFF, p={283, 833}},
  }
  if allPointsColorMatch(points) then
    mSleep(500)
    click1(283, 833) --ok, I know
  end

  tasks = {
    {image="nuomi.png", found=false},
  }
  for i=1,10 do
    prepareTasks(tasks)
    vslide1(200, 950, 150, 10)
    mSleep(2000)
  end
end
--}}}
function main()--{{{
  init("0", 0)
  --resetVPN()
  oneKeyNewMachine()
  taofen8()
end
--}}}

main()
