



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
                -- ThePlayer.sg:Stop()
                -- local scale = 2
                -- ThePlayer.AnimState:SetScale(scale, scale, scale)
                -- -- ThePlayer.AnimState:OverrideSymbol("swap_object", "mms_scroll_bugnet_red", "swap_bugnet")
                -- ThePlayer.AnimState:OverrideSymbol("swap_object", "mms_scroll_bugnet_blue", "swap_bugnet")
                -- ThePlayer.AnimState:SetDeltaTimeMultiplier(0.2)
                -- -- ThePlayer.AnimState:SetDeltaTimeMultiplier(1)
                -- ThePlayer.AnimState:PlayAnimation("bugnet_pre")
                -- ThePlayer.AnimState:PushAnimation("bugnet")
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
                -- local cmd_table = {
                --     ["button_blink_map"] = { x = 0, y = 200 },

                --     ["button_bow"] = { x = 100, y = 100 },

                --     ["button_sword"] = { x = -100, y = 100 },

                --     ["button_tools"] = { x = 0, y = -10 },

                    
                --     ["button_goggle"] = { x = -300, y = -180 },
                --     ["button_music"] = { x = -150, y = -180 },
                --     ["button_orange"] = { x = 0, y = -180 },
                --     ["button_razor"] = { x = 150, y = -180 },
                --     ["button_trident"] = { x = 300, y = -180 },


                --     ["button_water_run"] = { x = -300, y = 180 },
                --     ["button_light"] = { x = -300, y = 0 },

                --     ["button_fishingrod"] = { x = 300, y = 180 },
                --     ["button_bugnet"] = { x = 300, y = 0 },
                    

                -- }
                -- ThePlayer.HUD:mms_scroll_switch_widget_open(nil,cmd_table)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
                SpawnPrefab("mms_scroll_snow_spriter"):PushEvent("Set",{player = ThePlayer})
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))