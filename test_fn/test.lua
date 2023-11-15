



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
            -- -- for k, v in pairs(ThePlayer.HUD.children) do
            -- --     print(k,v)
            -- -- end
            -- -- -- ThePlayer.HUD.mapcontrols.minimapBtn.onclick()
            -- -- ThePlayer.HUD.controls:HideMap()
            -- local map = TheFrontEnd:GetOpenScreenOfType("MapScreen")
            -- map:Hide()
            -- TheFrontEnd:PopScreen(map)
            -- -- if map ~= nil and ThePlayer.HUD.controls ~= nil then
                
            -- -- end

            -- -- ThePlayer.HUD.controls:HideMap()
            -- -- ThePlayer.HUD.controls:ShowMap(Vector3(0,0,0))
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
                --[[
                    png 序号。其余透明
                    4 : 网
                    5 : 网
                    8 ：网
                    6 ：无网 杆
                    2 : idle 的时候显示
                ]]--
                ThePlayer.sg:Stop()
                local scale = 2
                ThePlayer.AnimState:SetScale(scale, scale, scale)
                -- ThePlayer.AnimState:OverrideSymbol("swap_object", "mms_scroll_bugnet_red", "swap_bugnet")
                ThePlayer.AnimState:OverrideSymbol("swap_object", "mms_scroll_bugnet_blue", "swap_bugnet")
                ThePlayer.AnimState:SetDeltaTimeMultiplier(0.2)
                -- ThePlayer.AnimState:SetDeltaTimeMultiplier(1)
                ThePlayer.AnimState:PlayAnimation("bugnet_pre")
                ThePlayer.AnimState:PushAnimation("bugnet")
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))




