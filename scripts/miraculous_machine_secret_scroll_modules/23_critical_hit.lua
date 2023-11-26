----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 暴击
--[[
    · 【完成】击杀【克劳斯】：  klaus
            · 击杀一只后解锁【暴击】每次攻击都会有几率造成200%伤害（可被二连击触发）
            · 初始几率10%每击杀一只 ， 【暴击】的几率增加5%，最高30%的几率 。最多击杀 5 只
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)



        inst:ListenForEvent("player_onhitother",function(_,_table)

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
            ---- 避免无限重复暴击
                if inst:HasTag("weapon_critical_hit") then
                    inst:RemoveTag("weapon_critical_hit")
                    return
                end
            -----------------------------------------------------------------------
                if inst.components.miraculous_machine_secret_scroll:Get("boss.kill.klaus") then
                    local boss_num = inst.components.miraculous_machine_secret_scroll:Add("boss.kill.klaus",0)
                    if boss_num >= 5 then
                        boss_num = 5
                    end
                    -- 初始几率10%每击杀一只 ， 【暴击】的几率增加5%，最高30%的几率 。最多击杀 5 只
                    local base_percent = 0.1
                    if math.random(1000)/1000 <= ( base_percent + (0.05 * boss_num-1) ) and target.components.combat then
                        inst:AddTag("weapon_critical_hit")
                        target.components.combat:GetAttacked(attacker,damage,inst)
                    end
                end
            -----------------------------------------------------------------------



        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}