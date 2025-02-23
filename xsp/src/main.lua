------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")

points = sampling_adapter_data.points
rangecolors = sampling_adapter_data.rangecolors
deviceW, deviceH = getScreenSize()

-- setNumberConfig("xuewanggong_loadingTime", 0)

-- local test = 1
local test = nil
if test then
    mSleep(2000)
    findThen(
            rangecolors.main_risk_text.range,
            rangecolors.main_risk_text.color,
            function(x, y)
                if x > -1 then
                     --主页面->冒险之旅
                    click(points.main_risk, {sleepAfter = defaultSleepTime})
                    return true
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

userClick = ret
sysLog("确定")

if not ret == 1 then
    sysLog("取消")
    require("ui.finishui")
    FinishUI:showUIOnExit()
    return
end

print("result ",result)

local fightTypeStr = result.fightType -- 冒险，六国，武道
riskFightLevel = result.riskFightLevel -- 普通，精英，大师
local selectFight = result.selectFight -- 冒险挑战，选择关卡
local autoCloseGameStr = result.autoCloseGame
local randomSleepStr = result.randomSleep
local fightCountStr = result.fightCount

print("fightCountStr "..fightCountStr)
print("tonumber(fightCountStr) "..tonumber(fightCountStr))
totalFightCount = fightCountArray[tonumber(fightCountStr)+1]
print("totalFightCount "..totalFightCount)

autoCloseGame = (autoCloseGameStr == "0")
randomSleep = (randomSleepStr == "0")

require("ui.checkdownload")
CheckDownload:checkDownload()

local isRightScreenDirection = true
local screenD = getScreenDirection()
local product_id = getProduct()

sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
    require("ui.guideui")
    GuideUI:showUI()
end

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击
if fightTypeStr == "0" then
    if selectFight == "0" then
        require("fight.MonvFight")
        monv:fight()
    elseif selectFight == "1" then
        require("fight.TongTianTaFight")
        tongtianta:fight()
    elseif selectFight == "2" then
        require("fight.CiqinZhidiFight")
        ciqinzhidi:fight()
    elseif selectFight == "3" then
        require("fight.XueWangGongFight")
        xuewanggong:fight()
    end
elseif fightTypeStr == "1" then
    require("fight.SixNationFight")
    sixnation:fight()
elseif fightTypeStr == "2" then
    require("fight.RankFight")
    rankfight:fight()
end
