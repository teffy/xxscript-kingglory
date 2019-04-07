------------------------------------------------------------
--@desc 根据云端配置提示用户下载小精灵版本 UI
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

CheckDownload = {}

function showDownloadUI(url)
    local rootview =
        RootView:create(
        {
            width = 1800,
            height = 1200,
            okname = "继续使用",
            cancelname = "嘤嘤嘤"
        }
    )
    rootview:addView(
        Label:create(
            {
                text = "⚠️⚠️⚠️ 本脚本有重大更新，但是由于叉叉助手节假日无法更新脚本",
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
    smallElf:addExtra(url, "下载小精灵版本，脚本更新更及时🚀，点我下载")
    rootview:addView(smallElf)

    return rootview:showUI()
end

function CheckDownload:checkDownload()
    -- 1-叉叉/免root叉叉；
    -- 2-内部使用；
    -- 3-开发助手；
    -- 4-内部使用；
    -- 5-叉叉IPA精灵；
    -- 6-叉叉小精灵；
    -- 7-叉叉酷玩；
    -- 8-叉叉云游
    product_id = getProduct()
    if product_id ~= nil then
        sysLog("product_id=" .. product_id)
        if product_id ~= 6 then
            -- DOWNLOAD_SMALL_APK 是否下载小精灵版本
            local content, err = getCloudContent("DOWNLOAD_SMALL_APK", "32670523E7000928", "null")
            if err == 0 then
                if content == "true" then
                    local content, err = getCloudContent("SMALL_APK_URL", "32670523E7000928", "null")
                    if err == 0 and content ~= "null" then
                        showDownloadUI(content)
                    end
                end
            elseif err == 1 then
                dialog("网络错误")
            elseif err == 999 then
                dialog("未知错误")
            end
        end
    end
end
