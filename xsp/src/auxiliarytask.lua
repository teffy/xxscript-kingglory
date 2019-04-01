
function work()
    local co = coroutine.create(function() 
        while true do 
            print('hi')
        end
    end)
    --print(co)
    print(coroutine.status(co))
    coroutine.resume(co)
    print(coroutine.status(co))

    print(12344)
end

work()
