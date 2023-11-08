----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 橙色法杖
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        inst:ListenForEvent("switch.orange_staff.start",function()
            if inst:HasTag("switch.orange_staff") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.orange_staff")
            print("info orange_staff on")
            -----------------------------------------------------------------------------
                    local function onblink(staff, pos, caster)
                        if caster then
                            if caster.components.staffsanity then
                                caster.components.staffsanity:DoCastingDelta(-TUNING.SANITY_MED)
                            elseif caster.components.sanity ~= nil then
                                caster.components.sanity:DoDelta(-TUNING.SANITY_MED)
                            end
                        end            
                    end
                    inst.fxcolour = {1, 145/255, 0}
                    inst.castsound = "dontstarve/common/staffteleport"
                
                    inst:AddComponent("blinkstaff")
                    inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
                    inst.components.blinkstaff.onblinkfn = onblink
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.orange_staff.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.orange_staff")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.orange_staff.stop",function()
            if not inst:HasTag("switch.orange_staff") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.orange_staff")
            print("info orange_staff off")
            ------------------------------------------------------------------------
                    inst.fxcolour = nil
                    inst.castsound = nil
                    inst:RemoveComponent("blinkstaff")
            ------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.orange_staff.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.orange_staff.start.replica",function()
            local function NoHoles(pt)
                return not TheWorld.Map:IsGroundTargetBlocked(pt)
            end
            
            local BLINKFOCUS_MUST_TAGS = { "blinkfocus" }
            
            local function blinkstaff_reticuletargetfn()
                local player = ThePlayer
                local rotation = player.Transform:GetRotation()
                local pos = player:GetPosition()
                local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, TUNING.CONTROLLER_BLINKFOCUS_DISTANCE, BLINKFOCUS_MUST_TAGS)
                for _, v in ipairs(ents) do
                    local epos = v:GetPosition()
                    if distsq(pos, epos) > TUNING.CONTROLLER_BLINKFOCUS_DISTANCESQ_MIN then
                        local angletoepos = player:GetAngleToPoint(epos)
                        local angleto = math.abs(anglediff(rotation, angletoepos))
                        if angleto < TUNING.CONTROLLER_BLINKFOCUS_ANGLE then
                            return epos
                        end
                    end
                end
                rotation = rotation * DEGREES
                for r = 13, 1, -1 do
                    local numtries = 2 * PI * r
                    local offset = FindWalkableOffset(pos, rotation, r, numtries, false, true, NoHoles, false, true)
                    if offset ~= nil then
                        pos.x = pos.x + offset.x
                        pos.y = 0
                        pos.z = pos.z + offset.z
                        return pos
                    end
                end
            end

            inst:AddComponent("reticule")
            inst.components.reticule.targetfn = blinkstaff_reticuletargetfn
            inst.components.reticule.ease = true


            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.orange_staff")
        end)
        inst:ListenForEvent("switch.orange_staff.stop.replica",function ()
            inst:RemoveComponent("reticule")
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}