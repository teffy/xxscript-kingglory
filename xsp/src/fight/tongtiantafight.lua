------------------------------------------------------------
--@desc 通天塔挑战
--              选择关卡：3次up,1次down,第三条
--              选择关卡：流程：开始点一次跳过，点击自动，后面点击一次跳过
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")
require("fight.challengefightbase")

tongtianta = {}
function tongtianta:fight()
    local goldPerFight = 29
    local loadingtime_key = "tongtianta_loadingTime"

    local function selectLevelFunc()
        click(
            points.fightpre_select_level_up,
            {sleepTime = math.random(50, 80), clickCount = 3, sleepAfter = defaultSleepTime}
        )
        click(points.fightpre_select_level_down, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
        click(points.fightpre_select_level_3, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
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
        basefight:clickAuto()

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
    end

    basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
end
