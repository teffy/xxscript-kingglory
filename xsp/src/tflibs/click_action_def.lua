------------------------------------------------------------
--@desc 定义点击事件和点击之后的方法封装
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------

define.click{
	"number",
	"number",
	function (x,y)
		sysLog("click,x:"..x..",y:"..y)
		touchDown(1,x,y)
		mSleep(math.random(50,80))
		touchUp(1,x,y)
		mSleep(math.random(50,80))
		-- mSleep(2000)
	end
}

define.click{
	"number",
	"number",
	"number",
	function (x,y,sleepTime)
		click(x,y)
		mSleep(math.random(sleepTime,sleepTime+300))
	end
}

--@desc 点击事件
--@param x x坐标
--@param y y坐标
--@param sleepTime 休眠时长
--@param clickTime 点击次数
define.click{
	"number",
	"number",
	"number",
	"number",
	function (x,y,sleepTime,clickTime)
		if clickTime > 0 then
			for tmpi=1,clickTime do
					click(x,y,sleepTime)
					mSleep(math.random(100,200))
			end
		end
	end
}

define.click{
	"table",
	function (point)
		click(point.x,point.y)
	end
}

define.click{
	"table",
	"number",
	function (point,sleepTime)
		click(point.x,point.y,sleepTime)
	end
}

--@desc 点击事件
--@param point 坐标table，包含x,y
--@param sleepTime 休眠时长
--@param clickTime 点击次数
define.click{
	"table",
	"number",
	"number",
	function (point,sleepTime,clickTime)
		click(point.x,point.y,sleepTime,clickTime)
	end
}

--@desc 根据坐标颜色找到点之后执行 thenFn 方法
--@param posRange 坐标，上下左右
--@param posColor 颜色
--@param similarity 相似度
--@param thenFn 找到之后要执行的方法，该方法必须有返回 true的 case，否则会陷入死循环
define.findThen{
	"table",
	"string",
	"number",
	"function",
	function (posRange,posColor,similarity,thenFn)
		sysLog('posRange:',posRange,',posColor:',posColor)
--		keepScreen(true)
		while true do
			x, y = findColor(posRange, posColor,similarity, 0, 0, 0)
			--sysLog("findThen,x:"..x..",y:"..y)
			if thenFn(x,y) then
				break
			end
			mSleep(math.random(100,200))
		end
--		keepScreen(false)
	end
}

define.findThen{
	"table",
	"string",
	"function",
	function (posRange,posColor,thenFn)
		findThen(posRange,posColor,95,thenFn)
	end
}
