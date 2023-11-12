----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 工具
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


            inst:ListenForEvent("switch.tools.start",function()
                if inst:HasTag("switch.tools") then    ---- 避免重复切换
                    return
                end
                inst:AddTag("switch.tools")
                print("info tools on")
                -----------------------------------------------------------------------------
                    inst:AddTag("tool")
                    inst:AddTag("weapon")
                    inst:AddComponent("tool")

                    ---- 斧头
                        local axe_percentages  = inst.components.miraculous_machine_secret_scroll:Get("axe") or 1
                        inst.components.tool:SetAction(ACTIONS.CHOP,axe_percentages)
                    ---- 锤子
                        inst.components.tool:SetAction(ACTIONS.HAMMER)
                    ---- 矿锄
                        inst.components.tool:SetAction(ACTIONS.MINE)
                    ---- 铲子
                        inst.components.tool:SetAction(ACTIONS.DIG)
                        inst:AddInherentAction(ACTIONS.DIG)
                    ---- 园艺锄
                        inst:AddComponent("farmtiller")
                        inst:AddInherentAction(ACTIONS.TILL)


                -----------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.tools.start.replica")
                inst.components.miraculous_machine_secret_scroll:Set("type","switch.tools")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
            end)

            inst:ListenForEvent("switch.tools.stop",function()
                if not inst:HasTag("switch.tools") then    --- 避免意外拆除组件
                    return
                end
                inst:RemoveTag("switch.tools")
                print("info tools off")
                ------------------------------------------------------------------------
                    inst:RemoveTag("tool")
                    inst:RemoveTag("weapon")

                    inst:RemoveComponent("farmtiller")
                    inst:RemoveComponent("tool")
                    inst:RemoveInherentAction(ACTIONS.DIG)
                    inst:RemoveInherentAction(ACTIONS.TILL)
                
                ------------------------------------------------------------------------

                inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.tools.stop.replica")

            end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.tools.start.replica",function()
            print("switch.tools.start.replica")
            ----------------------------------------------------------------------------------
                
            ----------------------------------------------------------------------------------
            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.tools")
        end)
        inst:ListenForEvent("switch.tools.stop.replica",function()
            print("switch.tools.stop.replica")
            ----------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------
        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}