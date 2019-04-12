------------------------------------------------------------
--@desc 脚本结束 UI
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("tflibs.XXUI")
require("config")

FinishUI = {}

showed = false

function FinishUI:showUIOnExit()
    return FinishUI:showUIOnTaskFinish(nil, false)
end

--@desc 任务执行完成，提示用户
--@param fightResult
--                  fightAllTime 总执行时长，单位毫秒
--                  averageTime  平均时长，单位毫秒
--                  goldCount    获得金币
--@param goldLimitFinish，是否是金币上限结束的
function FinishUI:showUIOnTaskFinish(fightResult, goldLimitFinish)
    if userClick ~= 1 then -- 用户开始就点了取消
        return
    end
    local fightAllTime, goldCount, averageTime = 0, 0, 0
    if fightResult then
        fightAllTime = fightResult.fightAllTime
        goldCount = fightResult.goldCount
        averageTime = fightResult.averageTime
    end
    print("showUIOnTaskFinish:", showed)
    if showed then
        return
    end
    local oknameStr = "朕知道了"
    local countdownTime = -1
    if autoCloseGame and goldLimitFinish then
        oknameStr = "关闭游戏"
        countdownTime = 10
    end
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1200,
            okname = oknameStr,
            cancelname = "嘤嘤嘤",
            countdown = countdownTime
        }
    )
    if goldLimitFinish then
        rootview:addView(
            Label:create(
                {
                    text = "🌹恭喜亲🌹，刷到金币上限了",
                    size = textSize,
                    color = textColor
                }
            )
        )
        fightInfoText =
            string.format(
            "总时长%s，已获得%d金币，平均每局时长%s",
            util:time2Text(fightAllTime),
            goldCount,
            util:time2Text(averageTime)
        )
        rootview:addView(
            Label:create(
                {
                    text = fightInfoText,
                    size = textSize,
                    color = textColor
                }
            )
        )
    else
        rootview:addView(
            Label:create(
                {
                    text = "遇到神马问题了吗❓联系作者反馈问题",
                    size = textSize,
                    color = textColor
                }
            )
        )
    end

    local authorQQ =
        Label:create(
        {
            text = "QQ:819143820",
            size = textSize,
            color = textColor
        }
    )
    authorQQ:addExtra("QQ", "819143820")
    rootview:addView(authorQQ)
    rootview:addView(
        Label:create(
            {
                text = "QQ群：718695261，有问题进群反馈",
                size = textSize,
                color = textColor
            }
        )
    )
    local smallElf =
        Label:create(
        {
            text = "下载小精灵版本，脚本更新更及时🚀，点我下载",
            size = textSize,
            color = textColor
        }
    )
    smallElf:addExtra(
        "http://astdown.xxzhushou.cn/xxzhushou_spirte/spirit_script_19475_0_1.3.51_62060.apk",
        "下载小精灵版本，脚本更新更及时🚀，点我下载"
    )
    rootview:addView(smallElf)
    -- buyState, validTime, res = getUserCredit()
    -- if buyState == 1 then

    -- end
    rootview:addView(
        Label:create(
            {
                text = "如果觉得不错，推荐给其他小伙伴吧",
                size = textSize,
                color = textColor
            }
        )
    )
    showed = true
    local ret, result = rootview:showUI()
    if ret == 1 and autoCloseGame and goldLimitFinish then
        local re = closeApp(APP_PACKAGE_NAME)
        lockDevice()
    end
    lua_exit()
end
