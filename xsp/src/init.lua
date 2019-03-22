------------------------------------------------------------
--@desc 初始化，加载各种库，和UI适配，游戏坐标数据适配
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("config")
require('tflibs.sys_fun_redef')
require("tflibs.fun_overload_def")
require("tflibs.click_action_def")
calculate_sampling_data = require("tflibs.sampling_adapter")
adapterUI = require("tflibs.ui_adapter")

deviceW, deviceH = getScreenSize()

sampling_adapter_data = calculate_sampling_data(deviceW, deviceH)
ui_json = adapterUI("ui.json",deviceW, deviceH)

-- 屏幕方向，0 - 竖屏， 1 - Home键在右边， 2 - Home键在左边
init("0", 1)

timeOut=30000 --超时时间判定为30秒
sleepTime = 500
