--------------------------------
--定义 点击事件和点击之后的方法封装
--------------------------------

define.click{
	"number",
	"number",
	function (x,y)
		sysLog("click,x:"..x..",y:"..y)
		touchDown(1,x,y)
		mSleep(math.random(50,80))
		touchUp(1,x,y)
		mSleep(math.random(50,80))
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

define.click{
	"table",
	"number",
	"number",
	function (point,sleepTime,clickTime)
		click(point.x,point.y,sleepTime,clickTime)
	end
}

define.findThen{
	"table",
	"string",
	"number",
	"function",
	function (posRange,posColor,similarity,thenFn)
		--sysLog(posRange[1])
		--sysLog(posColor)
		while true do
			x, y = findColor(posRange, posColor,similarity, 0, 0, 0)
			sysLog("findThen,x:"..x..",y:"..y)
			if thenFn(x,y) then
				break
			end
			mSleep(math.random(100,200))
		end
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
