------------------------------------------------------------
--@desc 引导用户调整手机 UI
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("tflibs.XXUI")
require("config")

GuideUI = {}

function GuideUI:showUI()
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1200,
            okname = "调整好了",
            cancelname = "嘤嘤嘤",
            countdown = 5
        }
    )
    local guideInfo =
        LinearLayout:create(
        {
            width = 1700,
            height = 600,
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
