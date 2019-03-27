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
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1200,
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
    local smallElf =
        Label:create(
        {
            text = "下载小精灵版本，脚本更新更及时🚀，点我下载",
            size = textSize,
            color = textColor
        }
    )
    smallElf:addExtra("http://astdown.xxzhushou.cn/xxzhushou_spirte/spirit_script_19475_0_1.3.51_62060.apk", "下载小精灵版本，脚本更新更及时🚀，点我下载")
    rootview:addView(smallElf)
    -- buyState, validTime, res = getUserCredit()
    -- if buyState == 1 then

    -- end
    rootview:addView(
        Label:create(
            {
                text = "如果觉得不错，给作者来个打赏买包辣条吧",
                size = textSize,
                color = textColor
            }
        )
    )
    return rootview:showUI()
end
