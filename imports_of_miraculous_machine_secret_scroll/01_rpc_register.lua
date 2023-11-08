-- 本文件和 modmain.lua 同级别
-- 注册关键RPC


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------- RPC 下发 event 事件
    AddClientModRPCHandler("miraculous_machine_secret_scroll","pushevent.server2client",function(inst,data)
        -- print("error pushevent.server2client")
        if inst and data then
            local _table = json.decode(data)
            if _table and _table.event_name then
                -- print("info pushevent.server2client ",inst,_table.event_name,_table.cmd_table)
                inst:PushEvent(_table.event_name,_table.cmd_table or {})
            end
        end
    end)
    -- SendModRPCToClient(CLIENT_MOD_RPC[miraculous_machine_secret_scroll]["pushevent.server2client"],player.userid,inst,json.encode(json_data))
    -- 给 指定userid 的客户端发送RPC
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------- RPC 上传 event 事件
    AddModRPCHandler("miraculous_machine_secret_scroll", "pushevent.client2server", function(player_inst,inst,event_name,data_json) ----- Register on the server
        -- user in client : inst.replica.fwd_in_pdt_func:PushEvent("event_name",data)
        -- 客户端回传 event 给 服务端,player_inst 为来源玩家客户端。
        if inst and inst.PushEvent and event_name then
            local data = nil
            if data_json then
                data = json.decode(data_json)
            end
            inst:PushEvent(event_name,data)
        end
    end)
    -- SendModRPCToServer(MOD_RPC["miraculous_machine_secret_scroll"]["pushevent.client2server"],self.inst,event_name,json.encode(data_table))
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
