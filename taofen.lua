--constants{{{
general_blue = 0x007AFF
--}}}
function click(p, x, y)--{{{
  mSleep(500)
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
  mSleep(500)
end
--}}}
function click1(x, y)--{{{
  click(1, x, y)
end
--}}}
function slide(p, x, y1, y2, vertical, step)--{{{
  local touch = function(func, x, y)
    if vertical then
      func(p, x, y)
    else
      func(p, y, x)
    end
  end
  touch(touchDown, x, y1)
  mSleep(500)
  if step > 0 then
    if y1 > y2 then
      step = -step
    end
    count = (y2 - y1) / step
    for i = 1, count do
      touch(touchMove, x, y1 + i * step)
      mSleep(30)
    end
  else
    touch(touchMove, x, y2)
    mSleep(500)
  end
  touch(touchUp, x, y2)
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
  for x = x1, x2 - 1 do
    for y = y1, y2 - 1 do
      if color ~= getColor(x, y) then
        return false
      end
    end
  end
  return true
end
--}}}
function doFindColorInRegionFuzzy(color, degree, x1, y1, x2, y2, times)--{{{
  return doFindMultiColorInRegionFuzzy(true, color, nil, degree, x1, y1, x2, y2, times)
end
--}}}
function doFindMultiColorInRegionFuzzy(iffound, color, posandcolor, degree, x1, y1, x2, y2, times, notFoundFunc)--{{{
  times = times or 10000
  for i = 1, times do
    mSleep(500)
    if posandcolor then
      x, y = findMultiColorInRegionFuzzy(color, posandcolor, degree, x1, y1, x2, y2)
    else
      x, y = findColorInRegionFuzzy(color, degree, x1, y1, x2, y2)
    end
    x = iffound and x or -x
    if x > 0 then
      return true
    end
    if notFoundFunc then
      notFoundFunc()
    end
  end
  return false
end
--}}}
function resetVPN()--{{{
  runApp("com.apple.Preferences")
  mSleep(2000)
  while true do
    x,y = findColorInRegionFuzzy(general_blue, 50, 51, 66, 120, 100)
    if x < 0 then
      break
    end
    click1(x, y) -- check "Back"
  end
  click1(320, 10) -- titlebar
  click1(531, 319) -- close VPN
  mSleep(1000)
  click1(580, 319) -- open VPN
end
--}}}
function oneKeyNewPhone()--{{{
  runApp("org.ioshack.iGrimace")
  doFindColorInRegionFuzzy(0x942be9, 100, 326, 545, 332, 560)
  --click1(237, 427) -- program list
  --click1(566, 82) -- select all
  --click1(38, 83) -- back
  click1(475, 820) -- one key new machine
  doFindColorInRegionFuzzy(0x942be9, 100, 326, 545, 332, 560)
  --click1(475, 956) -- quit
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
        doFindMultiColorInRegionFuzzy(true, 0x8a8a8a, "47|23|0xa6a6a6,66|3|0xe8e8e8", 100, 73, 401, 152, 427)
        if allPointsInRegionColorMatch(general_blue, 583, 324, 585, 351) then -- download cloud
          click1(583, 324)
          while true do -- downloading
            mSleep(1000)
            resetIDLETimer()
            if allPointsInRegionColorMatch(general_blue, 581, 324, 582, 343) then -- open button
              break
            end
          end
        end
        runApp("com.taofen8.TfClient")
        mSleep(1000)
      end
    end
  end
end
--}}}
function generalHSlide(sleep)--{{{
  hslide1(600, 100, 500, 100)
  mSleep(sleep or 500)
end
--}}}
function generalVSlide(sleep)--{{{
  vslide1(200, 150, 500, 100)
  mSleep(sleep or 500)
end
--}}}
function nuomi()--{{{
  runApp("com.renren-inc.nuomi")

  doFindMultiColorInRegionFuzzy(true, 0x111111, "43|-6|0x111111,86|-6|0x111111,125|0|0x111111", 100, 245, 66, 390, 102, nil, generalHSlide)
  click1(111, 316) -- GPS position

  doFindMultiColorInRegionFuzzy(true, 0xff9c00, "18|12|0xffffff,53|52|0xffb94a", 100, 35, 346, 126, 428)
  click1(46, 357) -- food

  doFindMultiColorInRegionFuzzy(true, 0xff93af, "9|10|0xffd7e1", 100, 274, 255, 634, 689)
  click1(284, 446) -- first food

  mSleep(1000)
end
--}}}
function dazhong()--{{{
  runApp("com.dianping.dpscope")

  doFindMultiColorInRegionFuzzy(true, 0xff8400, "29|16|0xffebdf,117|30|0xffa867", 100, 244, 914, 402, 960, nil, generalHSlide)
  click1(254, 926) -- experience now

  mSleep(500)
  click1(66, 252) -- GPS position

  doFindMultiColorInRegionFuzzy(true, 0xffa955, "14|19|0xfeeee0,49|56|0xffeedf", 100, 36, 151, 152, 254)
  click1(64, 165) -- food

  doFindMultiColorInRegionFuzzy(true, 0x948b7e, "15|12|0xd3d0ca", 100, 592, 243, 617, 371)
  click1(596, 343) -- first food

  mSlepp(1000)
end
--}}}
function xiecheng()--{{{
end
--}}}
function gaode()--{{{
end
--}}}
function yilong()--{{{
end
--}}}
function haodou()--{{{
  runApp("com.haodou.cookbook")
  mSleep(1000)
end
--}}}
function zhuche()--{{{
end
--}}}
function taofen8(tasks, username, password)--{{{
  runApp("com.taofen8.TfClient")

  doFindMultiColorInRegionFuzzy(true, 0xffffff, "56|-3|0xffffff,98|-5|0xffffff,179|-9|0x88b9ec", 100, 165, 978, 468, 1056, nil, generalHSlide)
  click1(236, 1005) -- try now

  mSleep(1000)
  -- check refresh page
  doFindMultiColorInRegionFuzzy(false, 0xb7b6b6, "23|18|0xcfcece", 100, 125, 617, 156, 647, nil, generalVSlide)

  if doFindColorInRegionFuzzy(0xD3B00D, 70, 594, 168, 601, 175, 3) then
    click1(597, 171) -- close button
  end

  mSleep(1000)
  click1(62, 465) -- login
  mSleep(1000)

  if not doFindMultiColorInRegionFuzzy(true, 0x6f2005, "25|11|0xdc4001,47|4|0xffd0bc", 100, 249, 461, 391, 511, 60) then
    dialog("fail to load taobao login page", 5)
    return
  end

  mSleep(1000)
  click1(113, 279)
  mSleep(1000)
  inputText(username)
  click1(319, 369)
  mSleep(1000)
  inputText(password)
  click1(319, 490)

  if doFindMultiColorInRegionFuzzy(true, 0x788fd1, "26|40|0xffffff,79|47|0xffffff,101|5|0xec1313", 100, 189, 659, 319, 788, 20) then
    click1(245, 726) -- fen zhuang
  else
    dialog("Cannot find fen zhuang, try next user", 3)
    return
  end

  doFindMultiColorInRegionFuzzy(true, 0xf73d7f, "93|36|0xffffff,139|44|0xffffff,202|37|0xffffff", 100, 141, 788, 498, 863)
  click1(244, 820) -- ok, I know

  mSleep(1000)

  for i=1,3 do
    prepareTasks(tasks)
    vslide1(200, 500, 150, 40)
    mSleep(2000)
  end
  for k,v in ipairs(tasks) do
    if v.found then
      v.func()
    end
  end
end
--}}}
function main()--{{{
  init("0", 0)

  local ret, check_1 = showUI([[
    {
      "style": "default",
      "config": "save_taofen8.dat",
      "views": [
        {
          "type": "Label",
          "text": "任务",
          "size": 25,
          "align": "center",
          "color": "0,0,255",
        },
        {
          "type": "CheckBoxGroup",
          "list": "百度糯米,大众点评,携程旅游,高德地图,艺龙,好豆菜谱,神州租车"
        }
      ]
    }
  ]])

  if ret == 1 and #check_1 ~= 0 then
    local alltasks = {
      {func=nuomi, color=0xf84775, posandcolor="26|24|0xf5fcfc,54|28|0xfc9cbc,37|56|0xf7648d", found=false},
      {func=dazhong, color=0xffa04c, posandcolor="19|14|0xea7515,43|25|0xe8a785,64|52|e69b6b", found=false},
      {func=xiecheng, color=0x000000, posandcolor="", found=false},
      {func=gaode, color=0xc4e3a5, posandcolor="17|0|0xfedb82,36|30|0x0093fd,60|64|0xb0d3f5", found=false},
      {func=yilong, color=0x00000, posandcolor="", found=false},
      {func=haodou, color=0x7ec41e, posandcolor="14|12|0xfee400,53|21|0xfc7900,64|63|0x66a40d", found=false},
      {func=zhuche, color=0xfabd00, posandcolor="27|22|0x1a2938,5|44|0x0d203b,75|43|0x162639", found=false},
    }
    local tasks = {}
    local pos = 0
    while true do
      local at = string.find(check_1, "@", pos)
      if not at then
        table.insert(tasks, alltasks[tonumber(string.sub(check_1, pos)) + 1])
        break
      end
      table.insert(tasks, alltasks[tonumber(string.sub(check_1, pos, at - 1)) + 1])
      pos = at + 1
    end

    local TBAccounts = io.open('/User/Media/TouchSprite/lua/TBAccounts.txt')
    local first = true
    while true do
      local line = TBAccounts:read()
      if not line then
        dialog("all suers finished", 5)
        break
      end
      local comma = string.find(line, ",")
      local username = string.sub(line, 0, comma-1)
      local password = string.sub(line, comma+1)

      if not first then
        secs = 5
        dialogRet(string.format("Next user is %s, please wait %d secs", username, secs), "Start Now", 0, 0, secs)
      else
        first = false
      end
      for k, v in ipairs(tasks) do
        v.found = false
      end

      --oneKeyNewPhone()
      --resetVPN()
      oneKeyNewPhone()
      taofen8(tasks, username, password)
      pressHomeKey(0)
      pressHomeKey(1)
    end
    TBAccounts:close()
  end
end
--}}}
main()
