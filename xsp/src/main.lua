------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")
require("fight.monvfight")

require("ui.mainui")
require("ui.guideui")

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
mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

test = false
if test then
	mSleep(1000)
	return
end

monv:fight(sampling_adapter_data)

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