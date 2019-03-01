--------------------------------
--主功能
--------------------------------

require("init")

points = config.points
rangecolors = config.rangecolors

ret,result = showUI("ui.json")

if ret == 1 then
	sysLog("确定")
else
    sysLog("取消")
	return
end

--for k,v in pairs(result) do
--	 print(k..":"..v)
--end

--mSleep(3000)
--if true then return  end

--主页面->冒险之旅
click(points.mainRisk,sleepTime)
--冒险模式
click(points.riskTrip,sleepTime)
--冒险->挑战
click(points.riskMiddleGo,sleepTime)

--找到魔女步骤：1、点击3次箭头，2、点击第3条目，3、顺序点击普通，精英，大师，4、下一步
--点击3次箭头
click(points.challengeUpBtn,100,3)
--点击第3条目
click(points.challengeItem3)
--顺序点击普通，精英，大师
--todo  是否需要这样？？？是否可以检测是否有大师级别
click(points.challengeLevel1)
click(points.challengeLevel2)
click(points.challengeLevel3)
--下一步
click(points.challengeNextStep)


--开始循环闯关
while true do

	--判断是否选够英雄
	--如果选够，直接点击闯关
	--如果没选够，点击更换阵容，在选择英雄界面检查第三个英雄是否已经选择，选3个英雄
	findThen(rangecolors.challengeDetailNoHero.range,rangecolors.challengeDetailNoHero.color,
		function (x,y)
			if x > -1 then
				sysLog("没选够3个英雄")
				--点击更换阵容
				click(points.challengeDetailChangeTeam,800)
				--在选择英雄界面检查第三个英雄是否已经选择
				findThen(rangecolors.pickHeroNoHero3.range,rangecolors.pickHeroNoHero3.color,
					function(x,y)
						if x > -1 then
							--选3个英雄
							click(points.pickHeroPos1,100)
							click(points.pickHeroPos2,100)
							click(points.pickHeroPos3,100)
							--点击确定开始
							click(points.pickHeroGo)
							return true
						end
					end)
			else
				sysLog("选够3个英雄")
				--点击闯关
				click(points.challengeDetailGo)
			end
			return true
		end
	)

	--加载页面
	findThen(rangecolors.loading100.range,rangecolors.loading100.color,
		function(x,y)
			if x > -1 then
				sysLog(" 加载即将结束")
				return true
			end
		end
	)
	
	--先判断是否已经在战斗中，然后判断是否开了自动，没开自动需要点击自动
	findThen(rangecolors.monvIsInFighting.range,rangecolors.monvIsInFighting.color,
		function(x,y)
			if x > -1 then
				findThen(rangecolors.monvIsAuto.range,rangecolors.monvIsAuto.color,
					function(x,y)
						if x > -1 then
							sysLog("已经开启自动")
						else
							sysLog("点击自动")
							click(points.fightingAuto)
						end
						return true
					end
				)
				return true
			else
				return false
			end
		end
	)

	--点击2次跳过
	local clickNextCount = 0
	findThen(rangecolors.monvInFightingSkip.range,rangecolors.monvInFightingSkip.color,
		function(x,y)
			if x > -1 then
				click(points.fightingSkip)
				sysLog("click 跳过")
				clickNextCount = clickNextCount + 1
				if clickNextCount == 2 then
					clickNextCount = 0
					return true
				end
			end
		end
	)

	--检查结束页面
	local fightResult = true
	while true do
		--前3个是挑战成功的条目（任意完成一个），黄色的字，第4个是下面的白色字，前3个或和第四个与
		successP1 = findColors(rangecolors.fightResultSuccessPoint1.range,rangecolors.fightResultSuccessPoint1.color,95, 0, 0, 0)
		successP2 = findColors(rangecolors.fightResultSuccessPoint2.range,rangecolors.fightResultSuccessPoint2.color,95, 0, 0, 0)
		successP3= findColors(rangecolors.fightResultSuccessPoint3.range,rangecolors.fightResultSuccessPoint3.color,95, 0, 0, 0)
		successP4 = findColors(rangecolors.fightResultSuccessPoint4.range,rangecolors.fightResultSuccessPoint4.color,95, 0, 0, 0)
		if (#successP1~= 0 or #successP2 ~= 0 or #successP3 ~= 0) and  #successP4 ~= 0 then
			sysLog("成功结果页面")
			--随机点击一个点跳过
			click(math.random(400),math.random(400))
			fightResult = true
			break
		else
			failedP1 = findColors(rangecolors.fightResultFailedPoint1.range,rangecolors.fightResultFailedPoint1.color,95, 0, 0, 0)
			failedP2 = findColors(rangecolors.fightResultFailedPoint2.range,rangecolors.fightResultFailedPoint2.color,95, 0, 0, 0)
			failedP3 = findColors(rangecolors.fightResultFailedPoint3.range,rangecolors.fightResultFailedPoint3.color,95, 0, 0, 0)
			if #failedP1~= 0 and #failedP2 ~= 0 and #failedP3 ~= 0 then
				sysLog("失败结果页面")
				click(points.faghtFailedBack)
				fightResult = false
				break
			end
		end
	end
	
	--成功，随便点击一个点，然后开始检查是否有+号，然后点击再次挑战，从头循环
	--失败，点击页面上的返回到挑战选关卡页面了，点击下一步
	if fightResult then
		--先判断是否已经在奖励页面，避免在页面切换中判断是否有+号
		while true do
			resultSuccessBack= findColors(rangecolors.resultSuccessBack.range,rangecolors.resultSuccessBack.color,95, 0, 0, 0)
			resultSuccessFightAgain= findColors(rangecolors.resultSuccessFightAgain.range,rangecolors.resultSuccessFightAgain.color,95, 0, 0, 0)
			if #resultSuccessBack~= 0 and #resultSuccessFightAgain ~= 0 then
				findThen(rangecolors.resultSuccessGoldLimit.range,rangecolors.resultSuccessGoldLimit.color,
					function(x,y)
						if x > -1 then
							--金币还没上限，再次挑战  challengeAgain
							sysLog("+++")
							click(points.resultSuccessFightAgain)
							return true
						else
							--金币上限，退出脚本
							sysLog("no +++")
							lua_exit()
						end
					end
				)
				break
			end
		end
	else
		--点击下一步
		while true do
			upBtnPoint= findColors(rangecolors.challengeUpBtn.range,rangecolors.challengeUpBtn.color,95, 0, 0, 0)
			downBtnPoint = findColors(rangecolors.challengeDownBtn.range,rangecolors.challengeDownBtn.color,95, 0, 0, 0)
			if #upBtnPoint~= 0 and #downBtnPoint ~= 0 then
				click(points.challengeNextStep)
			end
		end
	end



end