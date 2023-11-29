----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 物品接受逻辑
----------------------------------------------------------------------------------------------------------------------------------------------------------

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

                        inst:PushEvent("scroll_level_init")
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

                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("goldnugget.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("goldnugget.num",max_num)
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

                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("silk.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("silk.num",max_num)
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

                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("nightmarefuel.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("nightmarefuel.num",max_num)
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
                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("orangegem.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("orangegem.num",max_num)
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

                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("purplegem.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("purplegem.num",max_num)
                    end
            end,
        },
    --------------------------------------------------------
    -- 红色宝石
        ["redgem"] = {        
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("redgem.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("firestaff.full") then  --- 红色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("redgem.num",0)
                    local max_num = 40
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("redgem.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("redgem.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("redgem.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("redgem.full",true)
                        end
                        item:Remove()
                    end
                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("redgem.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("redgem.num",max_num)
                    end
            end,
        },
    --------------------------------------------------------
    -- 蓝色宝石
        ["bluegem"] = {        
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("bluegem.full") ~= true 
                and inst.replica.miraculous_machine_secret_scroll:Get("icestaff.full") then  --- 红色法杖之后才能放宝石
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local item_num = item.components.stackable.stacksize
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("bluegem.num",0)
                    local max_num = 15
                    if item_num + current_num > max_num then
                        local added_num = max_num - current_num
                        inst.components.miraculous_machine_secret_scroll:Set("bluegem.num",max_num)
                        inst.components.miraculous_machine_secret_scroll:Set("bluegem.full",true)
                        item.components.stackable:Get(added_num):Remove()
                    else
                        if inst.components.miraculous_machine_secret_scroll:Add("bluegem.num",item_num) >= max_num then
                            inst.components.miraculous_machine_secret_scroll:Set("bluegem.full",true)
                        end
                        item:Remove()
                    end
                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("bluegem.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("bluegem.num",max_num)
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
                    ---- 限制上限
                    local temp_num = inst.components.miraculous_machine_secret_scroll:Get("fireflies.num")
                    if temp_num and temp_num > max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("fireflies.num",max_num)
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
    -- 火法杖
        ["firestaff"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("firestaff.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("firestaff.num",1)
                    local max_num = 1
                    if current_num >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("firestaff.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("firestaff.num",max_num)
                    end
                    item:Remove()
            end,
        },
    --------------------------------------------------------
    -- 冰法杖
        ["icestaff"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("icestaff.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                    local current_num = inst.components.miraculous_machine_secret_scroll:Add("icestaff.num",1)
                    local max_num = 1
                    if current_num >= max_num then
                        inst.components.miraculous_machine_secret_scroll:Set("icestaff.full",true)
                        inst.components.miraculous_machine_secret_scroll:Set("icestaff.num",max_num)
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
                if inst.replica.miraculous_machine_secret_scroll:Get("axe_level.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)                    
                item:Remove()
                local axe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("axe_level.num",0) >= axe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.num",axe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 金斧头
        ["goldenaxe"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("axe_level.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local axe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("axe_level.num",10) >= axe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.num",axe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 玻璃斧头
        ["moonglassaxe"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("axe_level.full") ~= true then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local axe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("axe_level.num",100) >= axe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.num",axe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 斧镐
        ["multitool_axe_pickaxe"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("axe_level.full") ~= true 
                    or inst.replica.miraculous_machine_secret_scroll:Get("pickaxe_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local axe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("axe_level.num",150) >= axe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.num",axe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("axe_level.full",true)
                end

                local pickaxe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("pickaxe_level.num",150) >= pickaxe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.num",pickaxe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 矿镐
        ["pickaxe"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("pickaxe_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local pickaxe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("pickaxe_level.num",0) >= pickaxe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.num",pickaxe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 金矿镐
        ["goldenpickaxe"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("pickaxe_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local pickaxe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("pickaxe_level.num",10) >= pickaxe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.num",pickaxe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.full",true)
                end
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 铲子
        ["shovel"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("shovel_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("shovel_level.full",true)
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 金铲子
        ["goldenshovel"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("shovel_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("shovel_level.full",true)
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 亮茄铲子
        ["shovel_lunarplant"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("shovel_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("shovel_level.full",true)
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 锤子
        ["hammer"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("hammer_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("hammer_level.full",true)
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 亮茄锤子+矿镐
        ["pickaxe_lunarplant"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("pickaxe_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                local pickaxe_max_num = 1000
                if inst.components.miraculous_machine_secret_scroll:Add("pickaxe_level.num",200) >= pickaxe_max_num then
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.num",pickaxe_max_num)
                    inst.components.miraculous_machine_secret_scroll:Set("pickaxe_level.full",true)
                end
                inst.components.miraculous_machine_secret_scroll:Set("hammer_level.full",true)
                inst:PushEvent("tools_modules_upgrade")
            end,
        },
    --------------------------------------------------------
    -- 三叉戟
        ["trident"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("trident_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("trident_level.full",true)
            end,
        },
    --------------------------------------------------------
    -- 剃刀
        ["razor"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("razor_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("razor_level.full",true)
            end,
        },
    --------------------------------------------------------
    -- 沙漠护目镜
        ["deserthat"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("goggles_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("goggles_level.full",true)
            end,
        },
    --------------------------------------------------------
    -- 星象护目镜
        ["moonstorm_goggleshat"] = {
            test_fn = function(inst,item,doer)
                if inst.replica.miraculous_machine_secret_scroll:Get("goggles_level.full") ~= true  then
                    return true
                else
                    return false
                end
            end,
            on_accept_fn = function(inst,item,doer)
                item:Remove()
                inst.components.miraculous_machine_secret_scroll:Set("goggles_level.full",true)
            end,
        },
    --------------------------------------------------------

}