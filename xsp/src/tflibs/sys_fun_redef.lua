------------------------------------------------------------
--@desc 重定义系统方法，扩展系统方法，print,sysLog，使得可以打印table，可接收可变参数
--      重定义 getScreenSize，把结果中deviceW, deviceH 按照 deviceW > deviceH的方式交换
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

JSON = require("tflibs.JSON")
require("config")

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

-- hook find colors show 选取范围
oldfindColors = findColors
findColors = function(range, color0, degree, hdir, vdir, priority)
    if FOR_TEST_SHOW_FRAME then
        local hud_id = createHUD()
        local l = range[1]
        local t = range[2]
        local w = range[3] - range[1]
        local h = range[4] - range[2]
        print('findColors range:',range[1],',',range[2],',',range[3],',',range[4])
        print('findColors color0:',color0)
        print('l:',l,',t:',t,',w:',w,',h:',h)
        showHUD(hud_id, "", 1, "0xff000000", "red_frame.png", 0, l ,t, w, h)
        mSleep(RED_TIPFLAG_SHOW_TIME)
        hideHUD(hud_id)
        mSleep(RED_TIPFLAG_SHOW_TIME)
    end
    return oldfindColors(range, color0, degree, hdir, vdir, priority)
end

oldfindColor = findColor
findColor = function(range, color0, degree, hdir, vdir, priority)
    if FOR_TEST_SHOW_FRAME then
        local hud_id = createHUD()
        local l = range[1]
        local t = range[2]
        local w = range[3] - range[1]
        local h = range[4] - range[2]
        print('findColor range:',range[1],',',range[2],',',range[3],',',range[4])
        print('findColor color0:',color0)
        print('l:',l,',t:',t,',w:',w,',h:',h)
        showHUD(hud_id, "", 1, "0xff000000", "red_frame.png", 0, l ,t, w, h)
        mSleep(RED_TIPFLAG_SHOW_TIME)
        hideHUD(hud_id)
        mSleep(RED_TIPFLAG_SHOW_TIME)
    end
    return oldfindColor(range, color0, degree, hdir, vdir, priority)
end