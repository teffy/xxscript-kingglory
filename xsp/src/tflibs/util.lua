------------------------------------------------------------
--@desc 工具类
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
util = {}
--@desc 时间转换为时分秒
--@timelong 时长，单位毫秒
function util:time2Text(timelong)
    h, m, s = 0, 0, 0
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
    text = ""
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

--@desc 任务执行完成，提示用户
--@fightAllTime 总执行时长，单位毫秒
--@averageTime  平均时长，单位毫秒
--@goldCount    获得金币
function util:taskFinished(fightAllTime, averageTime, goldCount)
    text =
        string.format(
        "🌹恭喜亲🌹，刷到金币上限了\n总时长%s，已获得%d金币，平均每局时长%s",
        util:time2Text(fightAllTime),
        goldCount,
        util:time2Text(averageTime)
    )
    buyState, validTime, res = getUserCredit()
    if buyState == 1 then
        text = text .. "\n如果觉得不错，给作者来个打赏吧，你的打赏是我的动力"
    end
    text = text .. "\n有问题"
    dialog(text, 0)

    
end

-- buyState	整数型	用户付费类型，1 - 付费用户，2 - 试用用户，3 - 免费用户，0 - 非购买非试用
-- validTime	整数型	用户当前套餐购买时长，单位为秒，试用用户的情况下会返回0
-- res	整数型	返回错误代码，0 - 正常， 非0 - 出错
