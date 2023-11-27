----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

霸体系统

    · 击杀【悲惨毒菌蟾蜍】：  toadstool_dark
        · 击杀1只后解锁【霸体】。每次被攻击都会有50%概率触发【霸体】。【霸体】期间不受到任何伤害。初始【霸体】持续时间为5s 。
        · 每击杀1只，【霸体】持续时间增加1s，概率增加2%。最多升级到10s 。60%概率。

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        --- attacker, damage, weapon, stimuli, spdamage

        inst.___getAttacked__fn = function(attacker, damage, weapon, stimuli, spdamage)
            ------------------------------------------------------------------------------------------
                if inst.___rigid_task == nil then

                    local toadstool_dark_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.toadstool_dark") or 0
                    if toadstool_dark_num > 0 then
                                    local probability = ( 0.5 + (toadstool_dark_num-1)*0.02)
                                    if probability > 0.6 then
                                        probability = 0.6
                                    end
                                    if math.random(10000)/10000 <= probability then
                                        ---- 持续时间
                                        local rigid_time = 5 + (toadstool_dark_num-1)
                                        if rigid_time > 10 then
                                            rigid_time = 10
                                        end

                                        inst.___rigid_task = inst:DoTaskInTime(rigid_time,function()
                                            inst.___rigid_task = nil
                                        end)
                                    end
                    end

                else
                    damage = 0
                    -- print("damage block",attacker, damage)
                end
            ------------------------------------------------------------------------------------------

            return attacker, damage, weapon, stimuli, spdamage
        end

        local function equip_hook(player)
            if player.components.combat then
                player.components.combat:mms_scroll_add_rigid_fn(inst.___getAttacked__fn)
            end
        end

        local function unequip_unhook(player)
            if player.components.combat then
                player.components.combat:mms_scroll_remove_rigid_fn(inst.___getAttacked__fn)
            end
        end


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                equip_hook(_table.owner)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                unequip_unhook(_table.owner)
            end
        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}