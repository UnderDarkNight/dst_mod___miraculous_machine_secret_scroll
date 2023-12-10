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

            inst:ListenForEvent("equipped",function(_,_table)
                if _table and _table.owner and _table.owner.userid then
                    if inst:HasTag("goggles") then
                            local owner = _table.owner
                            local playervision = owner.components.playervision
                            if playervision then    
                                if playervision.gogglevision == not owner.replica.inventory:EquipHasTag("goggles") then
                                    playervision.gogglevision = not playervision.gogglevision
                                    if not playervision.forcegogglevision then
                                        owner:PushEvent("gogglevision", { enabled = playervision.gogglevision })
                                    end
                                end
                            end
                    end
                end
            end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}