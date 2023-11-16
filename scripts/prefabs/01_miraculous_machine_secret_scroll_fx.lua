----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/miraculous_machine_secret_scroll_fx.zip"),
}

local function OnHit(inst, owner, target)
    -- if inst.__attack_task then
    --     inst.__attack_task:Cancel()
    -- end


    -- if inst.__target_fn then
    --     inst.__target_fn(inst,owner,target)
    -- end
    -- inst:Remove()
    inst:AddTag("stop")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddAnimState()

    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize(1,1)

    inst.AnimState:SetBank("miraculous_machine_secret_scroll_fx")
    inst.AnimState:SetBuild("miraculous_machine_secret_scroll_fx")
    inst.AnimState:PlayAnimation("close",true)
    local scale = 0.5
    inst.AnimState:SetScale(scale, scale, scale)

    inst:AddTag("projectile")
    inst:AddTag("FX")
    inst:AddTag("INLIMBO")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(10)     -- wilson 6
    inst.components.projectile:SetHoming(false)
    inst.components.projectile:SetHitDist(2)
    -- inst.components.projectile:SetOnHitFn(function(inst,owner,target)
    --     inst:AddTag("stop")
    -- end)
    -- inst.components.projectile:SetOnMissFn(inst.Remove)
    -- inst.components.projectile:SetOnThrownFn(OnThrown)
    inst:DoTaskInTime(0,function()
        if inst.__target == nil or inst.__owner == nil then
            inst:Remove()
        end
    end)


    function inst:Close2Target(target,speed)
        self:FacePoint(target.Transform:GetWorldPosition())
        self.Physics:ClearCollidesWith(COLLISION.LIMITS)
        self.Physics:SetMotorVel(speed, 0, 0)
    end
    function inst:StopClosing()
        inst.Physics:Stop()
    end

    inst:ListenForEvent("Set",function(inst,_table)
        -- _table = {
        --     pt = pt, 
        --     target = target,
        --     owner = player or weapon,
        --     speed = 16,
        --     range = 2
        ---------------------------------------------------------------
        -- }
        if _table == nil then
            return
        end
        if _table.pt == nil or _table.target == nil or _table.owner == nil then
            return
        end
        inst.__target = _table.target
        inst.__owner = _table.owner
        inst.__range = _table.range
        inst.__speed = _table.speed

        inst.Transform:SetPosition(_table.pt.x, 0,_table.pt.z)

    end)

    inst.__attack_task = inst:DoPeriodicTask(0.5,function()
        if inst.__target and inst.__target:IsValid() then

                local dis_sq = inst:GetDistanceSqToInst(inst.__target)
                if dis_sq > 20*20 then
                        inst.Transform:SetPosition(inst.__target.Transform:GetWorldPosition())
                        inst:StopClosing()
                else
                        if  dis_sq > ( (inst.__range or 0) * (inst.__range or 0) ) then
                            inst:Close2Target(inst.__target,inst.__speed or 10)
                        else
                            inst:StopClosing()
                        end
                end
                       

        else
            inst:Remove()
        end
    end)
    ------------------------------------------------------------------------------
    --- 切换外观
        inst:ListenForEvent("weapon_in_hand",function(_,cmd)
            if cmd == "off" then
                inst.AnimState:PlayAnimation("close",true)
            else
                inst.AnimState:PlayAnimation("open",true)
            end
        end)
    ------------------------------------------------------------------------------

    return inst
end

return Prefab("miraculous_machine_secret_scroll_fx", fn,assets)