function click(p, x, y, sec)--{{{
  mSleep(500)
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
  mSleep(sec or 1000)
end
--}}}
function click1(x, y, sec)--{{{
  click(1, x, y, sec)
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
function readAccount(line)--{{{
  local pos = 0
  local account
  for i = 1, 3 do
    pipe = string.find(line, '|', pos)
    if i == 3 then
      account = string.sub(line, pos, pipe - 1)
    else
      pos = pipe + 1
    end
  end
  return account
end
--}}}
function oneKeyNewPhone()--{{{
  runApp("org.ioshack.iGrimace")
  doFindColorInRegionFuzzy(0x942be9, 100, 326, 545, 332, 560)
  click1(475, 820) -- one key new machine
  doFindColorInRegionFuzzy(0x942be9, 100, 326, 545, 332, 560)
end
--}}}
function checkMoney()--{{{
  local ret = ""
  local number = {
    --{n=".", width=4,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n=".", width=4,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xfcfcfc,0|17|0xe4e4e4,0|18|0xe4e4e4,0|19|0xe4e4e4,0|20|0xffffff"},
    {n="0", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xebebeb,0|5|0xbebebe,0|6|0xa5a5a5,0|7|0x929292,0|8|0x878787,0|9|0x838383,0|10|0x818181,0|11|0x858585,0|12|0x8a8a8a,0|13|0x9b9b9b,0|14|0xaeaeae,0|15|0xd4d4d4,0|16|0xfafafa,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="1", width=9,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xfdfdfd,0|4|0xf5f5f5,0|5|0xf7f7f7,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="6", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xfafafa,0|7|0xe8e8e8,0|8|0xdbdbdb,0|9|0xcdcdcd,0|10|0xc0c0c0,0|11|0xc4c4c4,0|12|0xcfcfcf,0|13|0xdbdbdb,0|14|0xf4f4f4,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
  }
  local x = 448
  while x < 571 do
    for k, v in ipairs(number) do
      local x1, y1 =  findMultiColorInRegionFuzzy(v.color, v.posandcolor, 100, x, 391, x + 1, 412)
      if x1 > 0 then
        ret = ret .. v.n
        x = x + v.width
        break
      end
    end
    x = x + 1
  end
  return ret
end
--}}}
function main()--{{{
  --[[
  local accounts = io.open('/User/Media/TouchSprite/lua/zfb.txt')
  local accountsGood = io.open('/User/Media/TouchSprite/lua/zfb_good.txt', 'w')
  local accountsBad = io.open('/User/Media/TouchSprite/lua/zfb_bad.txt', 'w')
  for line in accounts:lines() do
    oneKeyNewPhone()

    runApp("com.alipay.iphoneclient")
    mSleep(3000)

    click1(82, 406)
    click1(397, 879)

    account = readAccount(line)
    mSleep(1000)
    inputText(account)
    click1(233, 299)
    mSleep(1000)
    inputText("pan1984")
    click1(317, 459)
    mSleep(1000)
    if doFindMultiColorInRegionFuzzy(true, 0x7d9fb5, "58|18|0xb0d6e8,141|26|0x09294f", 100, 225, 340, 411, 370, 20) then
      accountsGood:write(line .. "\n")

      click1(624 ,69)
      click1(480 ,638)

      --doFindMultiColorInRegionFuzzy(true, 0xde2f0d, "38|17|0xeb998a,114|28|0xd54023", 100, 178, 306, 318, 353)
      --click1(624 ,69)
      mSleep(5000)
      click1(20, 80)

      click1(581 ,1099) -- fortune
      money = checkMoney()
      click1(68 ,1099) -- zfb
      click1(233 ,418) -- zhaung zhang
      click1(174 ,1077) -- dao zfb

      click1(300, 800)
      click1(252 ,194)
      mSleep(1000)
      inputText("13828467364")
      click1(252 ,413)
      mSleep(1000)
      --inputText("1")
      --click1(574 ,1033) -- keyboard ok
      if doFindColorInRegionFuzzy(0x397af2, 100, 34, 747, 100, 800) then
        mSleep(1000)
        doFindColorInRegionFuzzy(0x397af2, 100, 34, 747, 100, 800)
      end
      click1(330 ,793) -- ok
      mSleep(1000)
      if findColorInRegionFuzzy(0x397af2, 100, 330, 664, 526, 730) > 0 then
        click1(452, 690) -- ok again
      end
      mSleep(1000)
      inputText("poon1984")
      click1(472 ,552) -- pay
      mSleep(5000)
    else
      accountsBad:write(line .. "\n")
    end
  end
  accounts.close()
  accountsGood.close()
  accountsBad.close()

  dialog("All Done", 0)
  ]]
  dialog(checkMoney(), 5)
end
--}}}
main()
