------------------------------------------------------------
--@desc 挑战基础类，从主页到选择哪个关卡，等
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("ui.finishui")

basefight = {}

function basefight:clickAuto(auto)
    --先判断是否已经在战斗中，然后判断是否开了自动，没开自动需要点击自动
    findThen(
        rangecolors.fighting_is_in_fighting.range,
        rangecolors.fighting_is_in_fighting.color,
        function(x, y)
            if x > -1 then
                findThen(
                    rangecolors.fighting_is_auto_fight.range,
                    rangecolors.fighting_is_auto_fight.color,
                    function(x, y)
                        if x > -1 then
                            sysLog("已经是自动")
                            if not auto then
                                click(points.fighting_auto_fight)
                            end
                        else
                            sysLog("不是自动，点击自动")
                            if auto then
                                click(points.fighting_auto_fight)
                            end
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
end

function basefight:saveLoadingTime(loadingtime_key)
    print("saveLoadingTime:", loadingTime)
    if loadingTime == 0 then -- 记录loading时间数据，上面再次到加载过程中到就sleep
        loadingTimeEnd = mTime()
        loadingTime = loadingTimeEnd - loadingTimeStart
        setNumberConfig(loadingtime_key, loadingTime)
    end
end

loadingTime, loadingTimeStart, loadingTimeEnd = 0, 0, 0

--@desc 挑战过程封装
--@param goldPerFight 一局挑战的金币
--@param loadingtime_key loading时长
--@param selectLevelFunc 选择关卡方法
--@param fightProcessFunc 挑战过程中，需要判断是否在战斗中的，然后保存loadingtime_key
function basefight:fight(goldPerFight, loadingtime_key, selectLevelFunc, fightProcessFunc)
    defaultSleepTime = 1500

    local fightCount, fightAllTime, averageTime, goldCount = 0, 0, 0, 0
    local fightStartTime, fightEndTime = 0, 0
    loadingTime = getNumberConfig(loadingtime_key, 0)

    local hud_id = createHUD()
    local xStart = 0

    if deviceW > 2 * deviceH then
        xStart = deviceW / 2 - deviceH
    end

    local function _showHUD(hudText)
        showHUD(hud_id, hudText, 35, "0xff1E90FF", "0xafffffff", 0, xStart, deviceH - 180, 400, 180)
    end

    math.randomseed(tostring(os.time()):reverse():sub(1, 9))
    local randomSleepStep = math.random(4, 8)
    print("randomSleep:", randomSleep, ",randomSleepStep:", randomSleepStep,",totalFightCount:",totalFightCount)
    local selectLeveled = false
    --开始循环闯关
    while fightCount <= totalFightCount do
        math.randomseed(tostring(os.time()):reverse():sub(1, 9))
        fightStartTime = mTime()

        findThen(
            rangecolors.main_risk_text.range,
            rangecolors.main_risk_text.color,
            function(x, y)
                click(points.main_risk, {sleepAfter = defaultSleepTime})
                if x > -1 then
                     --主页面->冒险之旅
                    return true
                end
            end
        )
        findThen(
            rangecolors.risk_select_mode1_2.range,
            rangecolors.risk_select_mode1_2.color,
            function(x, y)
                if x > -1 then
                     --冒险选择-中间
                    click(points.risk_select_mode1_2, {sleepAfter = defaultSleepTime})
                    return true
                else
                    --主页面->冒险之旅
                    click(points.main_risk, {sleepAfter = defaultSleepTime})
                end
            end
        )
       
        --冒险选择-中间
        -- click(points.risk_select_mode1_2, {sleepAfter = defaultSleepTime})
        --冒险之旅-第三个
        click(points.risk_select_mode2_3, {sleepAfter = defaultSleepTime})

        if not selectLeveled then
            selectLevelFunc(defaultSleepTime)
            selectLeveled = true
        end

        --顺序点击普通，精英，大师，这样可以选到最大级别2
        --TODO  是否需要这样？？？是否可以检测是否有大师级别
        -- click(points.fightpre_level_mode_1, {sleepAfter = 200})
        -- click(points.fightpre_level_mode_2, {sleepAfter = 200})
        -- click(points.fightpre_level_mode_3, {sleepAfter = 200})

        --下一步
        click(points.fightpre_select_level_next, {sleepAfter = defaultSleepTime})

        -- 先判断是否在战斗准备页面，判断闯关按钮和更改阵容按钮，以防页面切换卡顿
        findThenArray(
            {
                {
                    range = rangecolors.fightpre_change_team.range,
                    color = rangecolors.fightpre_change_team.color,
                    degree = 90,
                    hdir = 0,
                    vdir = 0,
                    priority = 0
                },
                {
                    range = rangecolors.fightpre_rush_through.range,
                    color = rangecolors.fightpre_rush_through.color,
                    degree = 90,
                    hdir = 0,
                    vdir = 0,
                    priority = 0
                }
            },
            function(results)
                local isAll = true
                for i = 1, #results do
                    local item = results[i]
                    if #item <= 0 then
                        isAll = false
                    end
                end
                randomTime = math.random(300, 600)
                print(type(fightpreChangeTeam))
                if isAll then
                    sysLog("战斗准备页面")
                else
                    sysLog("不在战斗准备页面")
                end
                -- 需要等一下，第一次英雄列表加载是异步的,可能会导致进去检测到英雄没选全
                mSleep(randomTime)
                return isAll
            end
        )

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
                    click(points.fightpre_change_team, {sleepAfter = 800})
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
                                        config = {sleepAfter = math.random(100, 200)}
                                    },
                                    {
                                        point = points.fightpre_pick_hero_pos_2,
                                        config = {sleepAfter = math.random(100, 200)}
                                    },
                                    {
                                        point = points.fightpre_pick_hero_pos_3,
                                        config = {sleepAfter = math.random(100, 200)}
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
                    if randomSleep and fightCount ~= 0 and fightCount % randomSleepStep == 0 then
                        local sleepTime = math.random(randomSleepStep * 3000, randomSleepStep * 5000)
                        print("step:", randomSleepStep, "休息一下：", sleepTime)
                        _showHUD("休息一下：" .. sleepTime .. "秒")
                        mSleep(sleepTime)
                        randomSleepStep = math.random(4, 8)
                        print(randomSleepStep)
                    end
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
            mSleep(loadingTime * 2 / 3)
        end

        fightProcessFunc()

        mSleep(2000)
        --检查结束页面
        --成功，随便点击一个点，然后开始检查是否有白字（金币上限），然后点击再次挑战，从头循环
        --失败，点击页面上的返回到挑战选关卡页面了，点击下一步
        local fightSuccess = true
        findThenArray(
            {
                {
                    range = rangecolors.fight_success_check_yellow_text.range,
                    color = rangecolors.fight_success_check_yellow_text.color,
                    degree = 90,
                    hdir = 0,
                    vdir = 0,
                    priority = 0
                }
            },
            function(results)
                local isAll = true
                for i = 1, #results do
                    local item = results[i]
                    if #item <= 0 then
                        isAll = false
                    end
                end
                if isAll then
                    sysLog("成功结果页面")
                    fightSuccess = true
                else
                    sysLog("结果页面 else")
                    findThenArray(
                        {
                            {
                                range = rangecolors.fight_failed_check_white_text_up.range,
                                color = rangecolors.fight_failed_check_white_text_up.color,
                                degree = 90,
                                hdir = 0,
                                vdir = 0,
                                priority = 0
                            },
                            {
                                range = rangecolors.fight_failed_check_white_text_down.range,
                                color = rangecolors.fight_failed_check_white_text_down.color,
                                degree = 90,
                                hdir = 0,
                                vdir = 0,
                                priority = 0
                            }
                        },
                        function(results)
                            local isAll = true
                            for i = 1, #results do
                                local item = results[i]
                                if #item <= 0 then
                                    isAll = false
                                end
                            end

                            if isAll then
                                sysLog("失败结果页面")
                                fightSuccess = false
                            end
                            -- 这里还需要继续检查，return true跳出失败页面检测，否则会一直卡在失败页面检测里面
                            return true
                        end
                    )
                end
                return isAll
            end
        )

        mSleep(2000)
        sysLog("fightSuccess:", fightSuccess)
        if fightSuccess then
            --随机点击一个点跳过
            randomClick()
        else
            click(points.fight_failed_back)
            --失败，退回到选择关卡页面，先判断上下按钮在不在，点击下一步
            findThenArray(
                {
                    {
                        range = rangecolors.fightpre_select_level_up.range,
                        color = rangecolors.fightpre_select_level_up.color,
                        degree = 90,
                        hdir = 0,
                        vdir = 0,
                        priority = 0
                    },
                    {
                        range = rangecolors.fightpre_select_level_down.range,
                        color = rangecolors.fightpre_select_level_down.color,
                        degree = 90,
                        hdir = 0,
                        vdir = 0,
                        priority = 0
                    }
                },
                function(results)
                    local isAll = true
                    for i = 1, #results do
                        local item = results[i]
                        if #item <= 0 then
                            isAll = false
                        end
                    end
                    if isAll then
                        sysLog("失败了，点击下一步")
                        click(points.fightpre_select_level_next)
                    else
                        click(points.fight_failed_back)
                    end
                    return isAll
                end
            )
        end

        fightEndTime = mTime()
        fightAllTime = fightAllTime + (fightEndTime - fightStartTime)
        fightCount = fightCount + 1
        averageTime = fightAllTime / fightCount

        goldCount = fightCount * goldPerFight
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

        local mem1 = collectgarbage("count")
        print("\bbefore collect memory is ", mem1, "kb")
        collectgarbage("collect")
        local mem2 = collectgarbage("count")
        print("\nafter collect memory is ", mem2, "kb")
    end
end
