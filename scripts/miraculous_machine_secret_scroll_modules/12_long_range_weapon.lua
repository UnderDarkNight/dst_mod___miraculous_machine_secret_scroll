----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 远程武器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

            local function SetOnProjectileLaunch(inst, attacker, target)     -- 子弹发射 前
                print("SetOnProjectileLaunch",attacker,target)                
            end
            local function OnProjectileLaunched(inst, attacker, target)     -- 子弹发射 后
                print("OnProjectileLaunched",attacker,target)                
            end

            local function weapon_level_changed_event_fn()

                local silk_num = inst.components.miraculous_machine_secret_scroll:Add("silk.num",0)
                local attack_range = 10 + silk_num * 0.025
                inst.components.weapon.attackrange = attack_range
                inst.components.weapon.hitrange = attack_range

            end
            ------------------------------------------------------------------------------------------------
            -------------------- 秒杀
                inst:ListenForEvent("player_onhitother",function(_,_table)
                    if not inst:HasTag("switch.long_range_weapon") then
                        return
                    end
                    local target = _table.target
                    local attacker = _table.attacker
                    local damage = _table.damage
                    local weapon = _table.weapon
                    -- print(" double attack event",attacker,target,damage,weapon)
                    if not (target and attacker and damage and weapon) then
                        return
                    end
                    if weapon ~= inst then
                        return
                    end

                    -----------------------------------------------------------------------
                    --- 秒杀
                        if inst.components.miraculous_machine_secret_scroll:Get("firestaff.full") then
                            local redgem_num = inst.components.miraculous_machine_secret_scroll:Add("redgem.num",0)
                            --- 初始概率1%，每给予一颗红宝石增加0.1%的概率，最高2%   最多喂食10个
                            local base_redgem_percent = 0.01
                            if math.random(10000)/10000 < (base_redgem_percent + redgem_num*0.001) then
                                if target.components.health and target.components.combat then
                                    local max_health = target.components.health.maxhealth
                                    target.components.combat:GetAttacked(attacker,max_health,inst)
                                end
                                return
                            end
                        end
                    -----------------------------------------------------------------------
                end)



            ------------------------------------------------------------------------------------------------

            inst:ListenForEvent("switch.long_range_weapon.start",function()
                if inst:HasTag("switch.long_range_weapon") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.long_range_weapon")
                print("info long_range_weapon on")
                -----------------------------------------------------------------------------
                    inst:AddTag("rangedweapon")
                    inst:AddTag("slingshot")
                    inst:AddTag("weapon")
                    inst.components.weapon:SetDamage(0)
                    -- inst.components.weapon:SetRange(TUNING.SLINGSHOT_DISTANCE, TUNING.SLINGSHOT_DISTANCE_MAX)
                    -- inst.components.weapon.attackrange = 10
                    -- inst.components.weapon.hitrange = 10
                    weapon_level_changed_event_fn()

                    inst.components.weapon:SetOnProjectileLaunch(SetOnProjectileLaunch)    --- 子弹发射前
                    inst.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched)    --- 子弹发射后
                    inst.components.weapon:SetProjectile("mms_scroll_arrow")   --- 弹药的prefab

                    inst._mms_scroll_arrow_init_fn = function(arrow_inst)       --- 箭创建的时候初始化,用于外观修改
                        arrow_inst:PushEvent("color","red")
                    end
                    inst._mms_scroll_arrow_onhit_fn = function(arrow_inst, attacker, target)    --- 给弹药 onhit 的函数（配合 弹药prefab ）
                        if target.components.combat then
                            local weapon_level = inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0)
                            target.components.combat:GetAttacked(attacker,30 + weapon_level*2 ,inst)    --- 每级伤害 +2
                        end
                    end

                    inst:ListenForEvent("weapon_level.changed",weapon_level_changed_event_fn)
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.long_range_weapon.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.long_range_weapon")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.long_range_weapon.stop",function()
                if not inst:HasTag("switch.long_range_weapon") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.long_range_weapon")
                print("info long_range_weapon off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("rangedweapon")
                    inst:RemoveTag("slingshot")
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                    inst._mms_scroll_arrow_init_fn = nil
                    inst._mms_scroll_arrow_onhit_fn = nil


                    inst:RemoveEventCallback("weapon_level.changed",weapon_level_changed_event_fn)
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.long_range_weapon.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.long_range_weapon.start.replica",function()
            print("switch.long_range_weapon.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.long_range_weapon")
        end)
        inst:ListenForEvent("switch.long_range_weapon.stop.replica",function()
            print("switch.long_range_weapon.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}