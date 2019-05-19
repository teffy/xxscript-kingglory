------------------------------------------------------------
--@desc 主页面 UI
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("tflibs.util")
require("tflibs.XXUI")
require("config")

MainUI = {}

function MainUI:showUI()
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1600,
            okname = "开始脚本",
            cancelname = "休息一下",
            countdown = 20
        }
    )
    local basePage = Page:create({text = "基础设置"})
    local baseInfo =
        LinearLayout:create(
        {
            width = 1800,
            height = 120
        }
    )
    baseInfo:addView(
        Label:create(
            {
                text = "❤️天非❤️⚔️️金手指⚔️️",
                width = 700,
                size = textSize,
                color = textColor
            }
        )
    )
    if FOR_TEST then
        basePage:addView(
            Label:create(
                {
                    text = " 测试版本，新进群的不要下载使用，如果是帮群主测试的，请录屏然后把运行结果反馈给群主",
                    size = textSize,
                    color = textColor
                }
            )
        )
    else
        local version = "Version " .. VERSION
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
    end
    basePage:addView(baseInfo)
    selectFightSelect = "0"
    if IS_VIP then
        selectFightSelect = "1"
    end
    local selectFight = RadioGroup:create({
        id = "selectFight",
        list = "魔女,通天塔,刺秦之地",
        select = selectFightSelect,
        size = 40,
        orientation = Orientation.HORIZONTAL
    })
    basePage:addView(selectFight)
    basePage:addView(
        Label:create(
            {
                text = " 魔女、通天塔、刺秦之地大师可选，金币上限自动停止",
                size = textSize,
                color = textColor
            }
        )
    )
    if isAndroid and smallApkUrl then
        local smallElf =
            Label:create(
            {
                text = "下载小精灵版本，脚本更新更及时🚀，点我下载",
                size = textSize,
                color = textColor
            }
        )
        smallElf:addExtra(
            smallApkUrl,
            "下载小精灵版本，脚本更新更及时🚀，点我下载"
        )
        basePage:addView(smallElf)
    end
    basePage:addView(
        CheckBoxGroup:create(
            {
                id = "autoStop",
                width = 400,
                list = "到金币上限自动停止",
                select = "0"
            }
        )
    )
    basePage:addView(
        CheckBoxGroup:create(
            {
                id = "randomSleep",
                width = 400,
                list = "随机休眠（部分用户有被封过建议开启）"
            }
        )
    )
    local autoCloseGameList = "到金币上限自动关闭游戏"
    if isIOS then 
        autoCloseGameList = autoCloseGameList.."并锁屏"
    end
    basePage:addView(
        CheckBoxGroup:create(
            {
                id = "autoCloseGame",
                width = 600,
                list = autoCloseGameList
                -- select = "0"
            }
        )
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
