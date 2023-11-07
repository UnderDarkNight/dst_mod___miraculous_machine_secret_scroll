----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 注册RPC 事件信道，挂载去指定的inst。
---- 把函数挂载到  组件 miraculous_machine_secret_scroll 上面，回传服务器的API则挂到 replica
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
                inst.components.miraculous_machine_secret_scroll.RPC_PushEvent = function(self,event_name,cmd_table)
                    self.inst:DoTaskInTime(0,function()
                        
                                -- print("info RPC_PushEvent server2client",event_name,cmd_table)
                                if type(event_name) == "string" then
                                    local json_data = {}
                                    json_data.event_name = event_name
                                    json_data.cmd_table = cmd_table or {}
                                    -- local owner = self.inst.components.inventoryitem:GetGrandOwner()
                                    -- if owner and owner.userid then
                                    --     SendModRPCToClient(CLIENT_MOD_RPC["miraculous_machine_secret_scroll"]["pushevent.server2client"],owner.userid,inst,json.encode(json_data))
                                    -- end
                                    -- 使用广播形式发给全部玩家,虽然占用多了点资源，但是不容易出错。
                                    for k, the_player in pairs(AllPlayers) do
                                        if the_player and the_player.userid then
                                            SendModRPCToClient(CLIENT_MOD_RPC["miraculous_machine_secret_scroll"]["pushevent.server2client"],the_player.userid,inst,json.encode(json_data))
                                        end
                                    end
                                    -- self.inst:PushEvent(event_name,cmd_table)
                                end

                    end)

                end

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        local com = inst.replica.miraculous_machine_secret_scroll or inst.replica._.miraculous_machine_secret_scroll
        if com then
            com.RPC_PushEvent = function(self,event_name,cmd_table)
                -- print("info RPC_PushEvent client2server")

                if type(event_name) == "string" then
                    cmd_table = cmd_table or {}
                    if TheWorld.ismastersim then
                        self.inst:PushEvent(event_name,cmd_table)
                    else
                        SendModRPCToServer(MOD_RPC["miraculous_machine_secret_scroll"]["pushevent.client2server"],self.inst,event_name,json.encode(cmd_table))
                    end
                end

            end
        end
    end
    -----------------------------------------------------------------------------------------------------------------
}