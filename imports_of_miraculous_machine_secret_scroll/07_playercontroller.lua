-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 地图跳跃
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddComponentPostInit("playercontroller", function(self)
    
    self.GetMapActions__mms_scroll_old = self.GetMapActions
    self.GetMapActions = function(self,position)
        local LMBaction, RMBaction = self.GetMapActions__mms_scroll_old(self, position)

        ----------------------------------------------------------------------------------------
                local inventory = self.inst.components.inventory or self.inst.replica.inventory
                if inventory and inventory:EquipHasTag("mms_scroll_blink_map") then
                    local equipments = self.inst.replica.inventory and self.inst.replica.inventory:GetEquips() or {}

                    -------- 获取装备，用于放到 act.invobject 里
                        local invobject = nil
                        for e_slot, e_item in pairs(equipments) do
                            if e_item and e_item:HasTag("mms_scroll_blink_map") then
                                invobject = e_item
                                break
                            end
                        end

                    local act = BufferedAction(self.inst, nil, ACTIONS.MMS_SCROLL_BLINK_MAP)
                    act.invobject = invobject
                    RMBaction = self:RemapMapAction(act, position)
                    return LMBaction, RMBaction
                end
        ----------------------------------------------------------------------------------------


        return LMBaction, RMBaction         
    end







    self.OnMapAction__mms_scroll_old = self.OnMapAction
    self.OnMapAction = function(self,actioncode, position)
        self:OnMapAction__mms_scroll_old(actioncode, position)
        ------------------------------------------------------------------------------------------
            local act = MOD_ACTIONS_BY_ACTION_CODE[STRINGS.MMS_SCROLL_BLINK_MAP][actioncode]
            if act == nil or not act.map_action then
                return
            end
            if self.ismastersim then

                        local LMBaction, RMBaction = self:GetMapActions(position)
                        if act.rmb and RMBaction then ---- 右键
                            -- print("error rmb",position)
                            -- for k, v in pairs(act) do
                            --     print(k,v)
                            -- end
                            -- print("error rmb ++++++ ",position)
                            -- for k, v in pairs(RMBaction or {}) do
                            --     print(k,v)
                            -- end
                            -- self:DoAction(BufferedAction(self.inst, nil, ACTIONS.MMS_SCROLL_BLINK_MAP))
                            -- self:DoAction(BufferedAction(self.inst,nil, RMBaction))
                            -- self:DoAction(RMBaction)
                            -- self.locomotor:PushAction(RMBaction, true)
                            RMBaction:Do()
                        end

            else
                SendRPCToServer(RPC.DoActionOnMap, actioncode, position.x, position.z)                
            end

            -- for k, v in pairs(act or {}) do
            --     print(k,v)
            -- end
            pcall(function()    --- 关闭地图
                        if act.rmb and act.id == "MMS_SCROLL_BLINK_MAP" and TheFrontEnd then
                            local map = TheFrontEnd:GetOpenScreenOfType("MapScreen")
                            map:Hide()
                            TheFrontEnd:PopScreen(map)
                        end
            end)

        ------------------------------------------------------------------------------------------

    end












end)