------------------------------------------------------------
--@desc 魔女挑战
--              选择关卡：3次up,第三条
--              流程：点击自动，点两次跳过
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")
require("fight.base.RiskFightBase")

monv = {}
function monv:fight()
    local goldPerFight = 19
    local loadingtime_key = "monv_loadingTime"

    local function selectLevelFunc()
        click(
            points.fightpre_select_level_up,
            {sleepTime = math.random(50, 80), clickCount = 3, sleepAfter = defaultSleepTime / 2}
        )
        click(points.fightpre_select_level_3, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
    end

    local function fightProcessFunc()
        -- 直接利用 clickAuto 判断是否在战斗中
        basefight:clickAuto(true)
        basefight:saveLoadingTime(loadingtime_key)
        --点击2次跳过
        local clickNextCount = 0
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 1000})
                    sysLog("click 跳过")
                    clickNextCount = clickNextCount + 1
                    if clickNextCount == 2 then
                        clickNextCount = 0
                        return true
                    end
                end
            end
        )
    end

    basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
end
