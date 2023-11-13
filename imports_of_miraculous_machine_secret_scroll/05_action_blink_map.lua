
----------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------

local function ArriveAnywhere()
    return true
end

local MMS_SCROLL_BLINK_MAP = Action({ priority=999, customarrivecheck=ArriveAnywhere, rmb=true, mount_valid=true, map_action=true, })  
MMS_SCROLL_BLINK_MAP.id = "MMS_SCROLL_BLINK_MAP"
MMS_SCROLL_BLINK_MAP.strfn = function(act) --- 客户端检查是否通过,同时返回显示字段
    if act.doer then
        return "DEFAULT"
    end
end

MMS_SCROLL_BLINK_MAP.fn = function(act)    --- 只在服务端执行~
    -- local inst = act.invobject
    -- local inst = act.target
    -- local doer = act.doer

    local act_pos = act:GetActionPoint()
    -- print("info MMS_SCROLL_BLINK_MAP act_pos:", act_pos)
    -- act.doer.sg:GoToState("portal_jumpin_mms_scroll", {dest = act_pos, from_map = true,})
    local weapon = act.invobject
    local doer = act.doer
    if weapon and weapon.components.miraculous_machine_secret_scroll and weapon.components.miraculous_machine_secret_scroll.blink_map and doer and act_pos then
        return weapon.components.miraculous_machine_secret_scroll:blink_map(doer,act_pos)
    end

    return false
end



AddAction(MMS_SCROLL_BLINK_MAP)
STRINGS.ACTIONS.MMS_SCROLL_BLINK_MAP = {
    DEFAULT = "跳跳跳跳跳",
}
STRINGS.MMS_SCROLL_BLINK_MAP = ACTIONS.MMS_SCROLL_BLINK_MAP.mod_name

local BLINK_MAP_MUST = { "CLASSIFIED", "globalmapicon", "fogrevealer" }
ACTIONS_MAP_REMAP[ACTIONS.MMS_SCROLL_BLINK_MAP.code] = function(act, targetpos)
    -----------------------------------------------------
    -- 这部分代码会在地图上以 30FPS 执行
    -----------------------------------------------------
    local doer = act.doer
    if doer == nil then
        return nil
    end
       
    if not TheWorld.Map:IsAboveGroundAtPoint(targetpos.x,targetpos.y,targetpos.z) then
        return nil
    end
    -- print(" +++++++++++++++++++ ",targetpos,act.invobject)
    local act_remap = BufferedAction(doer, nil, ACTIONS.MMS_SCROLL_BLINK_MAP, act.invobject, targetpos)
    return act_remap
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------
local function DoWortoxPortalTint(inst, val)
    if val > 0 then
        inst.components.colouradder:PushColour("portaltint", 154 / 255 * val, 23 / 255 * val, 19 / 255 * val, 0)
        val = 1 - val
        inst.AnimState:SetMultColour(val, val, val, 1)
    else
        inst.components.colouradder:PopColour("portaltint")
        inst.AnimState:SetMultColour(1, 1, 1, 1)
    end
end
local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------


AddStategraphState("wilson",State{
    name = "portal_jumpin_mms_scroll",
    tags = { "busy", "pausepredict", "nodangle", "nomorph" },

    onenter = function(inst, data)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wortox_portal_jumpin")
        local x, y, z = inst.Transform:GetWorldPosition()
        -- SpawnPrefab("wortox_portal_jumpin_fx").Transform:SetPosition(x, y, z)
        SpawnPrefab("sanity_lower").Transform:SetPosition(x, y, z)
        inst.sg:SetTimeout(11 * FRAMES)
        inst.sg.statemem.from_map = data and data.from_map or nil
        local dest = data and data.dest or nil
        if dest ~= nil then
            inst.sg.statemem.dest = dest
            inst:ForceFacePoint(dest:Get())
        else
            inst.sg.statemem.dest = Vector3(x, y, z)
        end

        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:RemotePausePrediction()
        end
    end,

    onupdate = function(inst)
        if inst.sg.statemem.tints ~= nil then
            DoWortoxPortalTint(inst, table.remove(inst.sg.statemem.tints))
            if #inst.sg.statemem.tints <= 0 then
                inst.sg.statemem.tints = nil
            end
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/infection_post", nil, .7)
            inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
        end),
        TimeEvent(2 * FRAMES, function(inst)
            inst.sg.statemem.tints = { 1, .6, .3, .1 }
            PlayFootstep(inst)
        end),
        TimeEvent(4 * FRAMES, function(inst)
            inst.sg:AddStateTag("noattack")
            inst.components.health:SetInvincible(true)
            inst.DynamicShadow:Enable(false)
        end),
    },

    ontimeout = function(inst)
        inst.sg.statemem.portaljumping = true
        inst.sg:GoToState("portal_jumpout_mms_scroll", {dest = inst.sg.statemem.dest, from_map = inst.sg.statemem.from_map})
    end,

    onexit = function(inst)
        if not inst.sg.statemem.portaljumping then
            inst.components.health:SetInvincible(false)
            inst.DynamicShadow:Enable(true)
            DoWortoxPortalTint(inst, 0)
        end
    end,
})

AddStategraphState("wilson",State{
    name = "portal_jumpout_mms_scroll",
    tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },

    onenter = function(inst, data)
        ToggleOffPhysics(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wortox_portal_jumpout")
        inst:ResetMinimapOffset()
        if data and data.from_map then
            inst:SnapCamera()
        end
        local dest = data and data.dest or nil
        if dest ~= nil then
            inst.Physics:Teleport(dest:Get())
            if TheWorld and TheWorld.components.walkableplatformmanager then -- NOTES(JBK): Workaround for teleporting too far causing the client to lose sync.
                TheWorld.components.walkableplatformmanager:PostUpdate(0)
            end
        else
            dest = inst:GetPosition()
        end
        -- SpawnPrefab("wortox_portal_jumpout_fx").Transform:SetPosition(dest:Get())
        SpawnPrefab("sanity_raise").Transform:SetPosition(dest:Get())
        inst.DynamicShadow:Enable(false)
        inst.sg:SetTimeout(14 * FRAMES)
        DoWortoxPortalTint(inst, 1)
        inst.components.health:SetInvincible(true)
        inst:PushEvent("soulhop")
    end,

    onupdate = function(inst)
        if inst.sg.statemem.tints ~= nil then
            DoWortoxPortalTint(inst, table.remove(inst.sg.statemem.tints))
            if #inst.sg.statemem.tints <= 0 then
                inst.sg.statemem.tints = nil
            end
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/hop_out") end),
        TimeEvent(5 * FRAMES, function(inst)
            inst.sg.statemem.tints = { 0, .4, .7, .9 }
        end),
        TimeEvent(7 * FRAMES, function(inst)
            inst.components.health:SetInvincible(false)
            inst.sg:RemoveStateTag("noattack")
            inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
        end),
        TimeEvent(8 * FRAMES, function(inst)
            inst.DynamicShadow:Enable(true)
            ToggleOnPhysics(inst)
        end),
    },

    ontimeout = function(inst)
        inst.sg:GoToState("idle", true)
    end,

    onexit = function(inst)
        inst.components.health:SetInvincible(false)
        inst.DynamicShadow:Enable(true)
        DoWortoxPortalTint(inst, 0)
        if inst.sg.statemem.isphysicstoggle then
            ToggleOnPhysics(inst)
        end
    end,
})