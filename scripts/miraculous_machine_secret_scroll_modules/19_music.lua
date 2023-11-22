----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 演奏乐器
----------------------------------------------------------------------------------------------------------------------------------------------------------

local function band_disable(inst)
    if inst._music_updatetask then
        inst._music_updatetask:Cancel()
        inst._music_updatetask = nil
    end
    --local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    --owner.components.leader:RemoveFollowersByTag("pig")
end

local function CalcDapperness(inst, owner)
    local numfollowers = owner.components.leader ~= nil and owner.components.leader:CountFollowers() or 0
    local numpets = owner.components.petleash ~= nil and owner.components.petleash:GetNumPets() or 0
    return -TUNING.DAPPERNESS_SMALL - math.max(0, numfollowers - numpets) * TUNING.SANITYAURA_SMALL
end

local banddt = 1
local FOLLOWER_ONEOF_TAGS = {"pig", "merm", "farm_plant"}
local FOLLOWER_CANT_TAGS = {"werepig", "player"}
local HAUNTEDFOLLOWER_MUST_TAGS = {"pig"}

local function band_update( inst )
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if owner and owner.components.leader then
        local x,y,z = owner.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, nil, FOLLOWER_CANT_TAGS, FOLLOWER_ONEOF_TAGS)
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 10 then
                if v:HasTag("merm") then
                    if v:HasTag("mermguard") then
                        if owner:HasTag("merm") and not owner:HasTag("mermdisguise") then
                            owner.components.leader:AddFollower(v)
                        end
                    else
                        if owner:HasTag("merm") or (TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKing()) then
                            owner.components.leader:AddFollower(v)
                        end
                    end
                else
                    owner.components.leader:AddFollower(v)
                end
			elseif v.components.farmplanttendable ~= nil then
				v.components.farmplanttendable:TendTo(owner)
			end
        end

        for k,v in pairs(owner.components.leader.followers) do
            if k.components.follower then
                if k:HasTag("pig") then
                    k.components.follower:AddLoyaltyTime(3)

                elseif k:HasTag("merm") then
                    if k:HasTag("mermguard") then
                        if owner:HasTag("merm") and not owner:HasTag("mermdisguise") then
                            k.components.follower:AddLoyaltyTime(3)
                        end
                    else
                        if owner:HasTag("merm") or (TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKing()) then
                            k.components.follower:AddLoyaltyTime(3)
                        end
                    end
                end
            end
        end
    else -- This is for haunted one man band
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, HAUNTEDFOLLOWER_MUST_TAGS, FOLLOWER_CANT_TAGS)
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader  and not inst.components.leader:IsFollower(v) and inst.components.leader.numfollowers < 10 then
                inst.components.leader:AddFollower(v)
                --owner.components.sanity:DoDelta(-TUNING.SANITY_MED)
            end
        end

        for k,v in pairs(inst.components.leader.followers) do
            if k:HasTag("pig") and k.components.follower then
                k.components.follower:AddLoyaltyTime(3)
            end
        end
    end
end

local function band_enable(inst)
    if inst._music_updatetask == nil and inst:HasTag("band") then
        inst._music_updatetask = inst:DoPeriodicTask(banddt, band_update, 1)
    end
end

local function onequip(inst, owner)
    if owner then
        -- owner.AnimState:OverrideSymbol("swap_body_tall", "armor_onemanband", "swap_body_tall")
        -- inst.components.fueled:StartConsuming()
    end
    band_enable(inst)
end

local function onunequip(inst, owner)
    if owner then
        -- owner.AnimState:ClearOverrideSymbol("swap_body_tall")
        -- inst.components.fueled:StopConsuming()
    end
    band_disable(inst)
end

local function onequiptomodel(inst, owner)
    if owner then
        -- inst.components.fueled:StopConsuming()
    end

    band_disable(inst)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


        inst._player_sg_event_music_fn = function(player,_table)
            if inst:HasTag("band") and _table and _table.statename and _table.statename == "idle" then
                player.sg:GoToState("enter_onemanband")
            end
        end

        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:ListenForEvent("newstate",inst._player_sg_event_music_fn)    --- 在玩家身上挂上 event 监听
                band_enable(inst)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:RemoveEventCallback("newstate",inst._player_sg_event_music_fn)       --- 移除挂在玩家身上的 event 监听
                band_disable(inst)
                if inst:HasTag("band") then
                    _table.owner.AnimState:ClearOverrideSymbol("swap_body_tall")
                end
            end
        end)



        inst:ListenForEvent("switch.music.start",function()
            if inst:HasTag("switch.music") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.music")
            print("info music on")
            -----------------------------------------------------------------------------

                inst:AddTag("band")
                inst:AddComponent("leader")
                inst.components.equippable.dapperfn = CalcDapperness
                inst.components.equippable:SetOnEquipToModel(onequiptomodel)
                -- band_enable(inst)
                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    band_enable(inst)
                    owner.AnimState:OverrideSymbol("swap_body_tall", "armor_onemanband", "swap_body_tall")
                    if owner.sg then
                        owner.sg:GoToState("enter_onemanband")
                    end
                end
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.music.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.music")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.music.stop",function()
            if not inst:HasTag("switch.music") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.music")
            print("info music off")
            ------------------------------------------------------------------------
                band_disable(inst)
                inst:RemoveTag("band")
                inst:RemoveComponent("leader")

                inst.components.equippable.dapperfn = nil
                inst.components.equippable:SetOnEquipToModel(nil)
                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner and owner.sg then
                    owner.sg:GoToState("idle")
                end
            ------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.music.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.music.start.replica",function()
            print("switch.music.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.music")
        end)
        inst:ListenForEvent("switch.music.stop.replica",function()
            print("switch.music.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}