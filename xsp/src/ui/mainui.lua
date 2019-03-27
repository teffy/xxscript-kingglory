require("tflibs.util")
require("tflibs.XXUI")
require("config")

MainUI = {}

function MainUI:showUI()
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1200,
            okname = "开始脚本",
            cancelname = "休息一下",
            countdown = 10
        }
    )
    local basePage = Page:create({text = "基础设置"})
    local baseInfo =
        LinearLayout:create(
        {
            width = 1700,
            height = 100
        }
    )
    baseInfo:addView(
        Label:create(
            {
                text = "❤️天非❤️⚔️️王者️自动刷金⚔️️",
                width = 700,
                size = textSize,
                color = textColor
            }
        )
    )
    version = "Version " .. VERSION
    baseInfo:addView(
        Label:create(
            {
                text = version,
                width = 600,
                size = textSize,
                color = textColor
            }
        )
    )
    basePage:addView(baseInfo)
    basePage:addView(
        Label:create(
            {
                text = " 无需配置，自动刷魔女大师，到金币上限自动停止",
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
    basePage:addView(smallElf)
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
    basePage:addView(guideInfo)
    rootview:addView(basePage)

    local contactAuthor = Page:create({text = "联系作者"})
    local releaseHistory =
        Label:create(
        {
            text = "更新记录↓",
            size = textSize,
            color = textColor
        }
    )
    releaseHistory:addExtra("http://dev.xxzhushou.cn/scriptGuide.html?id=6468", releaseHistory.text)
    contactAuthor:addView(releaseHistory)
    -- 天非QQ：819143820，用户QQ群：718695261，欢迎进群反馈问题和意见，进群有福利，可以帮忙测试的有额外奖励哦
    local authorQQ =
        Label:create(
        {
            text = "QQ:819143820",
            size = textSize,
            color = textColor
        }
    )
    authorQQ:addExtra("QQ", "819143820")
    contactAuthor:addView(authorQQ)
    contactAuthor:addView(
        Label:create(
            {
                text = "QQ群：718695261",
                size = textSize,
                color = textColor
            }
        )
    )
    contactAuthor:addView(
        Label:create(
            {
                text = "欢迎进群反馈问题和意见，进群有福利，可以帮忙测试的有额外奖励哦",
                size = textSize,
                color = textColor
            }
        )
    )
    rootview:addView(contactAuthor)

    return rootview:showUI()
end
