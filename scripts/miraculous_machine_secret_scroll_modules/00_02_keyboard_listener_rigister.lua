----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 键盘监听
---- 通过 RPC 上传数据
---- TheInput:AddKeyHandler 会以30FPS扫描键盘
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        if not TheWorld.ismastersim then
            return
        end

        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                inst:DoTaskInTime(0,function()
                    inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("start_keyboard_listener",_table.owner.userid)
                end)

            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("stop_keyboard_listener",_table.owner.userid)
            end
        end)

        -- inst:ListenForEvent("key_up",function(_,key) 
        --     print("info weapon switch key up",key)

        --     if key == KEY_F1 then
        --         inst:PushEvent("switch.orange_staff.start")
        --     elseif key == KEY_F3 then
        --         inst:PushEvent("switch.orange_staff.stop")
        --     end

        -- end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        local key_event_fn = require("miraculous_machine_secret_scroll_modules/00_03_key_events") or function(...) print(...) end

        inst:ListenForEvent("start_keyboard_listener",function(_,userid)
            -- print("start_keyboard_listener",userid)
            if userid and ThePlayer and ThePlayer.userid == userid then
                inst.__key_handler = TheInput:AddKeyHandler(function(key,down)  ------ 30FPS
                    -- print("test 6666666",key,down)
                    key_event_fn(inst,key,down)
                end)
            end
        end)
        inst:ListenForEvent("stop_keyboard_listener",function(_,userid)
            -- print("stop_keyboard_listener",userid)
            if userid and ThePlayer and ThePlayer.userid == userid then
                if inst.__key_handler then
                    inst.__key_handler:Remove()
                    inst.__key_handler = nil
                end
            end
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}