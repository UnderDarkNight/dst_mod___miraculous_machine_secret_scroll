----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 注册物品置入组件
--[[
        物品                    prefab                 可叠堆
    · 彩虹宝石              opalpreciousgem          stackable
    · 金块                  goldnugget               stackable
    · 蜘蛛丝                silk                     stackable
    · 噩梦燃料              nightmarefuel            stackable
    · 橙色宝石              orangegem                stackable
    · 紫色宝石              purplegem                stackable
    · 蓝色宝石              bluegem                  stackable
    · 红色宝石              redgem                   stackable
    · 萤火虫                fireflies                stackable

    · 手杖                  cane
    · 懒人法杖              orangestaff
    · 传送法杖              telestaff
    · 冰魔杖                icestaff
    · 火魔杖                firestaff
    · 捕虫网                bugnet

    · 斧头                  axe
    · 金斧头                goldenaxe
    · 玻璃斧头              moonglassaxe

    · 斧镐                  multitool_axe_pickaxe

    · 矿镐                  pickaxe
    · 金矿镐                goldenpickaxe

    · 铲子                  shovel
    · 金铲子                goldenshovel
    · 亮茄铲子              shovel_lunarplant

    · 锤子                  hammer
    · 亮茄锤子              pickaxe_lunarplant

    · 三叉戟                trident

    · 剃刀                  razor

    · 沙漠护目镜            deserthat
    · 星象护目镜            moonstorm_goggleshat

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
local accept_fns = require("miraculous_machine_secret_scroll_modules/01_acceptable_logic_fn")
----------------------------------------------------------------------------------------------------------------------------------------------------------
local function add_acceptable_com(inst)
    inst:AddComponent("mms_scroll_com_acceptable")
    inst.components.mms_scroll_com_acceptable:SetTestFn(function(inst,item,doer,right_click)
        if item and accept_fns and accept_fns[item.prefab] then
            return accept_fns[item.prefab].test_fn(inst,item,doer)
        end
        return false
    end)

    inst.components.mms_scroll_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
        if not TheWorld.ismastersim then
            return
        end
        -- print("mms_scroll_com_acceptable",item,doer)
        -- -- local accept_item = nil
        -- -- if item then
        -- --     if item.components.stackable then
        -- --         accept_item = item.components.stackable:Get()
        -- --     else
        -- --         -- item:Remove()
        -- --         accept_item = item
        -- --     end
        -- -- end
        -- if item then
        --     inst:PushEvent("item_accept",item)
        -- end
        if item and accept_fns and accept_fns[item.prefab] then
            accept_fns[item.prefab].on_accept_fn(inst,item,doer)
        end

        inst.components.miraculous_machine_secret_scroll:synchronized_data_2_replica()
        return true
    end)
    inst.components.mms_scroll_com_acceptable:SetSGAction("dolongaction")
    inst.components.mms_scroll_com_acceptable:SetActionDisplayStr("mms_scroll_com_acceptable","升级")
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        if inst.components.mms_scroll_com_acceptable == nil then
            add_acceptable_com(inst)
        end
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        if inst.components.mms_scroll_com_acceptable == nil then
            add_acceptable_com(inst)
        end
    end
    -----------------------------------------------------------------------------------------------------------------
}