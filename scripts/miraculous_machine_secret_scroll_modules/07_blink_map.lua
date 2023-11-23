----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 地图跃迁
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


        inst.components.miraculous_machine_secret_scroll.blink_map = function(self,doer,pt)
            if not self.inst.components.rechargeable:IsCharged() then
                return false
            end
            ------------ 冷却时间
                local purplegem_num = inst.components.miraculous_machine_secret_scroll:Add("purplegem.num",0)
                local cooldown_time = 30 - purplegem_num
                if cooldown_time ~= 0 then
                    self.inst.components.rechargeable:Discharge(cooldown_time)
                end
            ----------- Sanity
                ---- 【imports_of_miraculous_machine_secret_scroll\05_action_blink_map.lua】 里进行 另外限制
                if doer.components.sanity then
                    doer.components.sanity:DoDelta(-50)
                end


                -- act.doer.sg:GoToState("portal_jumpin_mms_scroll", {dest = act_pos, from_map = true,})
            if doer and doer.sg then                
                doer.sg:GoToState("portal_jumpin_mms_scroll", {dest = pt, from_map = true,})
            end
            return true
        end


        inst:ListenForEvent("switch.blink_map.start",function()
            if inst:HasTag("switch.blink_map") then    ---- 避免重复切换
                return
            end
            inst:AddTag("switch.blink_map")
            print("info blink_map on")
            -----------------------------------------------------------------------------
                inst:AddTag("mms_scroll_blink_map")
                local cool_down_time = 5
                inst.components.rechargeable:SetMaxCharge(cool_down_time)
            -----------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.blink_map.start.replica")
            inst.components.miraculous_machine_secret_scroll:Set("type","switch.blink_map")    --- 记录目前的模式，给存档重载、穿越洞穴的时候调用
        end)

        inst:ListenForEvent("switch.blink_map.stop",function()
            if not inst:HasTag("switch.blink_map") then    --- 避免意外拆除组件
                return
            end
            inst:RemoveTag("switch.blink_map")
            print("info blink_map off")
            ------------------------------------------------------------------------
                inst:RemoveTag("mms_scroll_blink_map")

            ------------------------------------------------------------------------

            inst.components.miraculous_machine_secret_scroll:RPC_PushEvent("switch.blink_map.stop.replica")

        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        inst:ListenForEvent("switch.blink_map.start.replica",function()
            print("switch.blink_map.start.replica")
            

            inst.replica.miraculous_machine_secret_scroll:Set("type","switch.blink_map")
        end)
        inst:ListenForEvent("switch.blink_map.stop.replica",function()
            print("switch.blink_map.stop.replica")

        end)
    end
    -----------------------------------------------------------------------------------------------------------------
}