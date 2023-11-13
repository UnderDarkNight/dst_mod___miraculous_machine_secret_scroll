



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
            -- for k, v in pairs(ThePlayer.HUD.children) do
            --     print(k,v)
            -- end
            -- -- ThePlayer.HUD.mapcontrols.minimapBtn.onclick()
            -- ThePlayer.HUD.controls:HideMap()
            local map = TheFrontEnd:GetOpenScreenOfType("MapScreen")
            map:Hide()
            TheFrontEnd:PopScreen(map)
            -- if map ~= nil and ThePlayer.HUD.controls ~= nil then
                
            -- end

            -- ThePlayer.HUD.controls:HideMap()
            -- ThePlayer.HUD.controls:ShowMap(Vector3(0,0,0))
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))




