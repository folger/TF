function click(p, x, y)--{{{
  touchDown(p, x, y)
  mSleep(50)
  touchUp(p, x, y)
end --}}}

function click1(x, y)--{{{
  click(1, x, y)
end--}}}

function main()--{{{
init("0", 0)
runApp("com.apple.Preferences")
for i=1, 5 do
  click1(75, 85)
  mSleep(500)
end
mSleep(2000)
click1(320, 10)
end--}}}

main()
