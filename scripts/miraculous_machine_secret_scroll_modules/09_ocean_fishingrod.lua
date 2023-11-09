----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 海钓
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
    -------------- 
            local function reticule_add(inst)
                ----------------------------------------------------------------------------------
                    local function reticuletargetfn(inst, pos)
                        local offset = inst.replica.oceanfishingrod ~= nil and inst.replica.oceanfishingrod:GetMaxCastDist() or TUNING.OCEANFISHING_TACKLE.BASE.dist_max
                        return Vector3(ThePlayer.entity:LocalToWorldSpace(offset, 0.001, 0)) -- raised this off the ground a touch so it wont have any z-fighting with the ground biome transition tiles.
                    end
                    local function reticuleshouldhidefn(inst)
                        return inst.replica.inventoryitem ~= nil and inst.replica.inventoryitem:IsHeldBy(ThePlayer) and ThePlayer.components.playercontroller ~= nil and ThePlayer:HasTag("fishing")
                    end
                ----------------------------------------------------------------------------------
                    if inst.components.reticule == nil then
                        inst:AddComponent("reticule")
                    end
                    inst.components.reticule.targetfn = reticuletargetfn
                    inst.components.reticule.shouldhidefn = reticuleshouldhidefn
                    inst.components.reticule.ease = true
                    inst.components.reticule.ispassableatallpoints = true
                ----------------------------------------------------------------------------------
            end
            local function reticule_remove(inst)
                ----------------------------------------------------------------------------------
                    inst:RemoveComponent("reticule")
                ----------------------------------------------------------------------------------
            end
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        ------------------------------------------------------------------------------------------
            inst.____ocean_fishingrod_equipped_event_fn = function(_,_table)
                inst.components.container.canbeopened = true
                inst:DoTaskInTime(0,function()
                    if _table and _table.owner then
                        inst.components.container:Open(_table.owner)
                    end
                end)
            end
            inst.____ocean_fishingrod_unequipped_event_fn = function()
                inst.components.container.canbeopened = false
            end

            inst.____ocean_fishingrod_OnTackleChanged =  function(inst, data)
                if inst.components.oceanfishingrod ~= nil then
                    inst.components.oceanfishingrod:UpdateClientMaxCastDistance()
                end
            end

            local function OnStartedFishing(inst, fisher, target)
                if inst.components.container ~= nil then
                    inst.components.container:Close()
                end
                inst:AddTag("forbid_type_switch")   ---- 禁止切换武器
            end
            local function OnDoneFishing(inst, reason, lose_tackle, fisher, target)
                if inst.components.container ~= nil and lose_tackle then
                    inst.components.container:DestroyContents()
                end
            
                if inst.components.container ~= nil and fisher ~= nil and inst.components.equippable ~= nil and inst.components.equippable.isequipped then
                    inst.components.container:Open(fisher)
                end
                inst:RemoveTag("forbid_type_switch")   ---- 允许切换武器
            end
            local function OnHookedSomething(inst, target)
                if target ~= nil and inst.components.container then
                    if target.components.oceanfishinghook ~= nil then
                        if TheWorld.Map:IsOceanAtPoint(target.Transform:GetWorldPosition()) then
                            for slot, item in pairs(inst.components.container.slots) do
                                if item ~= nil and item.components.inventoryitem ~= nil then
                                    item.components.inventoryitem:AddMoisture(TUNING.OCEAN_WETNESS)
                                end
                            end
                        end
                    elseif not target:HasTag("projectile") then
                        for slot, item in pairs(inst.components.container.slots) do
                            if item ~= nil and item.components.oceanfishingtackle ~= nil and item.components.oceanfishingtackle:IsSingleUse() then
                                inst.components.container:RemoveItemBySlot(slot):Remove()
                            end
                        end
                    end
                end
            end
            local function GetTackle(inst)
                return (inst.components.oceanfishingrod ~= nil and inst.components.container ~= nil) and
                    {
                        bobber = inst.components.container.slots[1],
                        lure = inst.components.container.slots[2]
                    }
                    or {}
            end
        ------------------------------------------------------------------------------------------
            local function on_switch(inst)
                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    inst:PushEvent("equipped",{owner = owner})
                end
            end
        ------------------------------------------------------------------------------------------

        inst:ListenForEvent("switch.ocean_fishingrod.start",function()
            if inst:HasTag("switch.ocean_fishingrod") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.ocean_fishingrod")
            print("info ocean_fishingrod on")
            -----------------------------------------------------------------------------
                inst:ListenForEvent("equipped",inst.____ocean_fishingrod_equipped_event_fn)
                inst:ListenForEvent("unequipped",inst.____ocean_fishingrod_unequipped_event_fn)
                inst:AddTag("allow_action_on_impassable")
                inst:AddTag("accepts_oceanfishingtackle")


                inst:AddComponent("oceanfishingrod")
                inst.components.oceanfishingrod:SetDefaults("oceanfishingbobber_none_projectile", TUNING.OCEANFISHING_TACKLE.BASE, TUNING.OCEANFISHING_LURE.HOOK, {build = "oceanfishing_hook", symbol = "hook"})
                inst.components.oceanfishingrod.oncastfn = OnStartedFishing
                inst.components.oceanfishingrod.ondonefishing = OnDoneFishing
                inst.components.oceanfishingrod.onnewtargetfn = OnHookedSomething
                inst.components.oceanfishingrod.gettackledatafn = GetTackle

                inst:ListenForEvent("itemget", inst.____ocean_fishingrod_OnTackleChanged)
                inst:ListenForEvent("itemlose", inst.____ocean_fishingrod_OnTackleChanged)

                on_switch(inst)
                reticule_add(inst)
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.ocean_fishingrod.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.ocean_fishingrod")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.ocean_fishingrod.stop",function()
            if not inst:HasTag("switch.ocean_fishingrod") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.ocean_fishingrod")
            -- inst:RemoveTag("forbid_type_switch")    --- 禁止模式切换
            print("info ocean_fishingrod off")
            ------------------------------------------------------------------------
                inst:RemoveEventCallback("equipped",inst.____ocean_fishingrod_equipped_event_fn)
                inst:RemoveEventCallback("unequipped",inst.____ocean_fishingrod_unequipped_event_fn)
                inst.components.container.canbeopened = false
                inst:RemoveTag("allow_action_on_impassable")
                inst:RemoveTag("accepts_oceanfishingtackle")

                inst:RemoveComponent("oceanfishingrod")

                inst:RemoveEventCallback("itemget", inst.____ocean_fishingrod_OnTackleChanged)
                inst:RemoveEventCallback("itemlose", inst.____ocean_fishingrod_OnTackleChanged)

                inst.components.container:Close()
                reticule_remove(inst)
            ------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.ocean_fishingrod.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.ocean_fishingrod.start.replica",function()
            print("switch.ocean_fishingrod.start.replica")
            ----------------------------------------------------------------------------------
                reticule_add(inst)
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.ocean_fishingrod")
        end)
        inst:ListenForEvent("switch.ocean_fishingrod.stop.replica",function()
            print("switch.ocean_fishingrod.stop.replica")

            ----------------------------------------------------------------------------------
                reticule_remove(inst)
            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}