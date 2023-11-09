----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 捕虫网
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

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
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.trident")
        end)
        inst:ListenForEvent("switch.bugnet.stop.replica",function()
            print("switch.bugnet.stop.replica")
            ----------------------------------------------------------------------------------
                inst:RemoveTag("tool")
            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}