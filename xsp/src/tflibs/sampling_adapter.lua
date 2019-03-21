------------------------------------------------------------
--@desc 初始化和适配游戏坐标数据
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
JSON = require("tflibs.JSON")
require("tflibs.sys_fun_redef")

-- 游戏是横屏模式
-- 黑边模式，宽高比 > 2，即 W > 2*H 的情况下会出现黑边，但游戏有效宽区域为 H*2，居中，算法需要先去掉两边黑边
-- 非黑边模式，宽高比 >= 1 ，< 2，不需要处理黑边
-- 算法：将屏幕分为3个计算区，上中下，然后找到计算相对点，使用一套极端情况（3000x3000）的截图进行采样
-- 计算出采样点宽高比，然后使用这个比例根据实际屏幕宽高去计算
-- 1 top：在顶部排列，计算相对点A在顶部，左上角
--A___________上边界
--|
--|
-- 2 mid：在屏幕中间区域放置，但是在上半屏幕，计算相对点A为横向中轴线，左边
--_______________上边界
--|
--|A-------------横向中轴
--|
--_______________下边界
-- 3 down：在底部排列
--|
--|
--A___________下边界，计算相对点A在顶部，左下角
--
-- item 为要计算的坐标，包括x,y和这个坐标所在屏幕的 top mid bottom
-- is_black_mode 是否为黑边模式
-- samplingX,samplingY 为采样点的 X,Y
-- deviceW,deviceH 为设备宽高
-- samplingW,samplingH 为采样设备的宽高
-- tempW,tempH 为游戏有效区域的宽高，
-- 		非黑边状态就等于deviceW deviceH
-- 		黑边模式等于 deviceH*2,deviceH
-- black_gap 黑边模式下，真实设备每一侧的黑边宽度，等于 deviceW - deviceH/2
-- sampling_gap 黑边模式下，采样设备每一侧的黑边宽度，等于 samplingW - samplingH/2
-- X Y 为目标分辨率要进行适配计算的X,Y
-- 		黑边状态，X需要计算两边的黑边区域
--黑边模式
--top:
--(X-black_gap)/tempW =（samplingX-sampling_gap)/(samplingW-2*sampling_gap)
--Y/(X-black_gap) = samplingY/(samplingX-sampling_gap)
--
--bottom:
--(X-black_gap)/tempW = （samplingX-sampling_gap)/(samplingW-2*sampling_gap)
--(tempH-Y)/(X-black_gap) = (samplingH-samplingY)/(samplingX-sampling_gap)
--
--mid:
--(X-black_gap)/tempW =（samplingX-sampling_gap)/(samplingW-2*sampling_gap)
--(tempH/2-Y)/(X-black_gap) = (samplingH/2-samplingY)/(samplingX-sampling_gap)
--
--非黑边模式
--top:
--X/tempW = samplingX/samplingW
--Y/X = samplingY/samplingX
--
--bottom:
--X/tempW = samplingX/samplingW
--(tempH-Y)/X = (samplingH-samplingY)/samplingX
--
--mid:
--X/tempW = samplingX/samplingW
--(tempH/2-Y)/X = (samplingH/2-samplingY)/samplingX
--
function calculate_sampling_item(item,is_black_mode,black_gap,sampling_gap,samplingW,samplingH,tempW,tempH,deviceW,deviceW)
	x,y=0,0
	if item.pos == 'top' then
		if is_black_mode then
			--(X-black_gap)/tempW =（samplingX-sampling_gap)/(samplingW-2*sampling_gap)
			--Y/(X-black_gap) = samplingY/(samplingX-sampling_gap)
			x = ((item.x-sampling_gap)/(samplingW-2*sampling_gap)) * tempW + black_gap
			y = (item.y/(item.x-sampling_gap)) * (x - black_gap)
			print(item.x,'-',item.y,'==>',x,'-',y)
		else
			--X/tempW = samplingX/samplingW
			--Y/X = samplingY/samplingX
			x = (item.x/samplingW) * tempW
			y = (item.y/item.x) * x
		end
	elseif item.pos == 'bottom' then
		if is_black_mode then
			--(X-black_gap)/tempW = （samplingX-sampling_gap)/(samplingW-2*sampling_gap)
			--(tempH-Y)/(X-black_gap) = (samplingH-samplingY)/(samplingX-sampling_gap)
			x = ((item.x-sampling_gap)/(samplingW-2*sampling_gap)) * tempW + black_gap
			y = tempH - (samplingH-item.y)/(item.x-sampling_gap) * (x - black_gap)
			print(item.x,'-',item.y,'==>',x,'-',y)
		else
			--X/tempW = samplingX/samplingW
			--(tempH-Y)/X = (samplingH-samplingY)/samplingX
			x = (item.x/samplingW) * tempW
			y = tempH - ((samplingH-item.y)/item.x) * x
		end
	elseif item.pos == 'mid' then
		if is_black_mode then
			--(X-black_gap)/tempW =（samplingX-sampling_gap)/(samplingW-2*sampling_gap)
			--(tempH/2-Y)/(X-black_gap) = (samplingH/2-samplingY)/(samplingX-sampling_gap)
			x = ((item.x-sampling_gap)/(samplingW-2*sampling_gap)) * tempW + black_gap
			y = tempH/2 - ((samplingH/2-item.y)/(item.x-sampling_gap)) * (x - black_gap)
			print(item.x,'-',item.y,'==>',x,'-',y)
		else
			--X/tempW = samplingX/samplingW
			--(tempH/2-Y)/X = (samplingH/2-samplingY)/samplingX
			x = (item.x/samplingW) * tempW
			y = tempH/2 - ((samplingH/2-item.y)/item.x) * x
		end
	else
		print('unknown pos:',item)
	end
	item.x = x
	item.y = y
