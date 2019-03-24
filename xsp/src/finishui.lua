require("tflibs.util")
require("tflibs.XXUI")
require("config")

FinishUI = {}

function FinishUI:showUIOnExit()
    return FinishUI:showUIOnTaskFinish(0, 0, 0)
end
--@desc 任务执行完成，提示用户
--@fightAllTime 总执行时长，单位毫秒
--@averageTime  平均时长，单位毫秒
--@goldCount    获得金币
function FinishUI:showUIOnTaskFinish(fightAllTime, goldCount, averageTime)
    local textSize = 55
    local textColor = "76,137,228"

    local rootview =
        RootView:create(
        {
            width = 1700,
            height = 600,
            okname = "朕知道了",
            cancelname = "嘤嘤嘤"
        }
    )
    taskFinish = fightAllTime > 0 and goldCount > 0 and averageTime > 0
    if taskFinish then
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
                    text = "遇到❓神马问题了吗？联系作者反馈问题吧",
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

    buyState, validTime, res = getUserCredit()
    if buyState == 1 then
        rootview:addView(
            Label:create(
                {
                    text = "如果觉得不错，给作者来个打赏吧，你的打赏是我的动力",
                    size = textSize,
                    color = textColor
                }
            )
        )
    end
    return rootview:showUI()
end
