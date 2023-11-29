----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 近战武器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

            local function weapon_level_changed_event_fn()
                local weapon_level = inst.components.miraculous_machine_secret_scroll:Add("weapon_level.num",0)
                inst.components.weapon:SetDamage(45 + weapon_level*2 )


                local goldnugget_num = inst.components.miraculous_machine_secret_scroll:Add("goldnugget.num",0)
                local attack_range = 1 + goldnugget_num * 0.01
                inst.components.weapon.attackrange = attack_range
                inst.components.weapon.hitrange = attack_range

            end

            -------------------- 二连击，秒杀、吸血
                inst:ListenForEvent("player_onhitother",function(_,_table)
                    if not inst:HasTag("switch.short_range_weapon") then
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
                        if not inst:HasTag("switch.short_range_weapon.is_double_attack") then --- 不会被双重攻击触发
                            inst:PushEvent("spike_target",target)
                        end
                    -----------------------------------------------------------------------
                    --- 上毒
                        if not inst:HasTag("switch.short_range_weapon.is_double_attack") then --- 不会被双重攻击触发
                                inst:PushEvent("bee_venom_2_target",target)
                                inst:PushEvent("toadstool_venom_2_target",target)
                        end
                    -----------------------------------------------------------------------
                    --- 回血
                        if not inst:HasTag("switch.short_range_weapon.is_double_attack") then --- 不会被双重攻击触发
                                inst:PushEvent("heal_health_by_attack",attacker)
                        end
                    -----------------------------------------------------------------------
                    --- 影怪
                        if not inst:HasTag("switch.short_range_weapon.is_double_attack") then --- 不会被双重攻击触发
                                inst:PushEvent("shadow_monster_kill.sword",target)
                        end
                    -----------------------------------------------------------------------
                    -----------------------------------------------------------------------



                    --------------------------------------------
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
                            else
                                return
                            end
                        else
                            return    
                        end
                    --------------------------------------------
                    ---- 程序锁，避免无限重复触发
                        if inst:HasTag("switch.short_range_weapon.is_double_attack") then
                            inst:RemoveTag("switch.short_range_weapon.is_double_attack")
                            -- print("info 【近战】跳过二连击重复触发判定")
                            return
                        end
                        -- print("info 【近战】进入二连击重复触发判定")
                    --------------------------------------------
                        if target.components.health and target.components.combat then
                            inst:AddTag("switch.short_range_weapon.is_double_attack")
                            attacker:DoTaskInTime(0.2,function()
                                target.components.combat:GetAttacked(attacker,damage,inst)                                
                            end)
                        end
                    -----------------------------------------------------------------------

                end)
            ------------------------------------------------------------------------------------------
            inst:ListenForEvent("switch.short_range_weapon.start",function()
                if inst:HasTag("switch.short_range_weapon") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.short_range_weapon")
                print("info short_range_weapon on")
                -----------------------------------------------------------------------------
                    inst:AddTag("weapon")
                    -- local attack_range = 1
                    -- local weapon_level = inst.components.miraculous_machine_secret_scroll:Get("weapon_level.num") or 0
                    -- inst.components.weapon:SetDamage(45 + weapon_level*2 )
                    -- inst.components.weapon.attackrange = attack_range
                    -- inst.components.weapon.hitrange = attack_range
                    weapon_level_changed_event_fn()

                    inst:ListenForEvent("weapon_level.changed",weapon_level_changed_event_fn)
                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.short_range_weapon.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.short_range_weapon")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.short_range_weapon.stop",function()
                if not inst:HasTag("switch.short_range_weapon") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.short_range_weapon")
                print("info short_range_weapon off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("weapon")
                    inst.components.weapon:_scroll_init()
                    inst:RemoveEventCallback("weapon_level.changed",weapon_level_changed_event_fn)
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.short_range_weapon.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.short_range_weapon.start.replica",function()
            print("switch.short_range_weapon.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.short_range_weapon")
        end)
        inst:ListenForEvent("switch.short_range_weapon.stop.replica",function()
            print("switch.short_range_weapon.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}