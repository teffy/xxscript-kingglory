------------------------------------------------------------
--@desc 初始化和适配游戏坐标数据
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
JSON = require("tflibs.JSON")

--@desc 适配游戏坐标数据
--@param json 文件名
--@param scaleW 宽缩放比
--@param scaleH 高缩放比
--@return json文件转为table,经过缩放比处理,返回这个table
function calculate_coordinate(json, scaleW, scaleH)
	local coordinate_data_json = getUIContent(json)
	local coordinate_table = JSON:decode(coordinate_data_json)
	for k, v in pairs(coordinate_table.points) do
		item = v
		item.x = item.x * scaleW
		item.y = item.y * scaleH
	end

	for k, v in pairs(coordinate_table.rangecolors) do
		range = v.range
		for j = 1, #range do
			if j % 2 == 1 then
				range[j] = range[j] * scaleW
			else
				range[j] = range[j] * scaleH
			end
		end
	end
	return coordinate_table
end

return calculate_coordinate
