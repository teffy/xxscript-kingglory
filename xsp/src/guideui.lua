require("tflibs.util")
require("tflibs.XXUI")
require("config")

GuideUI = {}

function GuideUI:showUI()
    local textSize = 55
    local textColor = "76,137,228"

    local rootview =
        RootView:create(
        {
            width = 1700,
            height = 600,
            okname = "调整好了",
            cancelname = "再等等"
        }
    )
    local guideInfo =
        LinearLayout:create(
        {
            width = 1700,
            height = 500,
            valign = VAlign.CENTER
        }
    )
    guideInfo:addView(
        Image:create(
            {
                src = "phone_guide.png",
                width = 700
            }
        )
    )
    guideInfo:addView(
        Label:create(
            {
                text = "先把手机方向调整为左图所示，然后进入游戏，在主页面开启脚本",
                width = 600,
                size = textSize,
                color = textColor
            }
        )
    )
    rootview:addView(guideInfo)

    return rootview:showUI()
end
