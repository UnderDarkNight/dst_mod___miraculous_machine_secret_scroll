----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 模式切换器
----------------------------------------------------------------------------------------------------------------------------------------------------------
local function forbid_type_switch(inst,weapon_type)
    if inst:HasTag("forbid_type_switch") then
        return true
    end
    if inst.components.fishingrod and inst.components.fishingrod:IsFishing() then
        return true
    end
    -----------------------------------------------------------------------
    -------- 根据玩家sg状态屏蔽切换
        local owner = inst.components.inventoryitem:GetGrandOwner()
        if owner and owner.sg  then

                        local sg_state_tags = {
                            ["working"] = true,
                            ["fishing"] = true,
                            ["busy"] = true,
                            ["doing"] = true,
                        }
                        for tag, flag in pairs(sg_state_tags) do
                            if owner.sg:HasStateTag(tag) then
                                return true
                            end
                        end
        end
    -----------------------------------------------------------------------
    return false
end
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        function inst:TypeSwitchByCooldown(weapon_type)

            if forbid_type_switch(inst,weapon_type) then  --- 禁止武器切换的状态
                return
            end

            if self.target_type == weapon_type then
                return
            end
            self.target_type = weapon_type
            local current_type = inst.components.miraculous_machine_secret_scroll:Get("type") or "..."

            if current_type == self.target_type then
                return
            end

            self:PushEvent(current_type..".stop")
            self:DoTaskInTime(0.5,function()
                inst:PushEvent(weapon_type..".start")
                self.target_type = nil
                -- print("info TypeSwitchByCooldown switch ",current_type,weapon_type)

                    local owner = inst.components.inventoryitem:GetGrandOwner()
                    if owner then
                        owner.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")
                        self:PushEvent("weapon_type_changed",{owner=owner})

                    end

            end)

        end

        ----------- 默认模式
        inst:DoTaskInTime(0.1,function()
            if inst.components.miraculous_machine_secret_scroll:Get("type") == nil then
                inst:TypeSwitchByCooldown("switch.short_range_weapon")
            end
        end)

        inst:ListenForEvent("key_up",function(_,key)    ------ RPC 回传的 玩家按键监听. A - Z     F1 - F12
            -- print("info weapon switch key up",key)

            if key == KEY_F1 then
                inst:TypeSwitchByCooldown("switch.orange_staff")
            elseif key == KEY_F3 then
                inst:TypeSwitchByCooldown("switch.purple_staff")
            elseif key == KEY_F4 then
                inst:TypeSwitchByCooldown("switch.fishingrod")
            elseif key == KEY_F5 then
                inst:TypeSwitchByCooldown("switch.blink_map")
            elseif key == KEY_F6 then
                inst:TypeSwitchByCooldown("switch.bugnet")
            elseif key == KEY_F7 then
                inst:TypeSwitchByCooldown("switch.trident")
            elseif key == KEY_F8 then
                inst:TypeSwitchByCooldown("switch.long_range_weapon")
            elseif key == KEY_F9 then
                inst:TypeSwitchByCooldown("switch.short_range_weapon")
            elseif key == KEY_F10 then
                inst:TypeSwitchByCooldown("switch.tools")
            end



        end)




    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        
    end
    -----------------------------------------------------------------------------------------------------------------
}