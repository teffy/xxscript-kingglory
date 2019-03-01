--------------------------------
--游戏色彩和点击位置配置
--------------------------------

local configJson = [[


{
  "rangecolors": {
    "challengeDetailNoHero": {
      "range": [
        1859,
        775,
        2043,
        964
      ],
      "color": "0|0|0x151425,9|24|0x161525"
    },
    "pickHeroNoHero1": {
      "range": [
        2323,
        169,
        2394,
        248
      ],
      "color": "0|0|0x5071a3"
    },
    "pickHeroNoHero2": {
      "range": [
        2325,
        404,
        2393,
        487
      ],
      "color": "0|0|0x5071a3"
    },
    "pickHeroNoHero3": {
      "range": [
        2312,
        638,
        2405,
        736
      ],
      "color": "0|0|0x5071a3"
    },
    "loading100": {
      "range": [
        1938,
        1381,
        1955,
        1390
      ],
      "color": "0|0|0x5caae1"
    },
    "monvIsAuto": {
      "range": [
        2311,
        98,
        2363,
        122
      ],
      "color": "0|0|0x1a5c9e,17|1|0x1a5c9e,6|10|0x1a5c9e"
    },
    "monvIsInFighting": {
      "range": [
        2357,
        167,
        2363,
        203
      ],
      "color": "0|0|0x51bcec"
    },
    "monvInFightingSkip": {
      "range": [
        2432,
        1292,
        2457,
        1313
      ],
      "color": "0|0|0x02bfff"
    },
    "fightResultSuccessPoint1": {
      "range": [
        858,
        1058,
        1107,
        1099
      ],
      "color": "0|0|0xf0bf2d"
    },
    "fightResultSuccessPoint2": {
      "range": [
        858,
        700,
        1301,
        745
      ],
      "color": "0|0|0xf0bf2d"
    },
    "fightResultSuccessPoint3": {
      "range": [
        861,
        878,
        1288,
        922
      ],
      "color": "0|0|0xf0bf2d"
    },
    "fightResultSuccessPoint4": {
      "range": [
        1173,
        1262,
        1224,
        1313
      ],
      "color": "0|0|0xffffff"
    },
    "fightResultFailedPoint1": {
      "range": [
        675,
        532,
        744,
        599
      ],
      "color": "0|0|0xffffff"
    },
    "fightResultFailedPoint2": {
      "range": [
        1254,
        537,
        1318,
        597
      ],
      "color": "0|0|0xffffff"
    },
    "fightResultFailedPoint3": {
      "range": [
        1229,
        1296,
        1333,
        1344
      ],
      "color": "0|0|0xffffff"
    },
    "challengeUpBtn": {
      "range": [
        568,
        231,
        710,
        287
      ],
      "color": "0|0|0x02bfff"
    },
    "challengeDownBtn": {
      "range": [
        575,
        1282,
        707,
        1333
      ],
      "color": "0|0|0x02bfff"
    },
    "resultSuccessBack": {
      "range": [
        1745,
        1301,
        1799,
        1348
      ],
      "color": "0|0|0xffffff"
    },
    "resultSuccessFightAgain": {
      "range": [
        2070,
        1301,
        2281,
        1347
      ],
      "color": "0|0|0xffffff"
    },
    "resultSuccessGoldLimit": {
      "range": [
        1915,
        771,
        1972,
        831
      ],
      "color": "0|0|0xeeecce"
    }
  },
  "points": {
    "mainRisk": {
      "x": 1998,
      "y": 1045
    },
    "riskTrip": {
      "x": 1500,
      "y": 752
    },
    "riskMiddleGo": {
      "x": 1231,
      "y": 1058
    },
    "challengeUpBtn": {
      "x": 634,
      "y": 254
    },
    "challengeDownBtn": {
      "x": 631,
      "y": 1303
    },
    "challengeMonv": {
      "x": 1154,
      "y": 604
    },
    "challengeItem1": {
      "x": 1105,
      "y": 350
    },
    "challengeItem2": {
      "x": 1105,
      "y": 480
    },
    "challengeItem3": {
      "x": 1105,
      "y": 620
    },
    "challengeItem4": {
      "x": 1105,
      "y": 750
    },
    "challengeLevel1": {
      "x": 1946,
      "y": 398
    },
    "challengeLevel2": {
      "x": 1963,
      "y": 647
    },
    "challengeLevel3": {
      "x": 1960,
      "y": 898
    },
    "challengeNextStep": {
      "x": 1947,
      "y": 1201
    },
    "challengeDetailChangeTeam": {
      "x": 1455,
      "y": 1157
    },
    "challengeDetailGo": {
      "x": 1868,
      "y": 1142
    },
    "pickHeroPos1": {
      "x": 127,
      "y": 234
    },
    "pickHeroPos2": {
      "x": 127,
      "y": 512
    },
    "pickHeroPos3": {
      "x": 127,
      "y": 775
    },
    "pickHeroExpandGrid": {
      "x": 515,
      "y": 720
    },
    "pickHeroExpandAll": {
      "x": 113,
      "y": 50
    },
    "pickHeroExpandTank": {
      "x": 459,
      "y": 50
    },
    "pickHeroExpandWarrior": {
      "x": 765,
      "y": 50
    },
    "pickHeroExpandAssassin": {
      "x": 1069,
      "y": 50
    },
    "pickHeroExpandMage": {
      "x": 1380,
      "y": 50
    },
    "pickHeroExpandShooter": {
      "x": 1688,
      "y": 50
    },
    "pickHeroExpandAuxiliary": {
      "x": 2006,
      "y": 50
    },
    "pickHeroGo": {
      "x": 2332,
      "y": 1353
    },
    "fightingAuto": {
      "x": 2359,
      "y": 52
    },
    "fightingSkip": {
      "x": 2502,
      "y": 45
    },
    "faghtFailedBack": {
      "x": 1255,
      "y": 1314
    },
    "resultSuccessBack": {
      "x": 2120,
      "y": 1306
    },
    "resultSuccessFightAgain": {
      "x": 2120,
      "y": 1306
    }
  }
}


]]

JSON = require("JSON")
local config = JSON:decode(configJson)

function uiAdapt(config)
	defaultW = 1440
	defaultH = 2560
--	deviceW, deviceH= getScreenSize()
	deviceW, deviceH=  1080,1920
	scaleW = deviceW / defaultW
	scaleH = deviceH / defaultH
	print(scaleH)
	for k,v in pairs(config.points) do
		item = v
		item.x = item.x * scaleW
		item.y = item.y* scaleH
	end
	
	for k,v in pairs(config.rangecolors) do
		range = v.range
		for j=1,#range do
				if j % 2 == 1 then
					range[j] = range[j] * scaleW
				else
					range[j] = range[j] * scaleH
				end
		end
    end
end

uiAdapt(config)

for k,v in pairs(config.points) do
	for m,n in pairs(v) do
		print(m..n)
	end
end

--return config


