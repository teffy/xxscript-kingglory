------------------------------------------------------------
--@desc 重定义系统方法，扩展系统方法，print,sysLog，使得可以打印table，可接收可变参数
--      重定义 getScreenSize，把结果中deviceW, deviceH 按照 deviceW > deviceH的方式交换
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

JSON = require("tflibs.JSON")
require("config")

--@desc 打印数据，兼容 table
--@param 要打印的数据
--@param oldFun 老的打印方法
-- function newprint(data, oldFun)
--     local datatype = type(data)
--     if datatype == 'table' then
--         oldFun(JSON:encode(data))
--     elseif datatype == 'boolean' then
--         if data then
--             oldFun('true')
--         else
--             oldFun('false')
--         end
--     elseif datatype == 'nil' then
--         oldFun('data is nil')
--     else
--         oldFun(data)
--     end
-- end

--@desc 将数据转换为 string
--@param 要打印的数据
function get_data_str(data)
    local datatype = type(data)
    if datatype == "table" then
        return JSON:encode(data)
    elseif datatype == "boolean" then
        if data then
            return "true"
        else
            return "false"
        end
    elseif datatype == "nil" then
        return "data is nil"
    else
        return data
    end
end

oldprint = print
print = function(...)
    if DEBUG then
        local str = ""
        for k, v in pairs({...}) do
            str = str .. get_data_str(v)
        end
        oldprint(str)
    end
end

oldsysLog = sysLog
sysLog = function(...)
    if DEBUG then
        local str = ""
        for k, v in pairs({...}) do
            str = str .. get_data_str(v)
        end
        oldsysLog(str)
    end
end


-- 重定义 getScreenSize，把结果中deviceW, deviceH 按照 deviceW > deviceH的方式交换
oldgetScreenSize = getScreenSize
getScreenSize = function()
    local deviceW, deviceH = oldgetScreenSize()
	if deviceW < deviceH then
		deviceW = deviceW + deviceH
		deviceH = deviceW - deviceH
		deviceW = deviceW - deviceH
    end
    return deviceW, deviceH
end