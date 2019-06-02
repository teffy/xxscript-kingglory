------------------------------------------------------------
--@desc 血王宫挑战
--              选择关卡：3次down,第三条
--              选择关卡：流程：开始点一次跳过(黄色跳过可通过跳过的find else 里随机点击一个点)，点击自动，后面点击三次跳过
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")
require("fight.base.RiskFightBase")

xuewanggong = {}
function xuewanggong:fight()
    local goldPerFight = 48
    local loadingtime_key = "xuewanggong_loadingTime"

    local function selectLevelFunc()
        click(
            points.fightpre_select_level_down,
            {sleepTime = math.random(50, 80), clickCount = 3, sleepAfter = defaultSleepTime / 2}
        )
        click(points.fightpre_select_level_3, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
    end

    local function fightProcessFunc()
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 400})
                    sysLog("click 跳过")
                    return true
                else
                    sysLog("randomClick")
                    randomClick()
                end
            end
        )
        basefight:saveLoadingTime(loadingtime_key)
        click(points.hero_skill_fight)
        if IS_VIP then
            basefight:clickAuto(false)
            move(
                points.move_round_center,
                {
                    util:calPointByRadiusRadWithTime(
                        points.move_round_center,
                        points.move_round_center.radius,
                        -54,
                        3000
                    ),
                    util:calPointByRadiusRadWithTime(
                        points.move_round_center,
                        points.move_round_center.radius,
                        -140,
                        3000
                    ),
                    util:calPointByRadiusRadWithTime(
                        points.move_round_center,
                        points.move_round_center.radius,
                        -56,
                        20000
                    )
                }
            )
            basefight:clickAuto(true)
            local clickSkipCount = 0
            findThen(
                rangecolors.fighting_is_skip_showing.range,
                rangecolors.fighting_is_skip_showing.color,
                function(x, y)
                    if x > -1 then
                        click(points.fighting_skip, {sleepAfter = 1000})
                        sysLog("click 跳过")
                        clickSkipCount = clickSkipCount + 1
                        if clickSkipCount == 3 then
                            return true
                        end
                    end
                end
            )
        else
            basefight:clickAuto(true)
            local clickSkipCount = 0
            findThen(
                rangecolors.fighting_is_skip_showing.range,
                rangecolors.fighting_is_skip_showing.color,
                function(x, y)
                    if x > -1 then
                        click(points.fighting_skip, {sleepAfter = 1000})
                        sysLog("click 跳过")
                        clickSkipCount = clickSkipCount + 1
                        sysLog("click 跳过,clickSkipCount:",clickSkipCount)
                        if clickSkipCount == 3 then
                            return true
                        end
                    end
                end
            )
        end
    end
    basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
end
