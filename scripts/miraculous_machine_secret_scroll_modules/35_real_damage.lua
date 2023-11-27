----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

真实伤害

    · 击杀【远古犀牛】  minotaur
        · 击杀1只犀牛后解锁【真实伤害】，攻击造成额外10点真实伤害（可被二连击触发）
        · 每击杀1只犀牛增加2点，最高20点真伤 .   6只 max
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


        inst:ListenForEvent("player_onhitother",function(_,_table)
            if _table.target and _table.target.components.health and not _table.target.components.health:IsDead() then
                local minotaur_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.minotaur")
                if minotaur_num then
                    minotaur_num = minotaur_num or 0
                    if minotaur_num > 6 then
                        minotaur_num = 6
                    end
                    local damage = -1*( 10 + (minotaur_num - 1)*2 )
                    _table.target.components.health:DoDelta(damage)
                    
                end
            end
        end)



    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}