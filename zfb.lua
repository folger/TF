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
function doFindColorInRegionFuzzy(color, degree, x1, y1, x2, y2, times, notFoundFunc)--{{{
  return doFindMultiColorInRegionFuzzy(true, color, nil, degree, x1, y1, x2, y2, times, notFoundFunc)
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
  local line = trimRight(line)
  local account_info = {}
  local pos = 0
  while true do
    local pipe = string.find(line, '|', pos)
    if not pipe then
      table.insert(account_info,  string.sub(line, pos))
      break
    end
    table.insert(account_info,  string.sub(line, pos, pipe - 1))
    pos = pipe + 1
  end
  return table.unpack(account_info)
end
--}}}
function oneKeyNewPhone()--{{{
  runApp("org.ioshack.iGrimace")
  doFindColorInRegionFuzzy(0xffffff, 100, 326, 582, 332, 592)
  click1(475, 820) -- one key new machine
  doFindColorInRegionFuzzy(0xffffff, 100, 326, 582, 332, 592)
end
--}}}
function checkMoney()--{{{
  local ret = ""
  --[[
  local number = {
    --{n=".", width=4,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n=".", width=4, color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xfcfcfc,0|17|0xe4e4e4,0|18|0xe4e4e4,0|19|0xe4e4e4,0|20|0xffffff"},
    {n="0", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xf1f1f1,0|7|0xdfdfdf,0|8|0xd4d4d4,0|9|0xd0d0d0,0|10|0xcecece,0|11|0xd2d2d2,0|12|0xd7d7d7,0|13|0xe8e8e8,0|14|0xfafafa,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="1", width=9, color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xfdfdfd,0|4|0xf5f5f5,0|5|0xf7f7f7,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="2", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xfefefe,0|5|0xf2f2f2,0|6|0xe1e1e1,0|7|0xf8f8f8,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xf9f9f9,0|17|0xd0d0d0,0|18|0xb0b0b0,0|19|0x909090,0|20|0xffffff"},
    {n="3", width=15,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xf6f6f6,0|6|0xeeeeee,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xf1f1f1,0|14|0xa9a9a9,0|15|0xc1c1c1,0|16|0xdfdfdf,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="4", width=15,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xcdcdcd,0|13|0x919191,0|14|0x919191,0|15|0xd8d8d8,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="5", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xe5e5e5,0|15|0xcccccc,0|16|0xeeeeee,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="6", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xfafafa,0|7|0xe8e8e8,0|8|0xdbdbdb,0|9|0xcdcdcd,0|10|0xc0c0c0,0|11|0xc4c4c4,0|12|0xcfcfcf,0|13|0xdbdbdb,0|14|0xf4f4f4,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="7", width=14,color=0xf7f7f7, posandcolor="0|1|0xf0f0f0,0|2|0xf4f4f4,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="8", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xf1f1f1,0|13|0xd5d5d5,0|14|0xcdcdcd,0|15|0xe9e9e9,0|16|0xfefefe,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="9", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xfefefe,0|4|0xe6e6e6,0|5|0xcacaca,0|6|0xb2b2b2,0|7|0xbfbfbf,0|8|0xd6d6d6,0|9|0xf4f4f4,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xfafafa,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
  }
  local numberAfterPoint = {
    {n="0", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xebebeb,0|5|0xbebebe,0|6|0xa5a5a5,0|7|0x929292,0|8|0x878787,0|9|0x838383,0|10|0x818181,0|11|0x858585,0|12|0x8a8a8a,0|13|0x9b9b9b,0|14|0xaeaeae,0|15|0xd4d4d4,0|16|0xfafafa,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="1", width=9, color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xf2f2f2,0|4|0xa8a8a8,0|5|0xbbbbbb,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="2", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xfafafa,0|19|0xdcdcdc,0|20|0xffffff"},
    {n="3", width=15,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xfcfcfc,0|14|0xf6f6f6,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="4", width=15,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xfcfcfc,0|13|0xdedede,0|14|0xdedede,0|15|0xf3f3f3,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="5", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xf3f3f3,0|9|0xd8d8d8,0|10|0xcccccc,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xcacaca,0|15|0x7f7f7f,0|16|0xa1a1a1,0|17|0xe2e2e2,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="6", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xffffff,0|5|0xebebeb,0|6|0xb7b7b7,0|7|0x9c9c9c,0|8|0x8e8e8e,0|9|0x818181,0|10|0x737373,0|11|0x777777,0|12|0x828282,0|13|0x8e8e8e,0|14|0xaaaaaa,0|15|0xdadada,0|16|0xfdfdfd,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="7", width=14,color=0xcfcfcf, posandcolor="0|1|0xa3a3a3,0|2|0xbcbcbc,0|3|0xffffff,0|4|0xffffff,0|5|0xffffff,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xffffff,0|16|0xffffff,0|17|0xffffff,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="8", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xffffff,0|4|0xf9f9f9,0|5|0xf1f1f1,0|6|0xffffff,0|7|0xffffff,0|8|0xffffff,0|9|0xffffff,0|10|0xffffff,0|11|0xebebeb,0|12|0xa8a8a8,0|13|0x888888,0|14|0x808080,0|15|0x9c9c9c,0|16|0xbababa,0|17|0xf5f5f5,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
    {n="9", width=14,color=0xffffff, posandcolor="0|1|0xffffff,0|2|0xffffff,0|3|0xd8d8d8,0|4|0x999999,0|5|0x7d7d7d,0|6|0x676767,0|7|0x727272,0|8|0x8a8a8a,0|9|0xb1b1b1,0|10|0xf7f7f7,0|11|0xffffff,0|12|0xffffff,0|13|0xffffff,0|14|0xffffff,0|15|0xbfbfbf,0|16|0xd2d2d2,0|17|0xf7f7f7,0|18|0xffffff,0|19|0xffffff,0|20|0xffffff"},
  }
  ]]
  local number = {
    {n=".", width=4, color=0xffffff, posandcolor="0|16|0xfcfcfc,0|17|0xe4e4e4,0|18|0xe4e4e4,0|19|0xe4e4e4"},
    {n="0", width=14,color=0xffffff, posandcolor="0|6|0xf1f1f1,0|7|0xdfdfdf,0|8|0xd4d4d4,0|9|0xd0d0d0,0|10|0xcecece,0|11|0xd2d2d2,0|12|0xd7d7d7,0|13|0xe8e8e8,0|14|0xfafafa"},
    {n="1", width=9, color=0xffffff, posandcolor="0|3|0xfdfdfd,0|4|0xf5f5f5,0|5|0xf7f7f7"},
    {n="2", width=14,color=0xffffff, posandcolor="0|4|0xfefefe,0|5|0xf2f2f2,0|6|0xe1e1e1,0|7|0xf8f8f8,0|16|0xf9f9f9,0|17|0xd0d0d0,0|18|0xb0b0b0,0|19|0x909090"},
    {n="3", width=15,color=0xffffff, posandcolor="0|5|0xf6f6f6,0|6|0xeeeeee,0|13|0xf1f1f1,0|14|0xa9a9a9,0|15|0xc1c1c1,0|16|0xdfdfdf"},
    {n="4", width=15,color=0xffffff, posandcolor="0|12|0xcdcdcd,0|13|0x919191,0|14|0x919191,0|15|0xd8d8d8"},
    {n="5", width=14,color=0xffffff, posandcolor="0|14|0xe5e5e5,0|15|0xcccccc,0|16|0xeeeeee"},
    {n="6", width=14,color=0xffffff, posandcolor="0|6|0xfafafa,0|7|0xe8e8e8,0|8|0xdbdbdb,0|9|0xcdcdcd,0|10|0xc0c0c0,0|11|0xc4c4c4,0|12|0xcfcfcf,0|13|0xdbdbdb,0|14|0xf4f4f4"},
    {n="7", width=14,color=0xf7f7f7, posandcolor="0|1|0xf0f0f0,0|2|0xf4f4f4"},
    {n="8", width=14,color=0xffffff, posandcolor="0|12|0xf1f1f1,0|13|0xd5d5d5,0|14|0xcdcdcd,0|15|0xe9e9e9,0|16|0xfefefe"},
    {n="9", width=14,color=0xffffff, posandcolor="0|3|0xfefefe,0|4|0xe6e6e6,0|5|0xcacaca,0|6|0xb2b2b2,0|7|0xbfbfbf,0|8|0xd6d6d6,0|9|0xf4f4f4,0|15|0xfafafa"},
  }
  local numberAfterPoint = {
    {n="0", width=14,color=0xffffff, posandcolor="0|4|0xebebeb,0|5|0xbebebe,0|6|0xa5a5a5,0|7|0x929292,0|8|0x878787,0|9|0x838383,0|10|0x818181,0|11|0x858585,0|12|0x8a8a8a,0|13|0x9b9b9b,0|14|0xaeaeae,0|15|0xd4d4d4,0|16|0xfafafa"},
    {n="1", width=9, color=0xffffff, posandcolor="0|3|0xf2f2f2,0|4|0xa8a8a8,0|5|0xbbbbbb"},
    {n="2", width=14,color=0xffffff, posandcolor="0|18|0xfafafa,0|19|0xdcdcdc"},
    {n="3", width=15,color=0xffffff, posandcolor="0|13|0xfcfcfc,0|14|0xf6f6f6"},
    {n="4", width=15,color=0xffffff, posandcolor="0|12|0xfcfcfc,0|13|0xdedede,0|14|0xdedede,0|15|0xf3f3f3"},
    {n="5", width=14,color=0xffffff, posandcolor="0|8|0xf3f3f3,0|9|0xd8d8d8,0|10|0xcccccc,0|14|0xcacaca,0|15|0x7f7f7f,0|16|0xa1a1a1,0|17|0xe2e2e2"},
    {n="6", width=14,color=0xffffff, posandcolor="0|5|0xebebeb,0|6|0xb7b7b7,0|7|0x9c9c9c,0|8|0x8e8e8e,0|9|0x818181,0|10|0x737373,0|11|0x777777,0|12|0x828282,0|13|0x8e8e8e,0|14|0xaaaaaa,0|15|0xdadada,0|16|0xfdfdfd"},
    {n="7", width=14,color=0xcfcfcf, posandcolor="0|1|0xa3a3a3,0|2|0xbcbcbc"},
    {n="8", width=14,color=0xffffff, posandcolor="0|4|0xf9f9f9,0|5|0xf1f1f1,0|11|0xebebeb,0|12|0xa8a8a8,0|13|0x888888,0|14|0x808080,0|15|0x9c9c9c,0|16|0xbababa,0|17|0xf5f5f5"},
    {n="9", width=14,color=0xffffff, posandcolor="0|3|0xd8d8d8,0|4|0x999999,0|5|0x7d7d7d,0|6|0x676767,0|7|0x727272,0|8|0x8a8a8a,0|9|0xb1b1b1,0|10|0xf7f7f7,0|15|0xbfbfbf,0|16|0xd2d2d2,0|17|0xf7f7f7"},
  }
  local pointFound = false
  local x = 490
  while x < 571 do
    for _, v in ipairs(pointFound and numberAfterPoint or number) do
      local x1, y1 =  findMultiColorInRegionFuzzy(v.color, v.posandcolor, 100, x, 391, x + 1, 412)
      if x1 > 0 then
        if v.n == '.' then
          pointFound = true
        end
        ret = ret .. v.n
        x = x + v.width
        break
      end
    end
    x = x + 1
  end
  dialog(ret, 1)
  return ret
end
--}}}
function trimRight(s)--{{{
  return string.match(s, "(.-)%s*$")
end--}}}
function readOneLine(f)--{{{
  return trimRight(f:read())
end--}}}
function main()--{{{
  local path = '/User/Media/TouchSprite/lua/'
  local config = io.open(path .. 'zfb_config.txt')
  local account_file = readOneLine(config)
  local login_password = readOneLine(config)
  local pay_password = readOneLine(config)
  local payto_account = readOneLine(config)
  local onePay = tonumber(readOneLine(config))
  local dama2 = readOneLine(config)
  config:close()

  local accounts = io.open(path .. account_file)
  local accountsGood = io.open(path .. 'zfb_good.txt', 'w')
  local accountsBad = io.open(path .. 'zfb_bad.txt', 'w')
  for line in accounts:lines() do
    oneKeyNewPhone()

    runApp("com.alipay.iphoneclient")
    mSleep(3000)

    click1(82, 406)
    click1(397, 879)

    local account, login_password1, pay_password1 = readAccount(line)
    if not login_password1 then
      login_password1 = login_password
    end
    if not pay_password1 then
      pay_password1 = pay_password
    end
    mSleep(1000)
    inputText(account)
    click1(233, 299)
    mSleep(1000)
    inputText(login_password1)
    click1(317, 459)
    mSleep(2000)
    local times = 20
    if findMultiColorInRegionFuzzy(0x707070, "7|6|0x7a7a7a,24|14|0x7c7c7c", 100, 385, 390, 429, 433) > 0 then
      -- captcha found
      vibrator()
      click1(326, 616)
      code = cloudOcrText(dama2, 0, 4, 371, 369, 617, 453)
      if code ~= "" then
        click1(54, 402)
        inputText(code)
        click1(317, 568)
      else
        dialog("失败", 0)
      end
    end
    if doFindMultiColorInRegionFuzzy(true, 0x7d9fb5, "58|18|0xb0d6e8,141|26|0x09294f", 100, 225, 340, 411, 370, times) then
      accountsGood:write(line .. "\n")

      click1(624 ,69)
      click1(480 ,638)

      mSleep(5000)
      click1(20, 80)

      click1(581 ,1099) -- fortune
      local money = tonumber(checkMoney())
      click1(68 ,1099) -- zfb
      local first = true
      while money and money >= 1 do
        if not first then
          click1(602, 79, 2000) -- done
          click1(20, 80) -- back
        else
          click1(233 ,418) -- zhaung zhang
        end
        first = false
        local ms
        if money >= onePay then
          ms = tostring(onePay)
          money = money - onePay
        else
          ms = tostring(money)
          money = 0
        end
        click1(174 ,1077) -- dao zfb

        click1(300, 800)
        click1(252 ,194)
        mSleep(1000)
        inputText(payto_account)
        click1(252 ,413)
        mSleep(1000)
        inputText(ms)
        click1(574 ,1033) -- keyboard ok
        click1(330 ,793) -- ok
        mSleep(2000)
        local okAgainDone = false
        local okAgain = function() click1(452, 690)
          if not okAgainDone then
            if findMultiColorInRegionFuzzy(0x89abf5, "1|0|0xbb27f8,2|00xe7eefd", 100, 521, 662, 528, 667) > 0 then
              click1(452, 690) -- ok again
              okAgainDone = true
            end
          end
        end
        if not doFindColorInRegionFuzzy(0x0, 100, 50, 244, 140, 281, nil, okAgain) then
          break
        end
        mSleep(1000)
        inputText(pay_password1)
        click1(472 ,552) -- pay
        if not doFindColorInRegionFuzzy(0x0baf1a, 100, 29, 159, 90, 218, 30) then
          break
        end
        mSleep(1000)
      end
    else
      accountsBad:write(line .. "\n")
    end
  end
  accounts.close()
  accountsGood.close()
  accountsBad.close()

  dialog("已完全所有", 0)
end
--}}}
main()
