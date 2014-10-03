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
    if v.found == 0 then
      x, y = findMultiColorInRegionFuzzy(v.color, v.posandcolor, 100, 5, 135, 111, 1135)
      if x > 0 then
        click1(x, y)
        click1(317, 747) -- start task
        mSleep(500)
        if findColorInRegionFuzzy(general_blue, 100, 289, 630, 358, 663) > 0 then
          v.found = -1
          click1(322, 649) -- same task too many times
          click1(557, 324)
        else
          v.found = 1
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
function generateUsernameAndPassword(len)--{{{
  len = len or 6
  local charMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  local name = ""
  math.randomseed(os.time())
  for i = 1, len do
    n = math.random(#charMap)
    name = name .. string.sub(charMap, n, n)
  end
  return name, name .. name
end
--}}}
function clearText(len)--{{{
  len = len or 30
 local text = ""
 for i = 1, len do
   text = text .. "\b"
 end
 inputText(text)
end--}}}
function skipHint()--{{{
  click1(100, 100) -- skip hint
end--}}}
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
function dianping()--{{{
  runApp("com.dianping.dpscope")

  doFindMultiColorInRegionFuzzy(true, 0xff8400, "29|16|0xffebdf,117|30|0xffa867", 100, 244, 914, 402, 960, nil, generalHSlide)
  click1(254, 926) -- experience now

  mSleep(500)
  click1(66, 252) -- GPS position

  doFindMultiColorInRegionFuzzy(true, 0xffa955, "14|19|0xfeeee0,49|56|0xffeedf", 100, 36, 151, 152, 254)
  click1(64, 165) -- food

  doFindMultiColorInRegionFuzzy(true, 0x948b7e, "15|12|0xd3d0ca", 100, 592, 243, 617, 371)
  click1(596, 343) -- first food

  mSleep(1000)
end
--}}}
function xiecheng()--{{{
  runApp("ctrip.com")

  doFindMultiColorInRegionFuzzy(true, 0xff929f, "26|4|0xffffff,48|33|0xff6073", 100, 52, 300, 173, 401, nil, generalHSlide)

  local goback = function() click1(37, 84) end

  click1(88, 317) -- hotel
  goback()
  click1(319, 317) -- plane tickets
  goback()
  click1(519, 317) -- train tickets
  goback()
  click1(88, 517) -- tuan gou
  goback()
  click1(319, 517) -- self drive
  goback()
  click1(519, 517) -- car tickets
  goback()

  mSleep(1000)
end
--}}}
function gaode()--{{{
  runApp("com.autonavi.amap")

  doFindMultiColorInRegionFuzzy(true, 0x33afd2, "60|19|0xffffff,108|26|0xadd9e9", 100, 261, 1025, 376, 1055, nil, generalHSlide)
  click1(265, 1027) -- start map

  local goback = function() click1(27, 85) end

  click1(344, 1027) -- agree
  click1(63, 1114) -- routine
  goback()
  click1(227, 1116) -- go out
  skipHint()
  click1(401, 66) -- by bus
  click1(84, 527) -- bus
  goback()
  click1(414, 537) -- train
  goback()
  click1(45, 697) -- hotel
  goback()
  click1(253, 675) -- plane
  goback()
  goback()
  for i = 1, 3 do
    generalVSlide()
  end

  mSleep(1000)
end
--}}}
function yilong()--{{{
  runApp("com.elong.app")
  
  doFindMultiColorInRegionFuzzy(true, 0xf04949, "47|36|0xffffff,150|123|0xf05a5a", 100, 7, 295, 319, 572, nil, generalHSlide)

  local goback = function() click1(1, 93) end

  click1(146, 425) -- hotel
  goback()
  click1(443, 438) -- plane tickets
  click1(415, 192) -- back & forth
  goback()
  click1(146, 710) -- today special
  goback()
  click1(443, 710) -- train tickets
  goback()
  click1(443, 914) -- train tickets
  goback()

  mSleep(1000)
end
--}}}
function haodou()--{{{
  runApp("com.haodou.cookbook")
  mSleep(3000)

  click1(318, 1021) -- experience now
  skipHint()

  click1(46, 71) -- menu
  skipHint()
  click1(100, 100) -- register

  click1(304, 800) -- register
  click1(478, 162) -- email register

  while true do
    username, password = generateUsernameAndPassword()
    click1(98, 279) -- email
    mSleep(1000)
    clearText()
    inputText(username .. "@163.com")
    click1(98, 395) -- nickname
    mSleep(1000)
    clearText()
    inputText(username)
    click1(98, 511) -- nickname
    mSleep(1000)
    clearText()
    inputText(password)
    click1(317, 644) -- done

    if doFindMultiColorInRegionFuzzy(true, 0xb2b2b2, "41|8|0x979797,52|93|0xe4e4e4", 100, 34, 166, 209, 326, 5) then
      break
    end
  end

  click1(46, 71) -- menu
  click1(149, 289) -- main page
  click1(317, 160) -- discover
  skipHint()
  click1(531, 160) -- square
  click1(88, 294) -- happy in kitchen
  click1(43, 170) -- first food in kitchen

  mSleep(1000)
end
--}}}
function zhuche()--{{{
  runApp("com.szzc.szzc")

  doFindMultiColorInRegionFuzzy(true, 0xfcd36a, "19|12|0xffffff,48|47|0xfabb1d", 100, 49, 377, 111, 437)

  local goback = function() click1(6,71) end

  click1(67, 411) -- nearby
  goback()
  click1(226, 411) -- my
  goback()
  click1(398, 411) -- invite
  goback()
  click1(64, 655) -- self drive
  goback()
  click1(538, 674) -- shun feng
  goback()
  click1(287, 1001) -- shop
  goback()
  click1(287, 674) -- long rent
  click1(522, 216) -- city
  click1(488, 212) -- one city
  click1(515, 552) -- brand
  click1(584, 1099) -- ok
  click1(535, 659) -- model
  click1(345, 1093) -- next
  goback()
  goback()

  mSleep(1000)
end
--}}}
function guomei()--{{{
  runApp("com.gome.gomeEShop")

  doFindMultiColorInRegionFuzzy(true, 0xc6de5d, "33|27|0xaed11c,140|66|0xffffff", 100, 118, 791, 520, 916, nil, generalHSlide)
  click1(159, 828) -- go
  mSleep(2000)
  skipHint()
  mSleep(2000)
  click1(197, 1109) -- category
  mSleep(1000)
  click1(332,1111) -- search
  mSleep(1000)
  click1(447,1102) -- shopping car
  mSleep(1000)
  click1(594,1111) -- my
  mSleep(1000)
  click1(80,1111) -- first page
  mSleep(1000)

  local goback = function() click1(43, 61) end

  click1(41, 455) -- yao yao mei
  goback()
  click1(185, 455) -- charge phone
  goback()
  click1(312, 455) -- lottery
  goback()
  click1(619, 455) -- more service

  mSleep(1000)
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

  tryFenZhuang = 0
  while true do
    if doFindMultiColorInRegionFuzzy(true, 0x788fd1, "26|40|0xffffff,79|47|0xffffff,101|5|0xec1313", 100, 189, 659, 319, 788, 10) then
      click1(245, 726) -- fen zhuang
      break
    end
    if tryFenZhuang > 0 then
      dialog("Cannot find fen zhuang, try next user", 3)
      return
    end
    tryFenZhuang = tryFenZhuang + 1
    click1(571, 174) -- click close button and try again
    generalVSlide()
    mSleep(1000)
    click1(62, 465) -- login
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
    if v.found == 1 then
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
          "list": "百度糯米,大众点评,携程旅游,高德地图,艺龙,好豆菜谱,神州租车,国美"
        }
      ]
    }
  ]])

  if ret == 1 and #check_1 ~= 0 then
    local alltasks = {
      {func=nuomi, color=0xf84775, posandcolor="26|24|0xf5fcfc,54|28|0xfc9cbc,37|56|0xf7648d", found=0},
      {func=dianping, color=0xffa04c, posandcolor="19|14|0xea7515,43|25|0xe8a785,64|52|e69b6b", found=0},
      {func=xiecheng, color=0x1c80fa, posandcolor="17|17|0xdeebfd,54|40|oxfe9913,78|71|bbd5f8", found=0},
      {func=gaode, color=0xc4e3a5, posandcolor="17|0|0xfedb82,36|30|0x0093fd,60|64|0xb0d3f5", found=0},
      {func=yilong, color=0xf59ca3, posandcolor="21|13|0xe81828,50|22|0xfef5f6,49|41|0xd94550", found=0},
      {func=haodou, color=0x7ec41e, posandcolor="14|12|0xfee400,53|21|0xfc7900,64|63|0x66a40d", found=0},
      {func=zhuche, color=0xfabd00, posandcolor="27|22|0x1a2938,5|44|0x0d203b,75|43|0x162639", found=0},
      {func=guomei, color=0xe84848, posandcolor="25|15|0xef9f9f,57|45|0xffffff,75|63|0xc51515", found=0},
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
        secs = 180
        dialogRet(string.format("Next user is %s, please wait %d secs", username, secs), "Start Now", 0, 0, secs)
      else
        first = false
      end
      for k, v in ipairs(tasks) do
        v.found = 0
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
