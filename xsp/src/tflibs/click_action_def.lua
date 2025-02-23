------------------------------------------------------------
--@desc 定义点击事件和点击之后的方法封装，所有传递尽量的参数都不能是nil，如果需要，定义重载方法，传nil
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

require("config")

local defaultSleepTime = 40
rootMode = isPrivateMode()
osType = getOSType()
if osType == "iOS" then
	--defaultSleepTime = 40
elseif osType == "android" then
	if rootMode == 0 then
		defaultSleepTime = 500
	elseif rootMode == 1 then
	--defaultSleepTime = 40
	end
end


function _createHUD()
	if FOR_TEST_SHOW_POINT then
		hud_id = createHUD()
		return hud_id
	end
	return nil
end

function _showHUD(hud_id,x,y)
	if FOR_TEST_SHOW_POINT and hud_id then
		showHUD(hud_id, "", 1, "0xff000000", "red_point.png", 0, x - 15, y - 30, 30, 30)
		mSleep(RED_TIPFLAG_SHOW_TIME)
	end
end

function _showHUD2(hud_id,x,y,time)
	if FOR_TEST_SHOW_POINT and hud_id then
		showHUD(hud_id, "", 1, "0xff000000", "red_point.png", 0, x - 15, y - 30, 30, 30)
		mSleep(time)
	end
end

function _hideHUD(hud_id)
	if FOR_TEST_SHOW_POINT and hud_id then
		mSleep(RED_TIPFLAG_SHOW_TIME)
		hideHUD(hud_id)
	end
end

--@desc 点击事件
--@param x x坐标
--@param y y坐标
--@param config {
--				sleepTime:点击过程中休眠时长
--				clickCount:点击次数
--				sleepAfter:点击过后休眠时长
--				}
define.click {
	"number",
	"number",
	"table",
	function(x, y, config)
		-- sysLog("click,x:" .. x .. ",y:" .. y, ",config:", config)
		local deviceW, deviceH = getScreenSize()
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		local index = math.random(1, 5)
		local sleepTime = (config and config.sleepTime) or 0
		local clickCount = (config and config.clickCount) or 1
		local sleepAfter = (config and config.sleepAfter) or defaultSleepTime
		local hud_id
		for i = 1, clickCount do
			hud_id = _createHUD()
			x = x + math.random(-2, 2)
			if x < 5 then
				x = 5
			end
			if x >= deviceW then
				x = deviceW - 5
			end
			y = y + math.random(-2, 2)
			if y < 5 then
				y = 5
			end
			if y >= deviceW then
				y = deviceH - 5
			end
			_showHUD(hud_id,x,y)
			touchDown(index, x, y)
			mSleep(sleepTime + math.random(40, 80))
			touchUp(index, x, y)
			mSleep(sleepAfter + math.random(200, 400))
			_hideHUD(hud_id)
		end
	end
}

define.click {
	"number",
	"number",
	function(x, y)
		click(x, y, {})
	end
}

--@desc 点击事件
--@param point 坐标点
--@param config {
--				sleepTime:点击过程中休眠时长
--				clickCount:点击次数
--				sleepAfter:点击过后休眠时长
--				}
define.click {
	"table",
	"table",
	function(point, config)
		click(point.x, point.y, config)
	end
}

define.click {
	"table",
	function(point)
		click(point.x, point.y, {})
	end
}

function randomClick()
	math.randomseed(tostring(os.time()))
	click(math.random(deviceW * 0.33, deviceW * 0.66), math.random(deviceH * 0.33, deviceH * 0.66))
end

-- 顺序点击这样的坐标点数组，[{point:{},config:{}}]
function clickArray(...)
	local arg = {...}
	for i = 1, #arg do
		local item = arg[i]
		if item.point then
			click(item.point, item.config or {})
		end
	end
end

--@desc 根据坐标颜色找到点之后执行 thenFn 方法
--@param posRange 坐标，上下左右
--@param posColor 颜色
--@param similarity 相似度
--@param thenFn 找到之后要执行的方法，该方法必须有返回 true的 case，否则会陷入死循环
--@param timeOut 超时时长
--@param timeOutFn 超时之后要执行的方法
define.findThen {
	"table",
	"string",
	"number",
	"function",
	"number",
	"function",
	function(posRange, posColor, similarity, thenFn, timeOut, timeOutFn)
		-- sysLog("posRange:", posRange, ",posColor:", posColor)
		local mStart = mTime()
		local mEnd = 0
		while true do
			x, y = findColor(posRange, posColor, similarity, 0, 0, 0)
			--sysLog("findThen,x:"..x..",y:"..y)
			if thenFn(x, y) then
				break
			end
			mSleep(math.random(100, 200))
			if timeOutFn and timeOut > 0 then
				mEnd = mTime()
				if mEnd - mStart > timeOut then
					if timeOutFn() then
						break
					end
				end
			end
		end
	end
}

define.findThen {
	"table",
	"string",
	"function",
	function(posRange, posColor, thenFn)
		findThen(
			posRange,
			posColor,
			95,
			thenFn,
			0,
			function()
				return true
			end
		)
	end
}

define.findThenArray {
	"table",
	"function",
	"number",
	"function",
	function(rangeColors, thenFn, timeOut, timeOutFn)
		local mStart = mTime()
		local mEnd = 0
		while true do
			local results = {}
			for i = 1, #rangeColors do
				local item = rangeColors[i]
				local itemResult = findColors(item.range, item.color, item.degree, item.hdir, item.vdir, item.priority)
				print('itemResult',itemResult)
				table.insert(results, itemResult)
			end
			if thenFn(results) then
				break
			end
			if timeOutFn and timeOut > 0 then
				mEnd = mTime()
				if mEnd - mStart > timeOut then
					if timeOutFn() then
						break
					end
				end
			end
		end
	end
}

define.findThenArray {
	"table",
	"function",
	function(rangeColors, thenFn)
		findThenArray(
			rangeColors,
			thenFn,
			0,
			function()
				return true
			end
		)
	end
}

define.move {
	"table",
	"table",
	function(startP, movePs)
		print(startP)
		print(movePs)
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		local index = math.random(1, 5)
		local step = 20
		local function checkFT(from, to)
			if from > to then
				do
					return -1 * step
				end
			else
				return step
			end
		end
		local hud_id = _createHUD()
		local startX,startY = startP.x,startP.y
		local moveX,moveY = startX,startY
		local endX,endY
		touchDown(index, startX, startY)
		_showHUD2(hud_id,moveX,moveY,50)
		for i = 1, #movePs do
			local itemP = movePs[i]
			endX,endY = itemP.x,itemP.y
			while (math.abs(moveX-endX) >= step) or (math.abs(moveY-endY) >= step) do
				if math.abs(moveX-endX) >= step then moveX = moveX + checkFT(startX,endX) end
				if math.abs(moveY-endY) >= step then moveY = moveY + checkFT(startY,endY) end
				touchMove(index, moveX, moveY)
				mSleep(20)
				_showHUD2(hud_id,moveX,moveY,50)
			end
			touchMove(index, endX, endY)
			_showHUD2(hud_id,endX, endY,50)
			mSleep(itemP.time)
			startX,startY = endX,endY
			if i== #movePs then
				touchUp(index, endX, endY)
			end
		end
		_hideHUD(hud_id)
	end
}