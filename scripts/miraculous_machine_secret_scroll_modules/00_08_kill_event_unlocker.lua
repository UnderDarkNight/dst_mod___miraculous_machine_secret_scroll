----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 击杀解锁事件
----------------------------------------------------------------------------------------------------------------------------------------------------------
local monster_list = {  ---- 击杀怪物prefab列表

    ["walrus"] = true,                  -- 大海象
    ["little_walrus"] = true,           -- 小海象

    ["crawlingnightmare"] = true,       -- 洞里打架的影怪
    ["nightmarebeak"] = true,           -- 洞里打架的影怪

    ["crawlinghorror"] = true,       -- 低San的影怪
    ["terrorbeak"] = true,           -- 低San的影怪

    ["shadow_leech"] = true,              -- 影怪
    ["ruins_shadeling"] = true,           -- 影怪
    ["fused_shadeling"] = true,           -- 影怪

}
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
            inst:ListenForEvent("player_killed",function(_,_table)
                if _table and _table.target and _table.target.prefab then
                        if _table.target:HasTag("epic") then
                            local flag = "boss.kill.".._table.target.prefab
                            inst.components.miraculous_machine_secret_scroll:Add(flag,1)
                            inst:PushEvent("target_kill_count_end")
                            inst:PushEvent("boss_killed",_table.target)
                        else
                            if monster_list[_table.target.prefab] then
                                local flag = "monster.kill.".._table.target.prefab
                                inst.components.miraculous_machine_secret_scroll:Add(flag,1)
                                inst:PushEvent("target_kill_count_end")

                            end
                        end
                        inst:PushEvent("monster_killed",_table.target)
                end
            end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}