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

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}