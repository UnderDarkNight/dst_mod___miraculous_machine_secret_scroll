----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 近战武器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
                local function onattack_blue(inst, attacker, target, skipsanity)
                    if not skipsanity and attacker ~= nil then
                        if attacker.components.staffsanity then
                            attacker.components.staffsanity:DoCastingDelta(-TUNING.SANITY_SUPERTINY)
                        elseif attacker.components.sanity ~= nil then
                            attacker.components.sanity:DoDelta(-TUNING.SANITY_SUPERTINY)
                        end
                    end
                
                    if inst.skin_sound then
                        attacker.SoundEmitter:PlaySound(inst.skin_sound)
                    end
                
                    if not target:IsValid() then
                        --target killed or removed in combat damage phase
                        return
                    end
                
                    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
                        target.components.sleeper:WakeUp()
                    end
                
                    if target.components.burnable ~= nil then
                        if target.components.burnable:IsBurning() then
                            target.components.burnable:Extinguish()
                        elseif target.components.burnable:IsSmoldering() then
                            target.components.burnable:SmotherSmolder()
                        end
                    end
                
                    if target.components.combat ~= nil then
                        target.components.combat:SuggestTarget(attacker)
                    end
                
                    if target.sg ~= nil and not target.sg:HasStateTag("frozen") then
                        target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
                    end
                
                    --V2C: valid check in case any of the previous callbacks or events removed the target
                    if target.components.freezable ~= nil and target:IsValid() then
                        target.components.freezable:AddColdness(1)
                        target.components.freezable:SpawnShatterFX()
                    end
                end
            -----------------------------------------------------------------------------------------------------------------

            inst:ListenForEvent("switch.ice_staff.start",function()
                if inst:HasTag("switch.ice_staff") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.ice_staff")
                print("info ice_staff on")
                -----------------------------------------------------------------------------
                    inst:AddTag("weapon")
                    inst.components.weapon:SetDamage(0)
                    inst.components.weapon:SetRange(8, 10)
                    inst.components.weapon:SetOnAttack(onattack_blue)
                    inst.components.weapon:SetProjectile("ice_projectile")
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.ice_staff.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.ice_staff")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.ice_staff.stop",function()
                if not inst:HasTag("switch.ice_staff") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.ice_staff")
                print("info ice_staff off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.ice_staff.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.ice_staff.start.replica",function()
            print("switch.ice_staff.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.ice_staff")
        end)
        inst:ListenForEvent("switch.ice_staff.stop.replica",function()
            print("switch.ice_staff.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}