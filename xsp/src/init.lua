--------------------------------
--初始化
--------------------------------

require("define")
require("actionDefine")
config = require("config")

init("0", 1)
w,h=getScreenSize()--获取当前分辨率
timeOut=30000 --超时时间判定为30秒

sleepTime = 500

oldPrint = print
print = function(text)
	itsType = type(text)
	if itsType == "nil" then
		oldPrint("nil")
	elseif itsType == "string" then
		oldPrint(text)
	elseif itsType == "string" then
		oldPrint(text)
	end
end

sysLog("屏幕宽高,w:"..w..",h:"..h)

print(config.points.pickHeroExpandAuxiliary)

--todo 
--方法封装
--检测当前页面
--选择关卡，选择英雄
--home左右适配，分辨率适配
--UI悬浮记录次数，获取多少金币
--UI 桌面编辑工具直接生成代码
--检测用户是否有点券，然后提示他买卡