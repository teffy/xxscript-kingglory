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
		sysLog("click,x:" .. x .. ",y:" .. y, ",config:", config)
		local deviceW, deviceH = getScreenSize()
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		local index = math.random(1, 5)
		local sleepTime = (config and config.sleepTime) or 0
		local clickCount = (config and config.clickCount) or 1
		local sleepAfter = (config and config.sleepAfter) or defaultSleepTime
		local hud_id
		for i = 1, clickCount do
			if FOR_TEST_SHOW_POINT then
				hud_id = createHUD()
			end
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
			if FOR_TEST_SHOW_POINT then
				showHUD(hud_id, "", 1, "0xff000000", "red_point.png", 0, x - 15, y - 30, 30, 30)
				mSleep(RED_TIPFLAG_SHOW_TIME)
			end
			touchDown(index, x, y)
			-- local randomX = math.random(-5,5)
			-- local randomY = math.random(-5,5)
			mSleep(sleepTime + math.random(80, 120))
			-- touchMove(index, x + randomX, y + randomY)
			-- mSleep(math.random(10,20))
			-- mSleep(math.random(sleepTime+60,sleepTime+80))
			-- touchUp(index, x + randomX, y + randomY)
			touchUp(index, x, y)
			mSleep(sleepAfter + math.random(300, 500))
			if FOR_TEST_SHOW_POINT then
				mSleep(RED_TIPFLAG_SHOW_TIME)
				hideHUD(hud_id)
			end
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

function randomClick(deviceW, deviceH)
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
		sysLog("posRange:", posRange, ",posColor:", posColor)
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
