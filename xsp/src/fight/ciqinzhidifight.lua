------------------------------------------------------------
--@desc 刺秦之地挑战
--              选择关卡：3次down,1次up,第四条
--              选择关卡：流程：开始点一次跳过，点击自动，后面点击两次跳过
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")
require("fight.challengefightbase")

ciqinzhidi = {}
function ciqinzhidi:fight()
    local goldPerFight = 45
    local loadingtime_key = "ciqinzhidi_loadingTime"

    local function selectLevelFunc()
        click(
            points.fightpre_select_level_down,
            {sleepTime = math.random(50, 80), clickCount = 3, sleepAfter = defaultSleepTime / 2}
        )
        click(points.fightpre_select_level_up, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
        click(points.fightpre_select_level_4, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
    end

    local function fightProcessFunc()
        -- 上来点击一次
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 1000})
                    sysLog("click 跳过")
                    return true
                end
            end
        )

        basefight:saveLoadingTime(loadingtime_key)
        basefight:clickAuto(true)

        local skipAfterCount = 0
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 1000})
                    sysLog("click 跳过")
                    skipAfterCount = skipAfterCount + 1
                    if skipAfterCount == 2 then
                        return true
                    end
                end
            end
        )
    end

    basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
end
