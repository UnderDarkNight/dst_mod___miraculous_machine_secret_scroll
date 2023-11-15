----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 玩家的攻击 event  对武器 push 。用于记录 相关的击杀 和伤害量
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        

        inst.___player_onhitother_event_fn = function(player,_table)
            -- attacker:PushEvent("onhitother", { target = self.inst, damage = damage, damageresolved = damageresolved, stimuli = stimuli, spdamage = spdamage, weapon = weapon, redirected = damageredirecttarget })
            if _table and _table.damage and _table.target then
                local _cmd_table = {
                    attacker = player
                }
                for k, v in pairs(_table) do
                    _cmd_table[k] = v
                end
                inst:PushEvent("player_onhitother",_cmd_table)      ----------   往武器inst push 的 event
            end
        end

        inst.___player_kill_other_event_fn = function(player,_table)
            -- attacker:PushEvent("killed", { victim = self.inst, attacker = attacker })
            if _table and _table.victim and _table.attacker then
                inst:PushEvent("player_killed",{                    ----------   往武器inst push 的 event
                    target = _table.victim,
                    attacker = _table.attacker,
                })
            end
        end

        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:ListenForEvent("onhitother",inst.___player_onhitother_event_fn)    --- 在玩家身上挂上 event 监听
                _table.owner:ListenForEvent("killed",inst.___player_kill_other_event_fn)        --- 在玩家身上挂上 event 监听
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:RemoveEventCallback("onhitother",inst.___player_onhitother_event_fn)   --- 移除挂在玩家身上的 event 监听
                _table.owner:RemoveEventCallback("killed",inst.___player_kill_other_event_fn)       --- 移除挂在玩家身上的 event 监听

            end
        end)


    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    
    end
    -----------------------------------------------------------------------------------------------------------------
}