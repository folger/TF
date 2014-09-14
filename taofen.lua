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
function resetVPN()--{{{
  runApp("com.apple.Preferences")
  mSleep(3000)
  while true do
    x,y = findColorInRegionFuzzy(general_blue, 50, 51, 66, 120, 100)
    if x < 0 then
      break
    end
    click1(x, y)
  end
  click1(320, 10) --click titlebar
  click1(58, 1084) --click General
  for i=1, 2 do
    vslide1(300, 950, 150, 10)
    mSleep(700)
  end
  click1(54, 858)
end--}}}
function main()--{{{
  init("0", 0)
  resetVPN()
end--}}}

main()
