----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 注册物品置入组件
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        
        inst:AddComponent("mms_scroll_com_acceptable")
        inst.components.mms_scroll_com_acceptable:SetTestFn(function(inst,item,doer,right_click)
            
            return true
        end)

        inst.components.mms_scroll_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
            if not TheWorld.ismastersim then
                return
            end

            -- if item then
            --     item:Remove()
            -- end

            inst.components.miraculous_machine_secret_scroll:synchronized_data_2_replica()
            return true
        end)
        inst.components.mms_scroll_com_acceptable:SetSGAction("dolongaction")
        inst.components.mms_scroll_com_acceptable:SetActionDisplayStr("mms_scroll_com_acceptable","升级")
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        
    end
    -----------------------------------------------------------------------------------------------------------------
}