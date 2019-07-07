------------------------------------------------------------
--@desc 初始化，加载各种库，和UI适配，游戏坐标数据适配
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("config")
require('tflibs.util')
require('tflibs.sys_fun_redef')
require("tflibs.fun_overload_def")
require("tflibs.click_action_def")
require("tflibs.sampling_adapter")

textSize = 55
textColor = "76,137,228"

fightCountArray = {1,5,10,50,100,200,260,300,400,500,600}
fightCountStr = "1,5,10,50,100,200,260,300,400,500,600"

sampling_adapter_data = Adapter:calculate_sampling_data()

-- 屏幕方向，0 - 竖屏， 1 - Home键在右边， 2 - Home键在左边
init(APP_PACKAGE_NAME, 1)

-- 在用户主动终止脚本运行之前执行的回调函数 onBeforeUserExit
function onBeforeUserExit()
    require("ui.finishui")
    FinishUI:showUIOnExit()
end

timeOut=30000 --超时时间判定为30秒