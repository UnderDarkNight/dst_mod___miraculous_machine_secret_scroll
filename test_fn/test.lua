



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
                -- SpawnPrefab("mms_scroll_snow_spriter"):PushEvent("Set",{player = ThePlayer})
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
                -- local __transparency = 0
                -- inst.AnimState:SetMultColour(1, 1, 1, __transparency)
                -- inst.___SetMultColour_task = inst:DoPeriodicTask(FRAMES,function()
                --     __transparency = __transparency + 0.05  
                --     if __transparency > 1 then
                --         __transparency = 1
                --         inst.___SetMultColour_task:Cancel()
                --     end
                --     inst.AnimState:SetMultColour(1, 1, 1, __transparency)
                -- end)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
        -- local cmd_table = {
        --     ["button_blink_map"] = { 
        --         image = "blink_map.tex",
        --         x = 0, y = 0 ,click_fn = function()
        --         print("button_blink_map")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.blink_map")
        --     end},

        --     ["button_bow"] = { 
        --         image = "bow.tex",
        --         x = 100, y = 100 ,click_fn = function()
        --         print("button_bow")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.long_range_weapon")
        --     end},

        --     ["button_sword"] = { 
        --         image = "sword.tex",
        --         x = -100, y = 100 ,click_fn = function()
        --         print("button_sword")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.short_range_weapon")
        --     end},

        --     ["button_tools"] = { 
        --         image = "tools.tex",
        --         x = 0, y = 200 ,click_fn = function()
        --         print("button_tools")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.tools")

        --     end},

            
        --     ["button_goggles"] = { 
        --         image = "goggles.tex",
        --         x = -300, y = -155 ,click_fn = function()
        --         print("button_goggles")
        --         -- inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.goggles_switch","__")
        --     end},
        --         ["button_music"] = { 
        --             image = "music.tex",
        --             x = -150, y = -135 ,click_fn = function()
        --         print("button_music")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.music")

        --     end},
        --     ["button_orange"] = {
        --         image = "orangestaff.tex",
        --         x = 0, y = -130 ,click_fn = function()
        --         print("button_orange")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.orange_staff")
        --     end},
        --     ["button_razor"] = { 
        --         image = "razor.tex",
        --         x = 150, y = -135 ,click_fn = function()
        --         print("button_razor")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.razor")

        --     end},
        --     ["button_trident"] = { 
        --         image = "trident.tex",
        --         x = 300, y = -155 ,click_fn = function()
        --         print("button_trident")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.trident")
        --     end},


        --     ["button_water_run"] = { 
        --         image = "water_run.tex",
        --         x = -350, y = 180 ,click_fn = function()
        --         print("button_water_run")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.ocean_walking_switch","__")
        --     end},
        --     ["button_light"] = { 
        --         image = "light.tex",
        --         x = -325, y = 0 ,click_fn = function()
        --         print("button_light")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.light_switch","__")

        --     end},

        --     ["button_fishingrod"] = { 
        --         image = "fishingrod.tex",
        --         x = 350, y = 180 ,click_fn = function()
        --         print("button_fishingrod")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.fishingrod")
        --     end},
        --     ["button_bugnet"] = { 
        --         image = "bugnet.tex",
        --         x = 325, y = 0 ,click_fn = function()
        --         print("button_bugnet")
        --         inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.bugnet")
        --     end},
            

        -- }
        -- ThePlayer.HUD:mms_scroll_switch_widget_open(nil,cmd_table)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
        -- local dragonfly_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.dragonfly")
        -- print(dragonfly_num)
        -- inst.components.planardamage:SetBaseDamage(0)
        -- inst.components.miraculous_machine_secret_scroll:Set("boss.kill.antlion",5)

        -- inst.components.miraculous_machine_secret_scroll:Set("boss.kill.daywalker",1)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
            -- ThePlayer.HUD:mms_scroll_unlocked_widget_open(inst,275,-230)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
            -- for k, v in pairs(package.laoded) do
            --     print(k,v)
            -- end
            -- local ret = dofile(resolvefilepath("scripts/widgets/mms_scroll_unlock_widget_pages.lua"))
            -- print(ret)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
            -- inst:PushEvent("snow_spriter_unlock")
            ThePlayer.AnimState:OverrideSymbol("clipboard_prop", "player_notes", "clipboard_prop")
            ThePlayer.AnimState:OverrideSymbol("chalk", "player_notes", "chalk")
            ThePlayer.AnimState:PlayAnimation("notes_loop",true)
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))