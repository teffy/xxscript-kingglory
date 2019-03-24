------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")
require("monvfight")

require("mainui")
require("guideui")

ret, result = MainUI:showUI()
if ret == 1 then
	sysLog("确定")
else
	sysLog("取消")
	return
end

isRightScreenDirection = true
screenD = getScreenDirection()
osType = getOSType()
sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
	GuideUI:showUI()
end

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

points = sampling_adapter_data.points
rangecolors = sampling_adapter_data.rangecolors

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

-- mSleep(3000)
-- setStringConfig getStringConfig
-- 可以用来存储加载时间，下一次直接sleep

-- getCloudContent可以用来在脚本执行过程中提示用户加群
-- content, err = getCloudContent("NEW_VERSION","32670523E7000928","test")
-- sysLog(string.format("getCloudContent return content = %s, err = %s", tostring(content), tostring(err)));
-- if err == 0 then
--   dialog(content)
-- elseif err == 1 then
--   dialog("网络错误")
-- elseif err == 999 then
--   dialog("未知错误")
-- end

test = false
if test then
	mSleep(3000)
	require("finishui")
	FinishUI:showUI(10100, 60000, 1999)
	return
end

monv:fight(sampling_adapter_data)
