------------------------------------------------------------
--@desc UI适配器，计算黑边模式
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
JSON = require("tflibs.JSON")
require("config")

defaultW,defaultH= 1440,2560

--@desc 适配UI
--@param json 文件名
--@param deviceW 设备宽
--@param deviceH 设备高
function adapterUI(json,deviceW, deviceH)
    content = getUIContent(json)
    uiData = JSON:decode(content)
    scaleW = deviceW / defaultW
    scaleH = deviceH / defaultH
    if deviceW > 2 * deviceH then -- 黑边模式，不能按照设备宽高缩放
        scaleW = deviceH * 2 / defaultW
    end
    resize(uiData,scaleW,scaleH)
    return JSON:encode(uiData)
end

function resize(view,scaleW,scaleH)
    if view.width ~= nil then
        view.width = view.width * scaleW
    end
    if view.height ~= nil then
        view.height = view.height * scaleH
    end
    if view.size ~= nil then
        view.size = view.size * scaleW
    end
    print(VERSION)
    if view.id ~= nil and view.id == "version" then
        view.text = "Version " .. VERSION
    end
    if view.views ~= nil and #view.views > 0 then
        for i,v in pairs(view.views) do
            resize(v,scaleW,scaleH)
        end
    end
end

return adapterUI
