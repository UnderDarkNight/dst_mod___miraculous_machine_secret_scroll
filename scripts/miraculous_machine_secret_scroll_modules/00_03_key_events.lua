----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 键盘监听和执行
---- 会以 30FPS 轮询，注意处理
---- 按键宏列表在  constants.lua  里
--[[
    KEY_A = 97
    KEY_B = 98
    KEY_C = 99
    KEY_D = 100
    KEY_E = 101
    KEY_F = 102
    KEY_G = 103
    KEY_H = 104
    KEY_I = 105
    KEY_J = 106
    KEY_K = 107
    KEY_L = 108
    KEY_M = 109
    KEY_N = 110
    KEY_O = 111
    KEY_P = 112
    KEY_Q = 113
    KEY_R = 114
    KEY_S = 115
    KEY_T = 116
    KEY_U = 117
    KEY_V = 118
    KEY_W = 119
    KEY_X = 120
    KEY_Y = 121
    KEY_Z = 122
    KEY_F1 = 282
    KEY_F2 = 283
    KEY_F3 = 284
    KEY_F4 = 285
    KEY_F5 = 286
    KEY_F6 = 287
    KEY_F7 = 288
    KEY_F8 = 289
    KEY_F9 = 290
    KEY_F10 = 291
    KEY_F11 = 292
    KEY_F12 = 293
]]
----------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst,key,down)
    -- print("test 6666666",key,down)
    -----------------------------------------------------------------------------------------------------------------------------------
    local cmd_table = {
        ["button_blink_map"] = { x = 0, y = 200 ,click_fn = function()
            print("button_blink_map")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.blink_map")
        end},

        ["button_bow"] = { x = 100, y = 100 ,click_fn = function()
            print("button_bow")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.long_range_weapon")
        end},

        ["button_sword"] = { x = -100, y = 100 ,click_fn = function()
            print("button_sword")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.short_range_weapon")
        end},

        ["button_tools"] = { x = 0, y = -10 ,click_fn = function()
            print("button_tools")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.tools")

        end},

        
        ["button_goggle"] = { x = -300, y = -180 ,click_fn = function()
            print("button_goggle")
            -- inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.goggles_switch","__")
        end},
        ["button_music"] = { x = -150, y = -180 ,click_fn = function()
            print("button_music")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.music")

        end},
        ["button_orange"] = { x = 0, y = -180 ,click_fn = function()
            print("button_orange")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.orange_staff")
        end},
        ["button_razor"] = { x = 150, y = -180 ,click_fn = function()
            print("button_razor")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.razor")

        end},
        ["button_trident"] = { x = 300, y = -180 ,click_fn = function()
            print("button_trident")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.trident")
        end},


        ["button_water_run"] = { x = -300, y = 180 ,click_fn = function()
            print("button_water_run")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.ocean_walking_switch","__")
        end},
        ["button_light"] = { x = -300, y = 0 ,click_fn = function()
            print("button_light")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("func.light_switch","__")

        end},

        ["button_fishingrod"] = { x = 300, y = 180 ,click_fn = function()
            print("button_fishingrod")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.fishingrod")
        end},
        ["button_bugnet"] = { x = 300, y = 0 ,click_fn = function()
            print("button_bugnet")
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("type_switch","switch.bugnet")
        end},
        

    }
    -----------------------------------------------------------------------------------------------------------------------------------
    -- if not down and (  (key >= KEY_A and key <= KEY_Z) or (key >= KEY_F1 and key <= KEY_F12)  ) then    --- 按键抬起
    --     -- print("key up",key)
    --     pcall(function()
    --         -- inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("key_up",key)   
    --         if ThePlayer then
    --             ThePlayer.HUD:mms_scroll_switch_widget_open(nil,cmd_table)
    --         end
    --     end)
    -- end
    if not down and key == KEY_F1  then    --- 按键抬起
        -- print("key up",key)
        pcall(function()
            -- inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("key_up",key)   
            if ThePlayer then
                ThePlayer.HUD:mms_scroll_switch_widget_open(nil,cmd_table)
            end
        end)
    end
end