function click(p, x, y)--{{{
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
end --}}}
function click1(x, y)--{{{
  click(1, x, y)
end--}}}
function slide(x1, y1, x2, y2, msleep, offset)--{{{
  do
    x3 = 0
    y3 = 0
    touchDown(1, x1, y1)
    xx = x1
    yy = y1
    while true do
      if x2 < x1 and x3 == 0 then
        xx = xx - offset
        if x2 > xx then
          x3 = 1
        end
      elseif x3 == 0 then
        xx = xx + offset
        if x2 < xx then
          x3 = 1
        end
      end
      if y2 < y1 and y3 == 0 then
        yy = yy - offset
        if y2 > yy then
          y3 = 1
        end
      elseif y3 == 0 then
        yy = yy + offset
        if y2 < yy then
          y3 = 1
        end
      end
      if x3 ~= 1 or y3 ~= 1 then
        mSleep(msleep)
        touchMove(1, xx, yy)
        break
      end
    end
    touchUp(1)
    mSleep(100)
  end
end--}}}
function main()--{{{
  init("0", 0)
  runApp("com.apple.Preferences")
  for i=1, 5 do
    click1(75, 85)
    mSleep(200)
  end
  mSleep(2000)
  click1(320, 10)
  mSleep(1000)
  while true do
    slide(300, 950, 300, 150, 1000, 10)
    mSleep(700)
  end
end--}}}

main()
