--require "init"

init("0", 1)
w,h=getScreenSize()--获取当前分辨率
sysLog(w..","..h)

ret,result = showUI("ui.json")

if ret == 1 then
	sysLog("confirm")
elseif ret == 0 then
	sysLog("cancel")
	return
else
    sysLog("nothing")
end

for k,v in pairs(result) do
	 print(k..":"..v)
end

--测试
--if true then
--	return
--end

--todo  方法封装，
--检测当前页面，
--选择关卡，选择英雄
--home左右适配，分辨率适配，
--UI悬浮记录次数，获取多少金币
--UI 桌面编辑工具直接生成代码

function click(x,y)
	touchDown(1,x,y)
	mSleep(50)
	touchUp(1,x,y)
	mSleep(500)
end

--冒险之旅
x, y = findColor({1895, 1015, 2126, 1072}, 
{
	{x=0,y=0,color=0xf1f7fc},
	{x=50,y=0,color=0xe8eff5},
	{x=141,y=-21,color=0xe2eef9},
	{x=175,y=-14,color=0xe7f1fa}
},
95, 0, 0, 0)
if x > -1 then
	click(x,y)
end


--冒险模式
x, y = findColor({1430, 1082, 1686, 1214}, 
{
	{x=0,y=0,color=0x60b3c4},
	{x=77,y=40,color=0x59dced},
	{x=129,y=35,color=0x62eafb}
},
95, 0, 0, 0)
if x > -1 then
	click(x,y)
end

--冒险
x, y = findColor({1037, 1005, 1524, 1150}, 
{
	{x=0,y=0,color=0x223147},
	{x=202,y=53,color=0xdef1fc},
	{x=269,y=66,color=0xfbfdfe}
},
95, 0, 0, 0)
if x > -1 then
   click(x,y)
end

--挑战
x, y = findColor({1894, 829, 2044, 978}, 
{
	{x=0,y=0,color=0xffffff},
	{x=-4,y=53,color=0xf6c1c1},
	{x=-6,y=103,color=0xbf0a0a}
},
95, 0, 0, 0)
if x > -1 then
	click(x,y)
end

--找到魔女
--点击3次箭头
x, y = findColor({569, 236, 710, 286}, 
"0|0|0x02bfff,36|-15|0x02bffd,72|1|0x02bfff",
95, 0, 0, 0)
if x > -1 then
	click(x,y)
	click(x,y)
	click(x,y)
else
	sysLog(x..","..y)
end

--点击魔女
--1121,614,1329,643
click(1121,614)
--点击大师
--1962,896,2007,924
click(1962,896)

--下一步
x, y = findColor({1862, 1182, 2141, 1267}, 
{
	{x=0,y=0,color=0xddeffb},
	{x=43,y=-1,color=0x94b5cd},
	{x=115,y=-2,color=0xacc6dd}
},
95, 0, 0, 0)
if x > -1 then
	click(x,y)
end


--if true then
--	return
--end

while true do


--判断英雄是否选够
x, y =  findColor({1869, 786, 2030, 935}, 
"0|0|0x111323,15|11|0x111323,43|24|0x121323",
97, 0, 0, 0)
if x > -1 then
	sysLog("英雄没选够3个")
	--点击更换阵容
	click(1444,1156)
	
	--检测在选择英雄界面第三个英雄是否已经选择，判断?号
	while true do
		x, y = findColor({2312, 638, 2405, 736}, 
		"0|0|0x5071a3,38|6|0x5071a3,16|29|0x5071a3",
		95, 0, 0, 0)
		if x > -1 then
			--选3个英雄
			click(111,241)
			click(369,268)
			click(73,475)
		else
			--点击确定
			click(2293,1343)
			break
		end
	end
	
else --如果英雄选够了，直接点击闯关
	sysLog("英雄选够3个")
	--闯关，需要while循环，因为页面切换有可能卡
	while true do
		x, y = findColor({1732, 1101, 2099, 1228}, 
		{
			{x=0,y=0,color=0x6a5130},
			{x=112,y=27,color=0xf9f8f6},
			{x=178,y=26,color=0xffffff},
			{x=269,y=65,color=0x967544}
		},
		95, 0, 0, 0)
		if x > -1 then
			click(x,y)
			break
		end
	end

end




--loading
while true do
	x, y = findColor({1864, 1377, 1941, 1391}, 
{
	{x=0,y=0,color=0x61aee4},
	{x=-9,y=-2,color=0x60ade3}
},
95, 0, 0, 0)
if x > -1 then
	sysLog(" loading finished")
	break
end
end

--点击自动
click(2339, 38)

--点击2次跳过
local clickNextCount = 0
while true do
	x, y = findColor({2367, 23, 2535, 96}, 
	{
		{x=0,y=0,color=0x162f48},
		{x=31,y=-2,color=0xd0e2ef},
		{x=97,y=-4,color=0xddeffb}
	},
	95, 0, 0, 0)
	if x > -1 then
		click(x,y)
		clickNextCount = clickNextCount + 1
		if clickNextCount == 2 then
			clickNextCount = 0
			break
		end
	end
end

while true do
	x, y = findColor({930, 318, 1639, 549}, 
	{
		{x=0,y=0,color=0x3e78ba},
		{x=135,y=31,color=0xdfa615},
		{x=170,y=99,color=0x4793dd},
		{x=403,y=-27,color=0xe9b71a},
		{x=422,y=94,color=0x4799e3},
		{x=453,y=43,color=0xcf9519}
	},
	95, 0, 0, 0)
	if x > -1 then
		sysLog("结果页面")
		break
	end
end

--判断是否有+号
while true do
	x, y = findColor({648, 637, 1374, 1154}, 
	{
		{x=0,y=0,color=0xefbf2d},
		{x=-13,y=172,color=0xd7ac2d},
		{x=-7,y=358,color=0xf0bf2d}
	},
	95, 0, 0, 0)
	if x > -1 then
		sysLog("+++")
		click(x,y)
		break
	end
end

--再次挑战
while true do
	x, y = findColor({2067, 1303, 2299, 1349}, 
	{
		{x=0,y=0,color=0xffffff},
		{x=61,y=5,color=0xffffff}
	},
	95, 0, 0, 0)
	if x > -1 then
		click(x,y)
		break
	end
end

end