local assets =
{

    Asset("ANIM", "anim/longfeng.zip"),

    Asset("ANIM", "anim/miraculous_machine_secret_scroll_fx.zip"),
    Asset("ANIM", "anim/miraculous_machine_secret_scroll_fx_red.zip"),
    Asset( "IMAGE", "images/inventoryimages/miraculous_machine_secret_scroll.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/miraculous_machine_secret_scroll.xml" ),
    Asset( "IMAGE", "images/inventoryimages/miraculous_machine_secret_scroll_red.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/miraculous_machine_secret_scroll_red.xml" ),
}

local function onequip(inst, owner)
    -- owner.AnimState:OverrideSymbol("swap_object", "swap_cane", "swap_cane")
    -- owner.AnimState:Show("ARM_carry")
    -- owner.AnimState:Hide("ARM_normal")

    if inst.__fx == nil then
        inst.__fx = SpawnPrefab("miraculous_machine_secret_scroll_fx")
        local offset_x = math.random(10,50)/10
        local offset_z = math.random(10,50)/10
        if math.random(100) < 50 then
            offset_x = -offset_x
        end
        if math.random(100) < 50 then
            offset_z = -offset_z
        end
        local x,y,z = owner.Transform:GetWorldPosition()
        inst.__fx:PushEvent("Set",{
            pt = Vector3(x+offset_x,0,z+offset_z),
            target = owner,
            owner = inst,
            speed = 12,  -- 6
            range = 5,  -- 5
        })

        if inst:HasTag("max_level") then
            inst.__fx:PushEvent("change_2_red")
        end

    end

end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    if inst.__fx ~= nil then
        inst.__fx:Remove()
        inst.__fx = nil
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", nil, 0.75)
    
    inst.AnimState:SetBank("miraculous_machine_secret_scroll_fx")
    inst.AnimState:SetBuild("miraculous_machine_secret_scroll_fx")
    inst.AnimState:PlayAnimation("ground_idle")
    -- inst.AnimState:SetBank("longfeng")
    -- inst.AnimState:SetBuild("longfeng")
    -- inst.AnimState:PlayAnimation("open_idle",true)


    inst:AddTag("weapon")
    inst:AddTag("miraculous_machine_secret_scroll")
    inst:AddTag("waterproofer")
    inst.entity:SetPristine()


    if TheWorld.ismastersim then
        ----------------------------------------------------------------------------------------------
        ---- 武器组件
            inst:AddComponent("weapon")
            inst.components.weapon:SetDamage(0)
            inst.components.weapon._scroll_init = function(self)    --- 一次性重置武器组件
                self.damage = 0
                self.attackrange = nil
                self.hitrange = nil
                self.onattack = nil
                self.onprojectilelaunch = nil
                self.onprojectilelaunched = nil
                self.projectile = nil
                self.stimuli = nil
                self.overridestimulifn = nil
                self.projectile_offset = nil
            end
        ----------------------------------------------------------------------------------------------
            inst:AddComponent("miraculous_machine_secret_scroll")
        ----------------------------------------------------------------------------------------------
        --- 冷却系统
            inst:AddComponent("rechargeable")
            inst.components.rechargeable:SetMaxCharge(30)
        ----------------------------------------------------------------------------------------------
        --- 防水
            inst:AddComponent("waterproofer")
            inst.components.waterproofer:SetEffectiveness(0)
        ----------------------------------------------------------------------------------------------
        --- 位面伤害
            inst:AddComponent("planardamage")
            inst:AddComponent("damagetypebonus")
        ----------------------------------------------------------------------------------------------



        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "miraculous_machine_secret_scroll"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/miraculous_machine_secret_scroll.xml"
        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
        inst.components.equippable.restrictedtag = "player"
        -- inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
        -- inst.components.equippable.walkspeedmult = 1.1
        MakeHauntableLaunch(inst)
    end

    --------------------------------------------------------------------------------------------------------------
    ---- 模块切割，这个是总入口
        local modules_init_fn = require("miraculous_machine_secret_scroll_modules/__scroll_modules_init")
        if type(modules_init_fn) == "function" then
            modules_init_fn(inst)
        end
    --------------------------------------------------------------------------------------------------------------


    if not TheWorld.ismastersim then
        return inst
    end

    --------------------------------------------------------------------------------------------------------------
    ----- 外观特效切换
            inst:ListenForEvent("weapon_in_hand",function(_,cmd)
                if inst.__fx then
                    if cmd == "off" then
                        inst.__fx:PushEvent("weapon_in_hand","off")
                    else
                        local weapon_type = inst.components.miraculous_machine_secret_scroll:Get("type")
                        inst.__fx:PushEvent("weapon_in_hand",weapon_type)
                    end
                end
            end)


            inst:ListenForEvent("change_2_red",function()
                ----------- 切换物品外观
                    inst.components.inventoryitem.imagename = "miraculous_machine_secret_scroll_red"
                    inst.components.inventoryitem.atlasname = "images/inventoryimages/miraculous_machine_secret_scroll_red.xml"
                    inst.AnimState:SetBank("miraculous_machine_secret_scroll_fx_red")
                    inst.AnimState:SetBuild("miraculous_machine_secret_scroll_fx_red")
                    inst:PushEvent("imagechange")
                    local t_scale = 0.5
                    inst.AnimState:SetScale(t_scale, t_scale, t_scale)
                ----------- 切换特效
                    if inst.__fx then
                        inst.__fx:PushEvent("change_2_red")
                    end
            end)
    --------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------
    --- 落水影子
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                inst.AnimState:Hide("SHADOW")
                inst.AnimState:PlayAnimation("ground_idle")
            else                                
                inst.AnimState:Show("SHADOW")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------

    return inst
end

return Prefab("miraculous_machine_secret_scroll", fn, assets)
