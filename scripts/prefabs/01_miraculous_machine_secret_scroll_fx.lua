----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/miraculous_machine_secret_scroll_fx.zip"),
}


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
    inst.AnimState:PlayAnimation("close_idle",true)
    local scale = 1
    inst.AnimState:SetScale(scale, scale, scale)

    inst:AddTag("projectile")
    inst:AddTag("INLIMBO")
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")      --- 不可点击
    inst:AddTag("CLASSIFIED")   --  私密的，client 不可观测， FindEntity 默认过滤
    inst:AddTag("NOBLOCK")      -- 不会影响种植和放置

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

        inst.Transform:SetPosition(_table.pt.x,0,_table.pt.z)

    end)

    inst.__attack_task = inst:DoPeriodicTask(0.5,function()
        if inst.__target and inst.__target:IsValid() then
                local x,y,z = inst.__target.Transform:GetWorldPosition()
                local dis_sq = inst:GetDistanceSqToInst(inst.__target)
                if dis_sq > 20*20 then                    
                        inst.Transform:SetPosition(x,0,z)
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
        inst:AddTag("closing")
    --- 切换外观
        inst:ListenForEvent("weapon_in_hand",function(_,cmd)
            if cmd == "off" then
                if not inst:HasTag("closing") then
                    inst.AnimState:PlayAnimation("close")
                    inst.AnimState:PushAnimation("close_idle",true)
                    inst:AddTag("closing")
                end
            else
                if inst:HasTag("closing") then
                    inst.AnimState:PlayAnimation("open")
                    inst.AnimState:PushAnimation("open_idle",true)
                    inst:RemoveTag("closing")
                end
            end
        end)
    ------------------------------------------------------------------------------

    return inst
end

return Prefab("miraculous_machine_secret_scroll_fx", fn,assets)