----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 玩家的工具完成事件，转发给武器 inst
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        

        inst.___player_finishedwork_event_fn = function(player,_table)
            -- worker:PushEvent("finishedwork", { target = self.inst, action = self.action })
            if _table and _table.target then
                inst:PushEvent("player_finishedwork",{
                    target = _table.target,
                    doer = player,
                    action = _table.action,
                })
            end
        end


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:ListenForEvent("finishedwork",inst.___player_finishedwork_event_fn)    --- 在玩家身上挂上 event 监听
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                _table.owner:RemoveEventCallback("finishedwork",inst.___player_finishedwork_event_fn)   --- 移除挂在玩家身上的 event 监听

            end
        end)


    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    
    end
    -----------------------------------------------------------------------------------------------------------------
}