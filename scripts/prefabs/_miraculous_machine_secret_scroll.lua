local assets =
{
    Asset("ANIM", "anim/cane.zip"),
    Asset("ANIM", "anim/swap_cane.zip"),
}

local function onequip(inst, owner)
    -- owner.AnimState:OverrideSymbol("swap_object", "swap_cane", "swap_cane")
    -- owner.AnimState:Show("ARM_carry")
    -- owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("cane")
    inst.AnimState:SetBuild("swap_cane")
    inst.AnimState:PlayAnimation("idle")


    inst:AddTag("weapon")
    inst:AddTag("miraculous_machine_secret_scroll")
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
        ----------------------------------------------------------------------------------------------



        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "cane"
        inst.components.inventoryitem.atlasname = GetInventoryItemAtlas("cane.tex")
        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
        inst.components.equippable.restrictedtag = "player"
        -- inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
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

    return inst
end

return Prefab("miraculous_machine_secret_scroll", fn, assets)
