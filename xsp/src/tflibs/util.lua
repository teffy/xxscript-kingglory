------------------------------------------------------------
--@desc 工具类
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
util = {}
--@desc 时间转换为时分秒
--@timelong 时长，单位毫秒
function util:time2Text(timelong)
    local h, m, s = 0, 0, 0
    text = ""
    if timelong <= 1000 then
        s = 1
    else
        s = timelong / 1000
        m = s / 60
        s = s % 60
        h = m / 60
        m = m % 60
    end
    h = math.floor(h)
    m = math.floor(m)
    s = math.floor(s)
    if h > 0 then
        text = text .. h .. "时"
    end
    if m > 0 then
        text = text .. m .. "分"
    end
    if s > 0 then
        text = text .. s .. "秒"
    end
    return text
end

-- buyState	整数型	用户付费类型，1 - 付费用户，2 - 试用用户，3 - 免费用户，0 - 非购买非试用
-- validTime	整数型	用户当前套餐购买时长，单位为秒，试用用户的情况下会返回0
-- res	整数型	返回错误代码，0 - 正常， 非0 - 出错
