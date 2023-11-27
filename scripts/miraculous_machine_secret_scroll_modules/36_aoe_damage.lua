----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

AOE 伤害

    · 击杀【地下猪王】  daywalker
        · 击杀1只猪王后解锁【范围伤害】，攻击造成小范围aoe伤害（可被二连击触发）
        · 初始范围半径2，每击杀一只增加1点半径，最高半径5点（2.5个地皮）
        · 造成伤害为武器伤害的一半(主目标之外的所有目标)
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


        local function do_aoe_damage_without_target(attacker,target,range,damage)
            damage = (damage or 10)/2

            local x,y,z = target.Transform:GetWorldPosition()
            local canthavetags = { "FX","fx","companion","isdead","player","INLIMBO", "notarget", "noattack", "flight", "invisible", "playerghost" ,"chester","hutch","wall","structure"}
            local musthavetags = nil
            local musthaveoneoftags = {"pig","rabbit","animal","smallcreature","epic","monster","insect"}
            local ents = TheSim:FindEntities(x, 0, z, range, musthavetags, canthavetags, musthaveoneoftags)
            for k, temp_monster in pairs(ents) do
                if temp_monster ~= target and  temp_monster.components.combat then
                    temp_monster.components.combat:GetAttacked(attacker,damage)
                end
            end

        end

        inst:ListenForEvent("player_onhitother",function(_,_table)
            if _table.target then
                local daywalker_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.daywalker")
                if daywalker_num ~= nil then
                    daywalker_num = daywalker_num or 0
                    local range = 2 + (daywalker_num-1) * 1
                    if range > 5 then
                        range = 5
                    end
                    do_aoe_damage_without_target(_table.attacker,_table.target,range,_table.damage)
                end
            end
        end)



    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}