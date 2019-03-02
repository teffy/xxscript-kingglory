------------------------------------------------------------
--@desc UI适配器
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
JSON = require("tflibs.JSON")

--@desc 适配UI
--@param json 文件名
--@param scaleW 宽缩放比
--@param scaleH 高缩放比
function adapterUI(json,scaleW,scaleH)
    content = getUIContent(json)
    uiData = JSON:decode(content)
    uiData.width = uiData.width * scaleW
    uiData.height = uiData.height * scaleH
    if #uiData.views > 0 then
        for i,v in pairs(uiData.views) do
            if v.width ~= nil then
                v.width = v.width * scaleW
            end
            if v.height ~= nil then
                v.height = v.height * scaleH
            end
            if v.size ~= nil then
                v.size = v.size * (scaleH + scaleW) / 2
            end
        end
    end
    return JSON:encode(uiData)
end

return adapterUI
