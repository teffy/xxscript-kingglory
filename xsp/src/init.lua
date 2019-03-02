------------------------------------------------------------
--@desc 初始化，加载各种库，和UI适配，游戏坐标数据适配
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.fun_overload_def")
require("tflibs.click_action_def")
require('tflibs.sys_fun_redef')
calculate_coordinate = require("tflibs.coordinate_adapter")
adapterUI = require("tflibs.ui_adapter")
require("config")

defaultW,defaultH= 1440,2560
deviceW, deviceH = getScreenSize()
scaleW = deviceW / defaultW
scaleH = deviceH / defaultH

coordinate_data = calculate_coordinate("coordinate.json",scaleW,scaleH)
print('jisuan',coordinate_data)
ui_json = adapterUI("ui.json",scaleW,scaleH)

sysLog("宽高——deviceW:"..deviceW..",deviceH:"..deviceH)
sysLog("缩放——scaleW:"..scaleW..",scaleH:"..scaleH)

-- 屏幕方向，0 - 竖屏， 1 - Home键在右边， 2 - Home键在左边
init("0", 1)

timeOut=30000 --超时时间判定为30秒
sleepTime = 500
