



local flg,error_code = pcall(function()
    print("WARNING:PCALL START +++++++++++++++++++++++++++++++++++++++++++++++++")
    local x,y,z =    ThePlayer.Transform:GetWorldPosition()
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
        local inst = TheSim:FindFirstEntityWithTag("miraculous_machine_secret_scroll")
        -- if inst then
        --     -- inst.components.miraculous_machine_secret_scroll:Set("test",true)
        --     -- print(inst,inst.replica.miraculous_machine_secret_scroll:Get("type"))
        --     inst:PushEvent("switch.bugnet.start")
        -- end
        -- inst:PushEvent("switch.bugnet.start")

    -----------------------------------------------------------------------------------------------------------------------------------------------------------------



    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))




