VERSION='0.0.29'
-- debug?打印log
T = true
F = false
DEBUG=T
WRITELOG=F
-- 给用户测试,显示点击坐标红点
FOR_TEST_SHOW_POINT=DEBUG
-- 给用户测试,显示点击找色范围
FOR_TEST_SHOW_FRAME=DEBUG
-- 给用户测试
FOR_TEST=DEBUG
-- 点击坐标点和找色范围显示时长
RED_TIPFLAG_SHOW_TIME=1000
IS_VIP=F

APP_PACKAGE_NAME = 'com.tencent.tmgp.sgame'

if WRITELOG then 
    setSysConfig("isLogFile","1")
end
--todo list
--检测当前页面
--UI 桌面编辑工具直接生成代码
--检测用户是否有点券，然后提示他买卡


-- 自动检测用户手机性能？？？

-- 1、处理下有休息眼睛提示和，链接中断的情况
-- 2、自动定位当前页面是啥，自动去挑战
-- 3、挑战增加关卡
-- 4、六国
-- 5、武道
-- 6、日之塔
-- 7、最简单人机
-- 8、日常喊话
-- 9、一键换装

