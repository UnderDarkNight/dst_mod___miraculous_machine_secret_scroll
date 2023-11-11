----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 远程武器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

            local function SetOnProjectileLaunch(inst, attacker, target)     -- 子弹发射 前
                print("SetOnProjectileLaunch",attacker,target)                
            end
            local function OnProjectileLaunched(inst, attacker, target)     -- 子弹发射 后
                print("OnProjectileLaunched",attacker,target)                
            end

            inst:ListenForEvent("switch.long_range_weapon.start",function()
                if inst:HasTag("switch.long_range_weapon") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.long_range_weapon")
                print("info long_range_weapon on")
                -----------------------------------------------------------------------------
                    inst:AddTag("rangedweapon")
                    inst:AddTag("slingshot")
                    inst:AddTag("weapon")
                    inst.components.weapon:SetDamage(0)
                    inst.components.weapon:SetRange(TUNING.SLINGSHOT_DISTANCE, TUNING.SLINGSHOT_DISTANCE_MAX)
                    inst.components.weapon:SetOnProjectileLaunch(SetOnProjectileLaunch)    --- 子弹发射前
                    inst.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched)    --- 子弹发射后
                    inst.components.weapon:SetProjectile("bishop_charge")   --- 弹药的prefab
                    inst.components.weapon:SetProjectileOffset(1)
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.long_range_weapon.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.long_range_weapon")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.long_range_weapon.stop",function()
                if not inst:HasTag("switch.long_range_weapon") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.long_range_weapon")
                print("info long_range_weapon off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("rangedweapon")
                    inst:RemoveTag("slingshot")
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.long_range_weapon.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.long_range_weapon.start.replica",function()
            print("switch.long_range_weapon.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.long_range_weapon")
        end)
        inst:ListenForEvent("switch.long_range_weapon.stop.replica",function()
            print("switch.long_range_weapon.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}