------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")
require("fight.monvfight")

require("ui.mainui")
require("ui.guideui")

local ret, result = MainUI:showUI()
local autoStopStr = result.autoStop
local autoCloseGameStr = result.autoCloseGame
autoStop = (autoStopStr == "0")
autoCloseGame = (autoCloseGameStr == "0")
if ret == 1 then
    sysLog("确定")
else
    sysLog("取消")
    require("ui.finishui")
    FinishUI:showUIOnExit()
    mSleep(100000)
    return
end

require("ui.checkdownload")
CheckDownload:checkDownload()

local isRightScreenDirection = true
local screenD = getScreenDirection()
local osType = getOSType()
sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
    GuideUI:showUI()
end

mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

local test = false
if test then
    mSleep(3000)
    local points = sampling_adapter_data.points
    local rangecolors = sampling_adapter_data.rangecolors
    findThen(
        rangecolors.fighting_is_auto_fight.range,
        rangecolors.fighting_is_auto_fight.color,
        function(x, y)
            if x > -1 then
                taost("已经是自动")
            else
                toast("不是自动，点击自动")
                click(points.fighting_auto_fight)
            end
            return true
        end
    )
    return
end

-- require('auxiliarytask')
monv:fight(sampling_adapter_data)
