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
            -------------------- 秒杀、上毒
                -- inst:ListenForEvent("player_onhitother",function(_,_table)
                --     if not inst:HasTag("switch.long_range_weapon") then
                --         return
                --     end
                --     local target = _table.target
                --     local attacker = _table.attacker
                --     local damage = _table.damage
                --     local weapon = _table.weapon
                --     -- print(" double attack event",attacker,target,damage,weapon)
                --     if not (target and attacker and damage and weapon) then
                --         return
                --     end
                --     if weapon ~= inst then
                --         return
                --     end

                --     -----------------------------------------------------------------------
                --     --- 秒杀
                --         inst:PushEvent("spike_target",target)
                --     -----------------------------------------------------------------------
                --     --- 上毒
                --         inst:PushEvent("bee_venom_2_target",target)
                --         inst:PushEvent("toadstool_venom_2_target",target)
                --     -----------------------------------------------------------------------
                --     --- 吸血
                --         inst:PushEvent("heal_health_by_attack",attacker)
                --     -----------------------------------------------------------------------
                -- end)



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
                        if inst:HasTag("max_level") then
                            arrow_inst:PushEvent("color","red")
                        end
                    end
                    inst._mms_scroll_arrow_onhit_fn = function(arrow_inst, attacker, target)    --- 给弹药 onhit 的函数（配合 弹药prefab ）
                        if target.components.combat then
                            local weapon_level = inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0)
                            if weapon_level > 10 then
                                weapon_level = 10
                            end
                            local damage = 30 + weapon_level*12 
                            target.components.combat:GetAttacked(attacker,damage,inst)    --- 每级伤害 +2
                            -----------------------------------------------------------------------
                            ----- 百分比伤害
                                -- inst:PushEvent("shadow_monster_kill.bow",{  
                                --     target = target,
                                --     damage = damage,
                                --     attacker = attacker,
                                --     range = inst.components.weapon.attackrange*2,
                                -- })
                                inst:PushEvent("dmg_target_by_percent",{
                                    target = target,
                                    attacker = attacker,
                                })
                            -----------------------------------------------------------------------
                            --- 秒杀
                                inst:PushEvent("spike_target",target)
                            -----------------------------------------------------------------------
                            --- 上毒
                                inst:PushEvent("bee_venom_2_target",target)
                                inst:PushEvent("toadstool_venom_2_target",target)
                            -----------------------------------------------------------------------
                            --- 吸血
                                inst:PushEvent("heal_health_by_attack",attacker)
                            -----------------------------------------------------------------------                                                
                            ---- 判断能否触发双重攻击
                                if inst.components.miraculous_machine_secret_scroll:Get("boss.kill.antlion") then
                                    -- 初始几率10%，每击杀一只，【二连击】的几率增加2%，最高20% 。 最多击杀 5 只 满
                                    local base_antlion_percent = 0.1
                                    local antlion_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.antlion")
                                    if antlion_num >= 5 then
                                        antlion_num = 5
                                    end

                                    if math.random(10000)/10000 <= (base_antlion_percent + antlion_num * 0.02) then
                                        -- print("成功判断 双重攻击")
                                        target:DoTaskInTime(0.2,function()
                                            target.components.combat:GetAttacked(attacker,damage,inst)    --- 每级伤害 +2
                                        end)
                                    end               
                                end
                            -----------------------------------------------------------------------
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