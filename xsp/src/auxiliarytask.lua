
function work(sampling_adapter_data)

    local sleepTime = 500
    local deviceW, deviceH = getScreenSize()
    local points = sampling_adapter_data.points
    local rangecolors = sampling_adapter_data.rangecolors

    local clickNextCount = 0
        findThen(
            rangecolors.fighting_is_skip_showing.range,
            rangecolors.fighting_is_skip_showing.color,
            function(x, y)
                if x > -1 then
                    click(points.fighting_skip,{sleepAfter=1000})
                    sysLog("click 跳过")
                    clickNextCount = clickNextCount + 1
                    if clickNextCount == 2 then
                        clickNextCount = 0
                        return true
                    end
                end
            end
        )
    local co = coroutine.create(function() 
        while true do 
            print('hi')
        end
    end)
    --print(co)
    print(coroutine.status(co))
    coroutine.resume(co)
    print(coroutine.status(co))

    
end

work(sampling_adapter_data)

