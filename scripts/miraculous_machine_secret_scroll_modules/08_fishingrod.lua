----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 普通钓鱼
---- 组件拆卸会造成崩溃，尝试让组件常驻，通过其他方法屏蔽
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst.___fishingcollect_event_fn = function(inst,_table)  --- 钓鱼成功后执行的event
            -- self.inst:PushEvent("fishingcollect", {fish = self.caughtfish} )
            if _table and _table.fish and _table.fish.prefab then
                if _table.fish.prefab == "pondeel" or _table.fish.prefab == "pondfish" then
                    if inst.components.miraculous_machine_secret_scroll:Add("fishingrod_level.num",1) >= 100 then
                        inst.components.miraculous_machine_secret_scroll:Set("fishingrod_level.full",true)
                    end
                end

                if inst.components.miraculous_machine_secret_scroll:Get("fishingrod_level.full") then
                    inst:DoTaskInTime(0.8,function()
                        SpawnPrefab(_table.fish.prefab).Transform:SetPosition(_table.fish.Transform:GetWorldPosition())
                    end)
                end

            end
        end

        inst:AddTag("fishingrod")
        inst:AddTag("allow_action_on_impassable")
        inst:AddComponent("fishingrod")
        inst.components.fishingrod:SetWaitTimes(1, 10)
        inst.components.fishingrod:SetStrainTimes(0, 5)
        inst:ListenForEvent("fishingcollect",inst.___fishingcollect_event_fn)
        inst:RemoveTag("fishingrod")




        inst:ListenForEvent("switch.fishingrod.start",function()
            if inst:HasTag("switch.fishingrod") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.fishingrod")
            print("info fishingrod on")
            -----------------------------------------------------------------------------
                -- inst:AddTag("fishingrod")
                -- inst:AddTag("allow_action_on_impassable")
                -- inst:AddComponent("fishingrod")
                -- inst.components.fishingrod:SetWaitTimes(4, 40)
                -- inst.components.fishingrod:SetStrainTimes(0, 5)
                -- inst:ListenForEvent("fishingcollect",inst.___fishingcollect_event_fn)
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.fishingrod.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.fishingrod")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.fishingrod.stop",function()
            if not inst:HasTag("switch.fishingrod") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.fishingrod")
            print("info fishingrod off")
            ------------------------------------------------------------------------
                -- inst:RemoveTag("fishingrod")
                -- inst:RemoveTag("allow_action_on_impassable")
                -- inst:RemoveComponent("fishingrod")
                -- inst:RemoveEventCallback("fishingcollect",inst.___fishingcollect_event_fn)
            ------------------------------------------------------------------------
            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.fishingrod.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

        inst:DoTaskInTime(0,function()
            
            ------------- hook 关键函数
                rawset(inst.replica.fishingrod,"HasCaughtFish",function(self,...)
                    if not self.inst:HasTag("switch.fishingrod") then
                        return true
                    end                                
                    return self._hascaughtfish:value()
                end)


        end)

        
        inst:ListenForEvent("switch.fishingrod.start.replica",function()
            print("switch.fishingrod.start.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.fishingrod")
        end)
        inst:ListenForEvent("switch.fishingrod.stop.replica",function()
            print("switch.fishingrod.stop.replica")

            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)

    end
    -----------------------------------------------------------------------------------------------------------------
}