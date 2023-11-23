----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 物品接受逻辑
----------------------------------------------------------------------------------------------------------------------------------------------------------
local function get_item_by_num(item,need_num)
    
end
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    --------------------------------------------------------
    -- 彩虹宝石
        ["opalpreciousgem"] = {        
            test_fn = function(inst,item,doer)
                    if inst.replica.miraculous_machine_secret_scroll:Get("weapon_level.full") ~= true then  --- 没满级之前，允许添加
                        return true
                    else
                        return false
                    end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0)
                    local max_num = 60
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("weapon_level.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("weapon_level.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("weapon_level.full",true)
                        end
                        item:Remove()
                    end

                    ----- 强制检查等级和标记位
                    if inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0) >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("weapon_level.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("weapon_level.num",max_num)
                    end

                    inst:PushEvent("weapon_level.changed")
            end,
        },
    --------------------------------------------------------
    -- 金块
        ["goldnugget"] = {        
            test_fn = function(inst,item,doer)
                    if inst.replica.miraculous_machine_secret_scroll:Get("goldnugget.full") ~= true then  --- 没满级之前，允许添加
                        return true
                    else
                        return false
                    end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("goldnugget.num",0)
                    local max_num = 100
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("goldnugget.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("goldnugget.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("goldnugget.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("goldnugget.full",true)
                        end
                        item:Remove()
                    end
                    inst:PushEvent("weapon_level.changed")
            end,
        },
    --------------------------------------------------------
    -- 蜘蛛丝
        ["silk"] = {        
            test_fn = function(inst,item,doer)
                    if inst.replica.miraculous_machine_secret_scroll:Get("silk.full") ~= true 
                    and inst.replica.miraculous_machine_secret_scroll:Get("boss.kill.spiderqueen") then  --- 没满级之前,击杀蜘蛛BOSS后，才允许添加
                        return true
                    else
                        return false
                    end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("silk.num",0)
                    local max_num = 400
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("silk.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("silk.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("silk.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("silk.full",true)
                        end
                        item:Remove()
                    end
                    inst:PushEvent("weapon_level.changed")
            end,
        },
    --------------------------------------------------------
    -- 噩梦燃料
        ["nightmarefuel"] = {        
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("nightmarefuel.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("orangestaff.full") then  --- 橙色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("nightmarefuel.num",0)
                    local max_num = 100
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("nightmarefuel.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("nightmarefuel.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("nightmarefuel.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("nightmarefuel.full",true)
                        end
                        item:Remove()
                    end
            end,
        },
    --------------------------------------------------------
    -- 橙色宝石
        ["orangegem"] = {        
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("orangegem.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("orangestaff.full") then  --- 橙色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("orangegem.num",0)
                    local max_num = 10
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("orangegem.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("orangegem.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("orangegem.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("orangegem.full",true)
                        end
                        item:Remove()
                    end
            end,
        },
    --------------------------------------------------------
    -- 紫色宝石
        ["purplegem"] = {        
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("purplegem.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("telestaff.full") then  --- 橙色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("purplegem.num",0)
                    local max_num = 20
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("purplegem.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("purplegem.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("purplegem.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("purplegem.full",true)
                        end
                        item:Remove()
                    end
            end,
        },
    --------------------------------------------------------
    -- 萤火虫
        ["fireflies"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("fireflies.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("bugnet.full") then  --- 橙色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("fireflies.num",0)
                    local max_num = 100
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("fireflies.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("fireflies.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("fireflies.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("fireflies.full",true)
                        end
                        item:Remove()
                    end
            end,
        },
    --------------------------------------------------------
    -- 手杖
        ["cane"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("monster.kill.walrus")  
                    and inst.replica.miraculous_machine_secret_scroll:Get("monster.kill.little_walrus") 
                    and inst.replica.miraculous_machine_secret_scroll:Get("cane.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)

                local current_num = inst.components.miraculous_machine_secret_scroll:Add("cane.num",1)
                local max_num = 14
                if current_num >= max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("cane.full",true)
                    inst.components.miraculous_machine_secret_scroll:Set("cane.num",max_num)
                end
                item:Remove()
                inst:PushEvent("walk_speed_init")

            end,
        },
    --------------------------------------------------------
    -- 懒人法杖
        ["orangestaff"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("orangestaff.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("orangestaff.num",1)
                    local max_num = 1
                    if current_num >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("orangestaff.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("orangestaff.num",max_num)
                    end
                    item:Remove()
            end,
        },
    --------------------------------------------------------
    -- 传送法杖
        ["telestaff"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("telestaff.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("telestaff.num",1)
                    local max_num = 1
                    if current_num >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("telestaff.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("telestaff.num",max_num)
                    end
                    item:Remove()
            end,
        },
    --------------------------------------------------------
    -- 捕虫网
        ["bugnet"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("bugnet.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("bugnet.num",1)
                    local max_num = 1
                    if current_num >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("bugnet.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("bugnet.num",max_num)
                    end
                    item:Remove()
            end,
        },
    --------------------------------------------------------
    -- 斧头
        ["axe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 金斧头
        ["goldenaxe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 玻璃斧头
        ["moonglassaxe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 斧镐
        ["multitool_axe_pickaxe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 矿镐
        ["pickaxe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 金矿镐
        ["goldenpickaxe"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 铲子
        ["shovel"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 金铲子
        ["goldenshovel"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 亮茄铲子
        ["shovel_lunarplant"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 锤子
        ["hammer"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 亮茄锤子
        ["pickaxe_lunarplant"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 三叉戟
        ["trident"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 剃刀
        ["razor"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 沙漠护目镜
        ["deserthat"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------
    -- 星象护目镜
        ["moonstorm_goggleshat"] = {
            test_fn = function(inst,item,doer)
                return true
            end,
            on_accept_fn = function(inst,item,doer)

            end,
        },
    --------------------------------------------------------

}