end

function calculate_sampling_data(deviceW, deviceH)
	if deviceW < deviceH then
		deviceW = deviceW + deviceH
		deviceH = deviceW - deviceH
		deviceW = deviceW - deviceH
	end
	local is_black_mode = (deviceW >= 2 * deviceH)
	sampling_json = 'sampling3000x3000.json'
	local black_gap = 0 -- 黑边模式下，真实设备每一侧的黑边宽度
	local sampling_gap = 0 -- 黑边模式下，采样设备每一侧的黑边宽度
	tempW,tempH=deviceW,deviceH --计算过程中使用的宽和高
	if is_black_mode then  --黑边模式，宽=2*高
		sampling_json = 'sampling3000x1200.json'
		tempW = deviceH * 2
		black_gap = deviceW/2 - deviceH
	end
	
	sampling_data_json = getUIContent(sampling_json)
	sampling_table = JSON:decode(sampling_data_json)
	samplingW,samplingH = sampling_table.width,sampling_table.height

	if is_black_mode then  --黑边模式，宽=2*高
		sampling_gap =  samplingW/2 - samplingH
	end

	sysLog('is_black_mode:',is_black_mode,',sampling_json:',sampling_json,',device:',deviceW,'-',deviceH,',temp:',tempW,'-',tempH,',black_gap:',black_gap,',sampling_gap:',sampling_gap)
	for k, v in pairs(sampling_table.points) do
		calculate_sampling_item(v,is_black_mode,black_gap,sampling_gap,samplingW,samplingH,tempW,tempH,deviceW,deviceW)
	end
	for k, v in pairs(sampling_table.rangecolors) do
		rangecolor = v
		range = rangecolor.range
		if #range == 4 then
			newrange = {}
			itemArrs = {{x=range[1],y=range[2],pos=rangecolor.pos},{x=range[3],y=range[4],pos=rangecolor.pos}}
			for i=1,2 do
				item = itemArrs[i]
				calculate_sampling_item(item,is_black_mode,black_gap,sampling_gap,samplingW,samplingH,tempW,tempH,deviceW,deviceW)
				table.insert(newrange,#newrange+1,item.x)
				table.insert(newrange,#newrange+1,item.y)
			end
			rangecolor.range = newrange
		end
	end
	return sampling_table
end

return calculate_sampling_data
