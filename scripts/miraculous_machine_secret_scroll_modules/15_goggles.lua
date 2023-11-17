----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 护目镜
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
            inst:ListenForEvent("func.goggles_switch",function()
                if inst:HasTag("goggles") then
                    inst:RemoveTag("goggles")
                else
                    inst:AddTag("goggles")
                end

                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    -- owner.components.inventory:Unequip(EQUIPSLOTS.HANDS)
                    -- owner.components.inventory:Equip(inst)
                    -- owner:PushEvent("gogglevision", { enabled = self.gogglevision })
                    local playervision = owner.components.playervision
                    if playervision then

                                if playervision.gogglevision == not owner.replica.inventory:EquipHasTag("goggles") then
                                    playervision.gogglevision = not playervision.gogglevision
                                    if not playervision.forcegogglevision then
                                        owner:PushEvent("gogglevision", { enabled = playervision.gogglevision })
                                    end
                                end
                    end
                    owner.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")

                end

            end)
            -----------------------------------------------------------------------------------------------------------------
            -- inst:ListenForEvent("switch.goggles.start",function()
            --     if inst:HasTag("switch.goggles") then    ---- 避免重复切换
            --         return
            --     end
            --     inst:AddTag("switch.goggles")
            --     print("info goggles on")
            --     -----------------------------------------------------------------------------

            --     -----------------------------------------------------------------------------

            --     inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.goggles.start.replica")
            --     inst.components.miraculous_machine_secret_scroll:Set("type","switch.goggles")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            -- end)

            -- inst:ListenForEvent("switch.goggles.stop",function()
            --     if not inst:HasTag("switch.goggles") then    --- 避免意外拆除组件
            --         return
            --     end
            --     inst:RemoveTag("switch.goggles")
            --     print("info goggles off")
            --     ------------------------------------------------------------------------
                    
            --     ------------------------------------------------------------------------

            --     inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.goggles.stop.replica")

            -- end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        -- inst:ListenForEvent("switch.goggles.start.replica",function()
        --     print("switch.goggles.start.replica")
        --     ----------------------------------------------------------------------------------
                
        --     ----------------------------------------------------------------------------------
        --     inst.replica.miraculous_machine_secret_scroll:Set("type","switch.goggles")
        -- end)
        -- inst:ListenForEvent("switch.goggles.stop.replica",function()
        --     print("switch.goggles.stop.replica")
        --     ----------------------------------------------------------------------------------

        --     ----------------------------------------------------------------------------------
        -- end)
    end
    -----------------------------------------------------------------------------------------------------------------
}