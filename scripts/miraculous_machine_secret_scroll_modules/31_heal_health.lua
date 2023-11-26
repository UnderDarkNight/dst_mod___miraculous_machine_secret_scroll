----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 回血
--[[
    · 击杀【双子魔眼】：  twinofterror1   twinofterror2
        · 击杀后开启【攻击回血】功能。初始：每次攻击 回血 0.5 点。
        · 每击杀1只，回血量 增加 0.3 点。最高2点（不可被二连击触发）
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst:ListenForEvent("heal_health_by_attack",function(_,player)
            if player.components.health then
                local boss_num = (inst.components.miraculous_machine_secret_scroll:Get("boss.kill.twinofterror1") or 0) + (inst.components.miraculous_machine_secret_scroll:Get("boss.kill.twinofterror2") or 0)
                if boss_num == 0 then
                    return
                end
                
                local heal_num = 0.5 + (boss_num - 1) * 0.3
                if heal_num > 2 then
                    player.components.health:DoDelta(heal_num,true)
                end
            end
        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}