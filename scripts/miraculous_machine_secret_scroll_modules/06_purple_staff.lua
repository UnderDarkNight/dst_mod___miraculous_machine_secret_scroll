----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 紫色法杖
----------------------------------------------------------------------------------------------------------------------------------------------------------
------ 传送相关的代码，复制自紫色法杖        
        ---------PURPLE STAFF---------  

        -- AddTag("nomagic") can be used to stop something being teleported
        -- the component teleportedoverride can be used to control the location of a teleported item

        require "prefabs/telebase"

        local function getrandomposition(caster, teleportee, target_in_ocean)
            if target_in_ocean then
                local pt = TheWorld.Map:FindRandomPointInOcean(20)
                if pt ~= nil then
                    return pt
                end
                local from_pt = teleportee:GetPosition()
                local offset = FindSwimmableOffset(from_pt, math.random() * 2 * PI, 90, 16)
                                or FindSwimmableOffset(from_pt, math.random() * 2 * PI, 60, 16)
                                or FindSwimmableOffset(from_pt, math.random() * 2 * PI, 30, 16)
                                or FindSwimmableOffset(from_pt, math.random() * 2 * PI, 15, 16)
                if offset ~= nil then
                    return from_pt + offset
                end
                return teleportee:GetPosition()
            else
                local centers = {}
                for i, node in ipairs(TheWorld.topology.nodes) do
                    if TheWorld.Map:IsPassableAtPoint(node.x, 0, node.y) and node.type ~= NODE_TYPE.SeparatedRoom then
                        table.insert(centers, {x = node.x, z = node.y})
                    end
                end
                if #centers > 0 then
                    local pos = centers[math.random(#centers)]
                    return Point(pos.x, 0, pos.z)
                else
                    return caster:GetPosition()
                end
            end
        end

        local function teleport_end(teleportee, locpos, loctarget, staff)
            if loctarget ~= nil and loctarget:IsValid() and loctarget.onteleto ~= nil then
                loctarget:onteleto()
            end

            if teleportee.components.inventory ~= nil and teleportee.components.inventory:IsHeavyLifting() then
                teleportee.components.inventory:DropItem(
                    teleportee.components.inventory:Unequip(EQUIPSLOTS.BODY),
                    true,
                    true
                )
            end

            --#v2c hacky way to prevent lightning from igniting us
            local preventburning = teleportee.components.burnable ~= nil and not teleportee.components.burnable.burning
            if preventburning then
                teleportee.components.burnable.burning = true
            end
            TheWorld:PushEvent("ms_sendlightningstrike", locpos)
            if preventburning then
                teleportee.components.burnable.burning = false
            end

            if teleportee:HasTag("player") then
                teleportee.sg.statemem.teleport_task = nil
                teleportee.sg:GoToState(teleportee:HasTag("playerghost") and "appear" or "wakeup")
                teleportee.SoundEmitter:PlaySound(staff.skin_castsound or "dontstarve/common/staffteleport")
            else
                teleportee:Show()
                if teleportee.DynamicShadow ~= nil then
                    teleportee.DynamicShadow:Enable(true)
                end
                if teleportee.components.health ~= nil then
                    teleportee.components.health:SetInvincible(false)
                end
                teleportee:PushEvent("teleported")
            end
        end

        local function teleport_continue(teleportee, locpos, loctarget, staff)
            if teleportee.Physics ~= nil then
                teleportee.Physics:Teleport(locpos.x, 0, locpos.z)
            else
                teleportee.Transform:SetPosition(locpos.x, 0, locpos.z)
            end

            if teleportee:HasTag("player") then
                teleportee:SnapCamera()
                teleportee:ScreenFade(true, 1)
                teleportee.sg.statemem.teleport_task = teleportee:DoTaskInTime(1, teleport_end, locpos, loctarget, staff)
            else
                teleport_end(teleportee, locpos, loctarget, staff)
            end
        end

        local function teleport_start(teleportee, staff, caster, loctarget, target_in_ocean, no_teleport)
            local ground = TheWorld

            --V2C: Gotta do this RIGHT AWAY in case anything happens to loctarget or caster
            local locpos
            if not no_teleport then
                locpos = (teleportee.components.teleportedoverride ~= nil and teleportee.components.teleportedoverride:GetDestPosition())
                    or (loctarget == nil and getrandomposition(caster, teleportee, target_in_ocean))
                    or (loctarget.teletopos ~= nil and loctarget:teletopos())
                    or loctarget:GetPosition()

                if teleportee.components.locomotor ~= nil then
                    teleportee.components.locomotor:StopMoving()
                end
            end

            -- staff.components.finiteuses:Use(1)

            if ground:HasTag("cave") then
                -- There's a roof over your head, magic lightning can't strike!
                ground:PushEvent("ms_miniquake", { rad = 3, num = 5, duration = 1.5, target = teleportee })
                return
            end

            local is_teleporting_player
            if not no_teleport then
                if teleportee:HasTag("player") then
                    is_teleporting_player = true
                    teleportee.sg:GoToState("forcetele")
                else
                    if teleportee.components.health ~= nil then
                        teleportee.components.health:SetInvincible(true)
                    end
                    if teleportee.DynamicShadow ~= nil then
                        teleportee.DynamicShadow:Enable(false)
                    end
                    teleportee:Hide()
                end
            end

            --#v2c hacky way to prevent lightning from igniting us
            local preventburning = teleportee.components.burnable ~= nil and not teleportee.components.burnable.burning
            if preventburning then
                teleportee.components.burnable.burning = true
            end
            ground:PushEvent("ms_sendlightningstrike", teleportee:GetPosition())
            if preventburning then
                teleportee.components.burnable.burning = false
            end

            if caster ~= nil then
                if caster.components.staffsanity then
                    caster.components.staffsanity:DoCastingDelta(-TUNING.SANITY_HUGE)
                elseif caster.components.sanity ~= nil then
                    caster.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
                end
            end

            ground:PushEvent("ms_deltamoisture", TUNING.TELESTAFF_MOISTURE)

            if not no_teleport then
                if is_teleporting_player then
                    teleportee.sg.statemem.teleport_task = teleportee:DoTaskInTime(3, teleport_continue, locpos, loctarget, staff)
                else
                    teleport_continue(teleportee, locpos, loctarget, staff)
                end
            end
        end

        local function teleport_targets_sort_fn(a, b)
            return a.distance < b.distance
        end

        local TELEPORT_MUST_TAGS = { "locomotor" }
        local TELEPORT_CANT_TAGS = { "playerghost", "INLIMBO", "noteleport" }
        local function teleport_func(inst, target, pos, caster)
            target = target or caster

            local x, y, z = target.Transform:GetWorldPosition()
            local target_in_ocean = target.components.locomotor ~= nil and target.components.locomotor:IsAquatic()
            local no_teleport = target:HasTag("noteleport") --targetable by spell, but don't actually teleport
            local loctarget
            if not no_teleport then
                loctarget = (target.components.minigame_participator ~= nil and target.components.minigame_participator:GetMinigame())
                        or (target.components.teleportedoverride ~= nil and target.components.teleportedoverride:GetDestTarget())
                        or (target.components.hitchable ~= nil and target:HasTag("hitched") and target.components.hitchable.hitched)
                        or nil

                if loctarget == nil and not target_in_ocean then
                    loctarget = FindNearestActiveTelebase(x, y, z, nil, 1)
                end
            end
            teleport_start(target, inst, caster, loctarget, target_in_ocean, no_teleport)
        end


----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        inst:ListenForEvent("switch.purple_staff.start",function()
            if inst:HasTag("switch.purple_staff") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.purple_staff")
            print("info purple_staff on")
            -----------------------------------------------------------------------------
                inst.fxcolour = {104/255,40/255,121/255}
                inst:AddComponent("spellcaster")
                inst.components.spellcaster:SetSpellFn(teleport_func)
                inst.components.spellcaster.canuseontargets = true
                inst.components.spellcaster.canusefrominventory = true
                inst.components.spellcaster.canonlyuseonlocomotorspvp = true
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.purple_staff.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.purple_staff")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.purple_staff.stop",function()
            if not inst:HasTag("switch.purple_staff") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.purple_staff")

            print("info purple_staff off")
            -----------------------------------------------------------------------------
                inst.fxcolour = nil
                inst:RemoveComponent("spellcaster")
            -----------------------------------------------------------------------------
            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.purple_staff.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.purple_staff.start.replica",function()
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.purple_staff")
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}