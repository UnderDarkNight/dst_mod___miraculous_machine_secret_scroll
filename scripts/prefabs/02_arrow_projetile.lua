local assets =
{
    Asset("ANIM", "anim/mms_scroll_arrow.zip"),
}

local function OnHit(inst, attacker, target)

end

local function OnAnimOver(inst)
    -- inst:DoTaskInTime(.3, inst.Remove)
end

local function OnThrown(inst)
    -- inst:ListenForEvent("animover", OnAnimOver)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("mms_scroll_arrow")
    inst.AnimState:SetBuild("mms_scroll_arrow")
    inst.AnimState:PlayAnimation("blue")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(30)
    inst.components.projectile:SetHoming(false)
    inst.components.projectile:SetHitDist(2)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(inst.Remove)
    -- inst.components.projectile:SetOnThrownFn(OnThrown)

    ---------------------------------------------------------------------------------------------
    ---- hook 弹药投掷函数，获取相关数据
        inst.components.projectile.Throw___scroll_old = inst.components.projectile.Throw
        inst.components.projectile.Throw = function(self,weapon,target,attacker) 
            -- print("mms_scroll_arrow",weapon,target,attacker)
            if weapon and weapon._mms_scroll_arrow_init_fn then         --- 根据武器 初始化外观
                weapon._mms_scroll_arrow_init_fn(inst)
            end
            self:SetOnHitFn(function(...)                               ---- 击中函数                  
                if weapon and weapon._mms_scroll_arrow_onhit_fn then
                    weapon._mms_scroll_arrow_onhit_fn(...)
                end
                self.inst:Remove()
            end)
            inst:DoTaskInTime(0,function()                              ----- 高度修正
                local x,y,z = inst.Transform:GetWorldPosition()
                inst.Transform:SetPosition(x, y + 1, z)
            end)

            self:Throw___scroll_old(weapon,target,attacker)
        end
    ---------------------------------------------------------------------------------------------
        inst:ListenForEvent("color",function(_,cmd)
            if cmd == "red" then
                inst.AnimState:PlayAnimation("red")
            else
                inst.AnimState:PlayAnimation("blue")
            end
        end)
    ---------------------------------------------------------------------------------------------


    return inst
end


return Prefab("mms_scroll_arrow", fn, assets)