--------------------------------
--重定义 print sysLog，可以打印table
--------------------------------

oldPrint = print
print = function(t)
		local printCache={}
		local function subPrint(t,indent)
			if (printCache[tostring(t)]) then
			 oldPrint(indent.."*"..tostring(t))
			else
				printCache[tostring(t)]=true
				if (type(t)=="table") then
					for pos,val in pairs(t) do
						if (type(val)=="table") then
						 	oldPrint(indent.."["..pos.."] => "..tostring(t).." {")
							subPrint(val,indent..string.rep(" ",string.len(pos)+8))
						 	oldPrint(indent..string.rep(" ",string.len(pos)+6).."}")
						elseif (type(val)=="string") then
						 	oldPrint(indent.."["..pos..'] => "'..val..'"')
						else
						 	oldPrint(indent.."["..pos.."] => "..tostring(val))
						end
					end
				else
				 	oldPrint(indent..tostring(t))
				end
			end
		end
		if (type(t)=="table") then
			oldPrint(tostring(t).." {")
		 	subPrint(t,"  ")
		 	oldPrint("}")
		else
			subPrint(t,"  ")
		end
	 oldPrint()
	end