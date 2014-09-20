--constants{{{
general_blue = 0x007AFF
--}}}
function click(p, x, y)--{{{
  mSleep(500)
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
function allPointsInRegionColorMatch(color, x1, y1, x2, y2)--{{{
  for x = x1,x2 - 1 do
    for y = y1,y2 - 1 do
      if color ~= getColor(x, y) then
        return false
      end
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
    click1(x, y) -- check "Back"
  end
  click1(320, 10) -- titlebar
  click1(58, 1084) -- General
  for i=1, 2 do -- slide to the end
    vslide1(300, 950, 150, 10)
    mSleep(700)
  end
  click1(54, 858) -- VPN
end
--}}}
function oneKeyNewMachine()--{{{
  runApp("org.ioshack.iGrimace")
  mSleep(3000)
  click1(237, 427) -- program list
  click1(566, 82) -- select all
  click1(38, 83) -- back
  click1(475, 820) -- one key new machine
  mSleep(2000)
  click1(475, 956) -- quit
end
--}}}
function prepareTasks(tasks)--{{{
  for k, v in ipairs(tasks) do
    if not v.found then
      x, y = findMultiColorInRegionFuzzy(v.color, v.posandcolor, 100, 5, 135, 111, 1135)
      if x > 0 then
        v.found = true
        click1(x, y)
        click1(317, 747) -- start task
        mSleep(5000)
        if allPointsInRegionColorMatch(0x007AFF, 583, 324, 585, 351) then -- download cloud
          click1(583, 324)
          while true do -- downloading
            mSleep(1000)
            resetIDLETimer()
            if allPointsInRegionColorMatch(0x007AFF, 581, 324, 582, 343) then -- open button
              break
            end
          end
        end
        runApp("com.taofen8.TfClient")
        mSleep(3000)
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
    x,y = findMultiColorInRegionFuzzy(0xffffff, "56|-3|0xffffff,98|-5|0xffffff,179|-9|0x88b9ec", 100, 165, 978, 468, 1056)
    if x > 0 then
      click1(300, 1000) -- try now
      break
    end
  end

  mSleep(1500)
  if doFindColorInRegionFuzzy(0xD3B00D, 70, 594, 168, 601, 175, 3) then
    click1(x, y)
  end

  mSleep(1000)
  click1(62, 465) -- login
  mSleep(1000)

  if not doFindColorInRegionFuzzy(0xFF5000, 90, 47, 166, 211, 209, 25) then
    dialog("fail to load taobao login page", 5)
    return
  end

  mSleep(1000)
    
  username, password = readOneAccount()

  click1(113, 279)
  inputText(username)
  click1(319, 369)
  inputText(password)
  click1(319, 490)
  mSleep(3000)

  x, y = findMultiColorInRegionFuzzy(0x788fd1, "26|40|0xffffff,79|47|0xffffff,101|5|0xec1313", 100, 189, 659, 319, 788)
  if x > 0 then
    click1(249, 731) -- fen zhuang
  end

  x, y = findMultiColorInRegionFuzzy(0xf73d7f, "93|36|0xffffff,139|44|0xffffff,202|37|0xffffff", 100, 141, 788, 498, 863)
  if x > 0 then
    click1(283, 833) -- ok, I know
  end

  tasks = {
    {name="nuomi", color=0xf84775, posandcolor="26|24|0xf5fcfc,54|28|0xfc9cbc,37|56|0xf7648d", found=false},
    {name="gaode", color=0xc4e3a5, posandcolor="17|0|0xfedb82,36|30|0x0093fd,60|64|0xb0d3f5", found=false},
    {name="zhuche", color=0xfabd00, posandcolor="27|22|0x1a2938,5|44|0x0d203b,75|43|0x162639", found=false},
  }
  for i=1,5 do
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
