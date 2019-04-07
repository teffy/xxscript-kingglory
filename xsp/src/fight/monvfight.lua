------------------------------------------------------------
--@desc 魔女挑战，后续抽出基础类，从主页到选择哪个关卡，等
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")

monv = {}
function monv:fight(sampling_adapter_data)
    local sleepTime = 500
    local deviceW, deviceH = getScreenSize()
    local points = sampling_adapter_data.points
    local rangecolors = sampling_adapter_data.rangecolors

    --主页面->冒险之旅
    click(points.main_risk, {sleepTime = sleepTime})
    --冒险选择-中间
    click(points.risk_select_mode1_2, {sleepTime = sleepTime})
    --冒险之旅-第三个
    click(points.risk_select_mode2_3, {sleepTime = sleepTime})

    --找到魔女步骤：1、点击3次箭头，2、点击第3条目，3、顺序点击普通，精英，大师，4、下一步
    --点击3次箭头
    click(points.fightpre_select_level_up, {sleepTime = math.random(50), clickCount = 3})
    --点击第3条目
    click(points.fightpre_select_level_3, {sleepTime = 200})
    --顺序点击普通，精英，大师，这样可以选到最大级别2
    --TODO  是否需要这样？？？是否可以检测是否有大师级别
    click(points.fightpre_level_mode_1, {sleepTime = 200})
    click(points.fightpre_level_mode_2, {sleepTime = 200})
    click(points.fightpre_level_mode_3, {sleepTime = 200})
    --下一步
    click(points.fightpre_select_level_next, {sleepTime = 200})

    local fightCount, fightAllTime, averageTime, goldCount = 0, 0, 0, 0
    local fightStartTime, fightEndTime = 0, 0
    local loadingTime, loadingTimeStart, loadingTimeEnd = 0, 0, 0
    local goldLimit = false
    local loadingTime = getNumberConfig("monv_loadingTime", 0)

    local hud_id = createHUD()
    local xStart = 0
    local goldPerFight = 19 -- 魔女一次19金币
    if deviceW > 2 * deviceH then
        xStart = deviceW / 2 - deviceH
    end

    local function _showHUD(hudText)
        showHUD(hud_id, hudText, 35, "0xff1E90FF", "0xafffffff", 0, xStart, deviceH - 180, 400, 180)
    end

    --开始循环闯关
    while true do
        fightStartTime = mTime()

        -- 先判断是否在战斗准备页面，判断闯关按钮和更改阵容按钮，以防页面切换卡顿
        while true do
            --前3个是挑战成功的条目（任意完成一个），黄色的字，第4个是下面的白色字，前3个或和第四个与
            fightpreChangeTeam =
                findColors(rangecolors.fightpre_change_team.range, rangecolors.fightpre_change_team.color, 90, 0, 0, 0)
            fightpreRushThrough =
                findColors(
                rangecolors.fightpre_rush_through.range,
                rangecolors.fightpre_rush_through.color,
                90,
                0,
                0,
                0
            )
            randomTime = math.random(300, 600)
            if #fightpreChangeTeam ~= 0 and #fightpreRushThrough ~= 0 then
                sysLog("战斗准备页面")
                -- TODO 需要等一下，第一次英雄列表加载是异步的,可能会导致进去检测到英雄没选全
                mSleep(randomTime)
                break
            else
                sysLog("不在战斗准备页面，sleep ", randomTime)
                mSleep(randomTime)
            end
        end

        --判断是否选够英雄
        --如果选够，直接点击闯关
        --如果没选够，点击更换阵容，在选择英雄界面检查第三个英雄是否已经选择，选3个英雄
        findThen(
            rangecolors.fightpre_check_hero_enough.range,
            rangecolors.fightpre_check_hero_enough.color,
            function(x, y)
                if x > -1 then
                    sysLog("没选够3个英雄")
                    --点击更换阵容
                    click(points.fightpre_change_team, {sleepTime = 800})
                    --在选择英雄界面检查第三个英雄是否已经选择
                    findThen(
                        rangecolors.fightpre_pick_hero_check_hero_enough.range,
                        rangecolors.fightpre_pick_hero_check_hero_enough.color,
                        function(x, y)
                            if x > -1 then
                                clickArray(
                                    --选3个英雄
                                    {
                                        point = points.fightpre_pick_hero_pos_1,
                                        config = {sleepTime = math.random(100, 200)}
                                    },
                                    {
                                        point = points.fightpre_pick_hero_pos_2,
                                        config = {sleepTime = math.random(100, 200)}
                                    },
                                    {
                                        point = points.fightpre_pick_hero_pos_3,
                                        config = {sleepTime = math.random(100, 200)}
                                    },
                                    --点击确定开始
                                    {point = points.fightpre_pick_hero_confirm}
                                )
                                return true
                            end
                        end
                    )
                else
                    sysLog("选够3个英雄")
                    --点击闯关
                    click(points.fightpre_rush_through)
                end
                return true
            end
        )

        print("loadingTime:::", loadingTime)
        --加载页面，计算一次加载时长，下次直接休眠这么长时间即可
        if loadingTime == 0 then
            loadingTimeStart = mTime()
        else
            mSleep(loadingTime)
        end

        --先判断是否已经在战斗中，然后判断是否开了自动，没开自动需要点击自动
        findThen(
            rangecolors.fighting_is_in_fighting.range,
            rangecolors.fighting_is_in_fighting.color,
            function(x, y)
                if x > -1 then
                    if loadingTime == 0 then -- 记录loading时间数据，上面再次到加载过程中到就sleep
                        loadingTimeEnd = mTime()
                        loadingTime = loadingTimeEnd - loadingTimeStart
                        setNumberConfig("monv_loadingTime", loadingTime)
                    end
                    findThen(
                        rangecolors.fighting_is_auto_fight.range,
                        rangecolors.fighting_is_auto_fight.color,
                        function(x, y)
                            if x > -1 then
                                sysLog("已经是自动")
                            else
                                sysLog("不是自动，点击自动")
                                click(points.fighting_auto_fight)
                            end
                            return true
                        end
                    )
                    return true
                else
                    return false
                end
            end
        )

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

        mSleep(2000)
        --检查结束页面
        --成功，随便点击一个点，然后开始检查是否有白字（金币上限），然后点击再次挑战，从头循环
        --失败，点击页面上的返回到挑战选关卡页面了，点击下一步
        local fightSuccess = true
        while true do
            math.randomseed(tostring(os.time()):reverse():sub(1, 7))
            --前1个是挑战成功的条目（任意完成一个），黄色的字，第2个是下面的白色字，前1个或和第2个与
            successYellowText =
                findColors(
                rangecolors.fight_success_check_yellow_text.range,
                rangecolors.fight_success_check_yellow_text.color,
                95,
                0,
                0,
                0
            )
            successWhiteText =
                findColors(
                rangecolors.fight_success_check_white_text.range,
                rangecolors.fight_success_check_white_text.color,
                95,
                0,
                0,
                0
            )
            if #successYellowText ~= 0 and #successWhiteText ~= 0 then
                sysLog("成功结果页面")
                fightSuccess = true
                break
            else
                failedWhiteTextUp =
                    findColors(
                    rangecolors.fight_failed_check_white_text_up.range,
                    rangecolors.fight_failed_check_white_text_up.color,
                    95,
                    0,
                    0,
                    0
                )
                failedWhiteTextDown =
                    findColors(
                    rangecolors.fight_failed_check_white_text_down.range,
                    rangecolors.fight_failed_check_white_text_down.color,
                    95,
                    0,
                    0,
                    0
                )
                if #failedWhiteTextUp ~= 0 and #failedWhiteTextDown ~= 0 then
                    sysLog("失败结果页面")
                    fightSuccess = false
                    break
                end
            end
        end

        mSleep(2000)
        sysLog("fightSuccess:", fightSuccess)
        if fightSuccess then
            --随机点击一个点跳过
            randomClick(deviceW, deviceH)
            --先判断是否已经在奖励页面，避免在页面切换中判断是否有白字（金币上限）
            while true do
                resultSuccessBack =
                    findColors(
                    rangecolors.fight_success_gold_back.range,
                    rangecolors.fight_success_gold_back.color,
                    90,
                    0,
                    0,
                    0
                )
                resultSuccessFightAgain =
                    findColors(
                    rangecolors.fight_success_gold_fight_again.range,
                    rangecolors.fight_success_gold_fight_again.color,
                    90,
                    0,
                    0,
                    0
                )
                if #resultSuccessBack ~= 0 and #resultSuccessFightAgain ~= 0 then
                    findThen(
                        rangecolors.fight_success_gold_limit.range,
                        rangecolors.fight_success_gold_limit.color,
                        function(x, y)
                            if x > -1 then
                                goldLimit = true
                                sysLog("金币上限")
                                if autoStop then
                                    --金币上限，退出脚本
                                    fightEndTime = mTime()
                                    fightAllTime = fightAllTime + (fightEndTime - fightStartTime)
                                    fightCount = fightCount + 1
                                    averageTime = fightAllTime / fightCount
                                    FinishUI:showUIOnTaskFinish(
                                        {
                                            fightAllTime = fightAllTime,
                                            goldCount = goldCount,
                                            averageTime = averageTime
                                        },
                                        goldLimit
                                    )
                                    hideHUD(hud_id)
                                    return true
                                else
                                    sysLog("金币上限，继续刷经验")
                                    click(points.fight_success_fight_again)
                                    return true
                                end
                            else
                                --金币还没上限，再次挑战  challengeAgain
                                sysLog("金币不到上限，再次挑战")
                                click(points.fight_success_fight_again)
                                return true
                            end
                        end
                    )
                    break
                else
                    randomClick(deviceW, deviceH)
                end
            end
        else
            click(points.fight_failed_back)
            --失败，退回到选择关卡页面，先判断上下按钮在不在，点击下一步
            while true do
                upBtnPoint =
                    findColors(
                    rangecolors.fightpre_select_level_up.range,
                    rangecolors.fightpre_select_level_up.color,
                    90,
                    0,
                    0,
                    0
                )
                downBtnPoint =
                    findColors(
                    rangecolors.fightpre_select_level_down.range,
                    rangecolors.fightpre_select_level_down.color,
                    90,
                    0,
                    0,
                    0
                )
                if #upBtnPoint ~= 0 and #downBtnPoint ~= 0 then
                    sysLog("失败了，点击下一步")
                    click(points.fightpre_select_level_next)
                    break
                else
                    click(points.fight_failed_back)
                end
            end
        end

        fightEndTime = mTime()
        fightAllTime = fightAllTime + (fightEndTime - fightStartTime)
        fightCount = fightCount + 1
        averageTime = fightAllTime / fightCount

        if not goldLimit then
            goldCount = fightCount * goldPerFight
        end
        sysLog(
            "loadingTime:",
            loadingTime,
            ",fightAllTime:",
            fightAllTime,
            ",fightCount:",
            fightCount,
            ",averageTime:",
            averageTime
        )
        hudText = string.format("已进行%d次，平均时长%s，已获得%d金币", fightCount, util:time2Text(averageTime), goldCount)
        _showHUD(hudText)
    end
end
