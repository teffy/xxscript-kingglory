------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")

points = sampling_adapter_data.points
rangecolors = sampling_adapter_data.rangecolors
deviceW, deviceH = getScreenSize()

-- local test = 1
local test = nil
if test then
    mSleep(2000)

    move(points.move_round_center,{
        util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,-48,3500),
        util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,-140,3000),
        util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,-48,18000),
        util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,48,3000),
    })
    findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 1000})
                    sysLog("click 跳过")
                    return true
                else
                    randomClick()
                end
            end
        )
    move(points.move_round_center,{
            util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,48,700),
            util:calPointByRadiusRadWithTime(points.move_round_center,points.move_round_center.radius,-48,4000),
        })
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 1000})
                    sysLog("click 跳过")
                    return true
                else
                    randomClick()
                end
            end
        )
    return
end

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

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

if selectFight == "0" then
    require("fight.monvfight")
    monv:fight()
elseif selectFight == "1" then
    require("fight.tongtiantafight")
    tongtianta:fight()
elseif selectFight == "2" then
    require("fight.ciqinzhidifight")
    ciqinzhidi:fight()
elseif selectFight == "3" then
    require("fight.xuewanggongfight")
    xuewanggong:fight()
end
