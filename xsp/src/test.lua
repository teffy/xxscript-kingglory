require("tflibs.sys_fun_redef")
fighting_is_skip_showing =  {
    range={
      2595,
      1080,
      2612,
      1090
    },
    color= "0|0|0x02bfff",
    pos= "mid",
    desc= "战斗中，判断是否弹出自动了，采样右下角按钮"
  }
range = fighting_is_skip_showing.range

arrs = {{x=range[1],y=range[2]},{x=range[3],y=range[4]}}
print(arrs)
as = {}
table.insert(as,#as+1,1)
table.insert(as,#as+1,2)
table.insert(as,#as+1,3)
print(as)