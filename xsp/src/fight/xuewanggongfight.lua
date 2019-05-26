------------------------------------------------------------
--@desc 血王宫挑战
--              选择关卡：3次down,第三条
--              选择关卡：流程：开始点一次跳过(黄色跳过可通过跳过的find else 里随机点击一个点)，点击自动，后面点击三次跳过
-- 4s 3s  16s 3s
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")
require("fight.challengefightbase")

xuewanggong = {}
function xuewanggong:fight()
    local goldPerFight = 45
    local loadingtime_key = "xuewanggong_loadingTime"

    local function selectLevelFunc()
        click(
            points.fightpre_select_level_down,
            {sleepTime = math.random(50, 80), clickCount = 3, sleepAfter = defaultSleepTime / 2}
        )
        click(points.fightpre_select_level_3, {sleepTime = math.random(50, 80), sleepAfter = defaultSleepTime})
    end

    local function fightProcessFunc()
        -- 上来点击一次
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip, {sleepAfter = 100})
                    sysLog("click 跳过")
                    return true
                else
                    randomClick()
                end
            end
        )
        basefight:saveLoadingTime(loadingtime_key)
        if IS_VIP then
            move(
                points.move_round_center,
                {
                    util:calPointByRadiusRadWithTime(
                        points.move_round_center,
                        points.move_round_center.radius,
                        -43,
                        7000
                    ),
                    util:calPointByRadiusRadWithTime(
                        points.move_round_center,
                        points.move_round_center.radius,
                        -54,
                        20000
                    )
                }
            )
            basefight:clickAuto(true)
            local clickCount = 0
            findThen(
                rangecolors.fighting_is_skip_showing.range,
                rangecolors.fighting_is_skip_showing.color,
                function(x, y)
                    if x > -1 then
                        click(points.fighting_skip, {sleepAfter = 1000})
                        sysLog("click 跳过")
                        clickCount = clickCount + 1
                        if clickCount == 3 then
                            return true
                        else
                            return false
                        end
                    end
                end
            )
        else
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
                        if skipAfterCount == 4 then
                            return true
                        end
                    end
                end
            )
        end
    end

    basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
end
