------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")
require("ui.mainui")
require("ui.guideui")

local ret, result = MainUI:showUI()
local autoStopStr = result.autoStop
local autoCloseGameStr = result.autoCloseGame
autoStop = (autoStopStr == "0")
autoCloseGame = (autoCloseGameStr == "0")
userClick = ret
local selectFight = result.selectFight
if ret == 1 then
    sysLog("确定")
else
    sysLog("取消")
    require("ui.finishui")
    FinishUI:showUIOnExit()
    -- mSleep(100000)
    return
end

-- setNumberConfig("monv_loadingTime",0)
-- setNumberConfig("tongtianta_loadingTime",0)

local loadingTime1 = getNumberConfig("monv_loadingTime", 0)
local loadingTime2 = getNumberConfig("tongtianta_loadingTime", 0)
print(loadingTime1)
print(loadingTime2)

require("ui.checkdownload")
CheckDownload:checkDownload()

local isRightScreenDirection = true
local screenD = getScreenDirection()
local osType = getOSType()
sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
    GuideUI:showUI()
end

points = sampling_adapter_data.points
rangecolors = sampling_adapter_data.rangecolors
deviceW, deviceH = getScreenSize()

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

local test = nil
if test then
    -- mSleep(3000)
    return
end

if selectFight == "0" then
    require("fight.monvfight")
    monv:fight()
elseif selectFight == "1" then
    require("fight.tongtiantafight")
    tongtianta:fight()
end
