------------------------------------------------------------
--@desc 主功能，脚本逻辑
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("init")
require("fight.monvfight")

require("ui.mainui")
require("ui.guideui")

local ret, result = MainUI:showUI()
if ret == 1 then
	sysLog("确定")
else
	sysLog("取消")
	return
end

local isRightScreenDirection = true
local screenD = getScreenDirection()
local osType = getOSType()
sysLog("screenDirection:" .. screenD .. ",osType:" .. osType)
if screenD ~= 1 then
	GuideUI:showUI()
end
mSleep(1000) -- 手机虚拟键盘消失会过程会影响点击

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

local test = false
if test then
	mSleep(3000)
    local points = sampling_adapter_data.points
    local rangecolors = sampling_adapter_data.rangecolors
    
    click(points.fightpre_select_level_up)
    -- findThen(
    --     rangecolors.fightpre_check_hero_enough.range,
    --     rangecolors.fightpre_check_hero_enough.color,
    --     function(x, y)
    --         if x > -1 then
    --             sysLog("没选够3个英雄")
    --             --点击更换阵容
    --             click(points.fightpre_change_team, {sleepTime=800})
    --             --在选择英雄界面检查第三个英雄是否已经选择
    --             findThen(
    --                 rangecolors.fightpre_pick_hero_check_hero_enough.range,
    --                 rangecolors.fightpre_pick_hero_check_hero_enough.color,
    --                 function(x, y)
    --                     if x > -1 then
    --                         clickArray(
    --                             --选3个英雄
    --                             {point=points.fightpre_pick_hero_pos_1, config={sleepTime=math.random(100,200)}},
    --                             {point=points.fightpre_pick_hero_pos_2, config={sleepTime=math.random(100,200)}},
    --                             {point=points.fightpre_pick_hero_pos_3, config={sleepTime=math.random(100,200),sleepAfter=300}},
    --                             --点击确定开始
    --                             {point=points.fightpre_pick_hero_confirm,config={clickCount=1}}
    --                         )
    --                         return true
    --                     end
    --                 end
    --             )
    --         else
    --             sysLog("选够3个英雄")
    --             --点击闯关
    --             click(points.fightpre_rush_through)
    --         end
    --         return true
    --     end
    -- )

	return
end

monv:fight(sampling_adapter_data)

-- getCloudContent可以用来在脚本执行过程中提示用户加群
-- content, err = getCloudContent("NEW_VERSION","32670523E7000928","test")
-- sysLog(string.format("getCloudContent return content = %s, err = %s", tostring(content), tostring(err)));
-- if err == 0 then
--   dialog(content)
-- elseif err == 1 then
--   dialog("网络错误")
-- elseif err == 999 then
--   dialog("未知错误")
-- end