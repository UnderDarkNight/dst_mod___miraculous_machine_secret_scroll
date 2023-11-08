----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 模式切换器
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        function inst:TypeSwitchByCooldown(weapon_type)
            if self.target_type == weapon_type then
                return
            end            
            self.target_type = weapon_type
            local current_type = inst.components.miraculous_machine_secret_scroll:Get("type") or "..."
            self:PushEvent(current_type..".stop")
            self:DoTaskInTime(0.5,function()
                inst:PushEvent(weapon_type..".start")
                self.target_type = nil
                print("info switch 2 ",weapon_type)
            end)
        end

        inst:ListenForEvent("key_up",function(_,key)    ------ RPC 回传的 玩家按键监听. A - Z     F1 - F12
            -- print("info weapon switch key up",key)

            if key == KEY_F1 then
                inst:TypeSwitchByCooldown("switch.orange_staff")
            elseif key == KEY_F3 then
                inst:TypeSwitchByCooldown("switch.purple_staff")
            end



        end)




    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        
    end
    -----------------------------------------------------------------------------------------------------------------
}