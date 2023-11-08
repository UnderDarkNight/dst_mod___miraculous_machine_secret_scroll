----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 容器组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        inst:AddComponent("container")
        inst.components.container:WidgetSetup("oceanfishingrod")
        inst:ListenForEvent("unequipped",function()
            inst.components.container:Close()
            inst.components.container.canbeopened = false
        end)
        inst:ListenForEvent("equipped",function()
            inst.components.container.canbeopened = false            
        end)        
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        local com = inst.replica.container or inst.replica._.container
        if com then
            com:WidgetSetup("oceanfishingrod")
        end
    end
    -----------------------------------------------------------------------------------------------------------------
}