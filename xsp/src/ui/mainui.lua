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
    local configFile = "save.dat"
    if IS_VIP then
        configFile = "vipsave.dat"
    end
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1400,
            config = configFile,
            okname = "开始脚本",
            cancelname = "休息一下",
            countdown = 30
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
    local srciptName = "天非金手指"
    if IS_VIP then
        srciptName = "天非金手指"
    end
    baseInfo:addView(
        Label:create(
            {
                text = srciptName,
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
                    text = " 测试版本，新进群的不要下载使用，有问题的，请录屏然后把运行结果反馈给群主",
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

    local product_id = getProduct()
    local notSmallApkRuntime = product_id ~= 6 and product_id ~= 5
    if isAndroid and smallApkUrl and notSmallApkRuntime then
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
    basePage:addView(baseInfo)

    local fightTypeList = "冒险挑战"
    if IS_VIP then
        fightTypeList = fightTypeList..",六国远征,武道大会"
    end
    local fightTypeSelect = 0
    local fightType = RadioGroup:create({
        id = "fightType",
        list = fightTypeList,
        select = fightTypeSelect,
        size = 40,
        orientation = Orientation.HORIZONTAL
    })
    basePage:addView(fightType)

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

    -- 冒险设置
    local riskSetting = Page:create({text = "冒险挑战"})

    local riskFightLevelSelect = "2"
    local riskFightLevelList = "普通,精英,大师"
    local riskFightLevel = RadioGroup:create({
        id = "riskFightLevel",
        list = riskFightLevelList,
        select = riskFightLevelSelect,
        size = 40,
        orientation = Orientation.HORIZONTAL
    })
    riskSetting:addView(riskFightLevel)
    
    local selectFightSelect = "0"
    local selectFightList = "魔女,通天塔,刺秦之地,血王宫"
    if IS_VIP then
        selectFightSelect = "1"
    end
    local selectFight = RadioGroup:create({
        id = "selectFight",
        list = selectFightList,
        select = selectFightSelect,
        size = 40,
        orientation = Orientation.HORIZONTAL
    })
    riskSetting:addView(selectFight)
    riskSetting:addView(Label:create({
            text = "挑战次数",
            size = textSize,
            color = textColor
        })
    )
    riskSetting:addView(ComboBox:create({
        id = "fightCount",
        list = fightCountStr,
        select = "6",
        width = 200
    }))
    riskSetting:addView(
        CheckBoxGroup:create(
            {
                id = "randomSleep",
                width = 400,
                list = "随机休眠（部分用户有被封过建议开启）"
            }
        )
    )
    local autoCloseGameList = "挑战结束后自动关闭游戏"
    if isIOS then 
        autoCloseGameList = autoCloseGameList.."并锁屏"
    end
    riskSetting:addView(
        CheckBoxGroup:create(
            {
                id = "autoCloseGame",
                width = 600,
                list = autoCloseGameList
                -- select = "0"
            }
        )
    )
    rootview:addView(riskSetting)

    -- local sixNationFight = Page:create({text = "六国远征"})
    -- rootview:addView(sixNationFight)

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
                text = "欢迎进群反馈问题和意见",
                size = textSize,
                color = textColor
            }
        )
    )
    rootview:addView(contactAuthor)

    return rootview:showUI()
end
