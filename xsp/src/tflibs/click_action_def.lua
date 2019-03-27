------------------------------------------------------------
--@desc 定义点击事件和点击之后的方法封装，所有传递尽量的参数都不能是nil，如果需要，定义重载方法，传nil
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

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
		print(config)
		sysLog("click,x:" .. x .. ",y:" .. y,',config:',config)
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		local index = math.random(1,5)
		local sleepTime = (config and config.sleepTime) or 0
		local clickCount = (config and config.clickCount) or 1
		local sleepAfter = (config and config.sleepAfter) or 0
		for i=1,clickCount do
			x = x + math.random(-2,2)
			if x < 0 then x = 0 end
			y = y + math.random(-2,2)
			if y < 0 then y = 0 end
			touchDown(index,x, y)
			mSleep(math.random(sleepTime+60,sleepTime+80))
			touchUp(index, x, y)
			mSleep(sleepAfter+200)
		end
	end
}

define.click {
	"number",
	"number",
	function(x, y)
		click(x,y,{})
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

--@desc 根据坐标颜色找到点之后执行 thenFn 方法
--@param posRange 坐标，上下左右
--@param posColor 颜色
--@param similarity 相似度
--@param thenFn 找到之后要执行的方法，该方法必须有返回 true的 case，否则会陷入死循环
define.findThen {
	"table",
	"string",
	"number",
	"function",
	function(posRange, posColor, similarity, thenFn)
		sysLog("posRange:", posRange, ",posColor:", posColor)
		--		keepScreen(true)
		while true do
			x, y = findColor(posRange, posColor, similarity, 0, 0, 0)
			--sysLog("findThen,x:"..x..",y:"..y)
			if thenFn(x, y) then
				break
			end
			mSleep(math.random(100, 200))
		end
		--		keepScreen(false)
	end
}

function randomClick(deviceW,deviceH)
	math.randomseed(tostring(os.time()))
	click(math.random(deviceW * 0.33, deviceW * 0.66), math.random(deviceH * 0.33, deviceH * 0.66))
end

-- 顺序点击这样的坐标点数组，[{point:{},config:{}}]
function clickArray(...)
	local arg = {...}
	for i=1,#arg do
		local item = arg[i]
		if item.point then
			click(item.point,item.config or {})
		end
	end
end

define.findThen {
	"table",
	"string",
	"function",
	function(posRange, posColor, thenFn)
		findThen(posRange, posColor, 95, thenFn)
	end
}
