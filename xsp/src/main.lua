------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")

isAndroid = true
isIOS = false
smallApkUrl = nil

local osType = getOSType()
if osType == "android" then
    sysLog("安卓系统")
    isAndroid = true
    isIOS = false
elseif osType == "iOS" then
    sysLog("苹果系统")
    isAndroid = false
    isIOS = true
end

if isAndroid then
    local content, err = getCloudContent("SMALL_APK_URL", "32670523E7000928", "null")
    if err == 0 and content ~= "null" then
        smallApkUrl = content
    end
end

require("ui.mainui")
local ret, result = MainUI:showUI()
local autoStopStr = result.autoStop
local autoCloseGameStr = result.autoCloseGame
local randomSleepStr = result.randomSleep
autoStop = (autoStopStr == "0")
autoCloseGame = (autoCloseGameStr == "0")
randomSleep = (randomSleepStr == "0")
userClick = ret
local selectFight = result.selectFight
if ret == 1 then
    sysLog("确定")
else
    sysLog("取消")
    require("ui.finishui")
    FinishUI:showUIOnExit()
    return
end

require("ui.checkdownload")
CheckDownload:checkDownload()

local isRightScreenDirection = true
local screenD = getScreenDirection()

sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
    require("ui.guideui")
    GuideUI:showUI()
end

points = sampling_adapter_data.points
rangecolors = sampling_adapter_data.rangecolors
deviceW, deviceH = getScreenSize()

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

-- local test = 1
local test = nil
if test then
    mSleep(2000)
    return
end

if selectFight == "0" then
    require("fight.monvfight")
    monv:fight()
elseif selectFight == "1" then
    require("fight.tongtiantafight")
    tongtianta:fight()
elseif selectFight == "2" then
    require("fight.ciqinzhidifight")
    ciqinzhidi:fight()
end
