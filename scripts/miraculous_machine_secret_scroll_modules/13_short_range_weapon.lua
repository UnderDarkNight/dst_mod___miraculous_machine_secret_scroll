----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 近战武器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

            local function weapon_level_changed_event_fn()
                local weapon_level = inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0)
                inst.components.weapon:SetDamage(45 + weapon_level*2 )


                local goldnugget_num = inst.components.miraculous_machine_secret_scroll:Add("goldnugget.num",0)
                local attack_range = 1 + goldnugget_num * 0.01
                inst.components.weapon.attackrange = attack_range
                inst.components.weapon.hitrange = attack_range

            end


            inst:ListenForEvent("switch.short_range_weapon.start",function()
                if inst:HasTag("switch.short_range_weapon") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.short_range_weapon")
                print("info short_range_weapon on")
                -----------------------------------------------------------------------------
                    inst:AddTag("weapon")
                    -- local attack_range = 1
                    -- local weapon_level = inst.components.miraculous_machine_secret_scroll:Get("weapon_level.num") or 0
                    -- inst.components.weapon:SetDamage(45 + weapon_level*2 )
                    -- inst.components.weapon.attackrange = attack_range
                    -- inst.components.weapon.hitrange = attack_range
                    weapon_level_changed_event_fn()

                    inst:ListenForEvent("weapon_level.changed",weapon_level_changed_event_fn)
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.short_range_weapon.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.short_range_weapon")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.short_range_weapon.stop",function()
                if not inst:HasTag("switch.short_range_weapon") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.short_range_weapon")
                print("info short_range_weapon off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                    inst:RemoveEventCallback("weapon_level.changed",weapon_level_changed_event_fn)
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.short_range_weapon.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.short_range_weapon.start.replica",function()
            print("switch.short_range_weapon.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.short_range_weapon")
        end)
        inst:ListenForEvent("switch.short_range_weapon.stop.replica",function()
            print("switch.short_range_weapon.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}