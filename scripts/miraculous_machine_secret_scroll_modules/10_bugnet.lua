----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 捕虫网
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst._____bugnet_finishedwork_event_on_player = function(player,_table)
            -- workable : worker:PushEvent("finishedwork", { target = self.inst, action = self.action })
            if _table and _table.action and _table.action == ACTIONS.NET and _table.target and _table.target.prefab then
                ---- 100个 是 10%
                local fireflies_num = inst.components.miraculous_machine_secret_scroll:Add("fireflies.num",0)
                if math.random(1000)/1000 <= fireflies_num/1000 then
                    player.components.inventory:GiveItem(SpawnPrefab(_table.target.prefab))
                end
            end
        end

        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                _table.owner:ListenForEvent("finishedwork",inst._____bugnet_finishedwork_event_on_player)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                _table.owner:RemoveEventCallback("finishedwork",inst._____bugnet_finishedwork_event_on_player)
            end
        end)



        inst:ListenForEvent("switch.bugnet.start",function()
            if inst:HasTag("switch.bugnet") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.bugnet")
            print("info bugnet on")
            -----------------------------------------------------------------------------
                inst:AddTag("tool")
                inst:AddComponent("tool")
                inst.components.tool:SetAction(ACTIONS.NET)

                -- local owner = inst.components.inventoryitem:GetGrandOwner()
                -- if owner then
                --     owner:ListenForEvent("finishedwork",inst._____bugnet_finishedwork_event_on_player)
                -- end

            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.bugnet.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.bugnet")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.bugnet.stop",function()
            if not inst:HasTag("switch.bugnet") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.bugnet")
            print("info bugnet off")
            ------------------------------------------------------------------------
                inst:RemoveTag("tool")
                inst:RemoveComponent("tool")


                -- local owner = inst.components.inventoryitem:GetGrandOwner()
                -- if owner then
                --     owner:RemoveEventCallback("finishedwork",inst._____bugnet_finishedwork_event_on_player)
                -- end
            ------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.bugnet.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.bugnet.start.replica",function()
            print("switch.bugnet.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.bugnet")
        end)
        inst:ListenForEvent("switch.bugnet.stop.replica",function()
            print("switch.bugnet.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}