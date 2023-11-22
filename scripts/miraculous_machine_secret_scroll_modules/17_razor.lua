----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 近战武器组件 改造。 剃刀功能
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


            inst:ListenForEvent("switch.razor.start",function()
                if inst:HasTag("switch.razor") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.razor")
                print("info razor on")
                -----------------------------------------------------------------------------
                    local attack_range = 0.5
                    inst:AddTag("weapon")
                    inst.components.weapon:SetDamage(0)
                    inst.components.weapon.attackrange = attack_range
                    inst.components.weapon.hitrange = attack_range
                    inst.components.weapon.onattack = function(inst,attacker,target)
                        -- print("onattack razor",attacker,target)
                        if attacker and target then
                            if target.components.beard then 

                                if target.components.beard:ShouldTryToShave(attacker,inst) then
                                    target.components.beard:Shave(attacker,inst)
                                end

                            elseif target.components.shaveable then

                                if target.components.shaveable:CanShave() then
                                    target.components.shaveable:Shave(attacker,inst)
                                end

                            else
                                if target.components.combat then
                                    target.components.combat:GetAttacked(attacker, 0.1)
                                end
                            end
                        end
                    end
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.razor.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.razor")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.razor.stop",function()
                if not inst:HasTag("switch.razor") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.razor")
                print("info razor off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.razor.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.razor.start.replica",function()
            print("switch.razor.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.razor")
        end)
        inst:ListenForEvent("switch.razor.stop.replica",function()
            print("switch.razor.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}