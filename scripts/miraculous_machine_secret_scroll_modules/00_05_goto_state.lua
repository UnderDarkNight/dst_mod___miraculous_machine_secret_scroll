----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 工具贴图动画切换
----------------------------------------------------------------------------------------------------------------------------------------------------------

-- local states_flag = {
--     ["fishing_pre"] = true,
-- }

local state_leave_states = {
    ["idle"] = true,
    ["run"] = true,
    ["run_stop"] = true,
    ["run_start"] = true,
}

local weapon_in_hand_cd_time = 10

local weapon_type_with_fn = {
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 橙色法杖
        ["switch.orange_staff"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "quicktele" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_staffs", "swap_orangestaff")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                                owner.AnimState:Hide("ARM_carry")
                                owner.AnimState:Show("ARM_normal")
                                owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end

        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 紫色法杖
        ["switch.purple_staff"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "castspell" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_staffs", "swap_purplestaff")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                                owner.AnimState:Hide("ARM_carry")
                                owner.AnimState:Show("ARM_normal")
                                owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil

                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end

        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 池钓
        ["switch.fishingrod"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "fishing_pre" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_fishingrod", "swap_fishingrod")
                            owner.AnimState:OverrideSymbol("fishingline", "swap_fishingrod", "fishingline")
                            owner.AnimState:OverrideSymbol("FX_fishing", "swap_fishingrod", "FX_fishing")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil

                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                                owner.AnimState:Hide("ARM_carry")
                                owner.AnimState:Show("ARM_normal")
                                owner.AnimState:ClearOverrideSymbol("fishingline")
                                owner.AnimState:ClearOverrideSymbol("FX_fishing")
                                owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil                            
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end

        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 海钓
        ["switch.ocean_fishingrod"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "oceanfishing_cast" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_fishingrod_ocean", "swap_fishingrod_ocean")
                            owner.AnimState:OverrideSymbol("fishingline", "swap_fishingrod_ocean", "fishingline")
                            owner.AnimState:OverrideSymbol("FX_fishing", "swap_fishingrod_ocean", "FX_fishing")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                                owner.AnimState:Hide("ARM_carry")
                                owner.AnimState:Show("ARM_normal")
                                owner.AnimState:ClearOverrideSymbol("fishingline")
                                owner.AnimState:ClearOverrideSymbol("FX_fishing")
                                owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 捕虫网
        ["switch.bugnet"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "bugnet_start" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_bugnet", "swap_bugnet")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end

                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                                owner.AnimState:Hide("ARM_carry")
                                owner.AnimState:Show("ARM_normal")
                                owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 三叉戟
        ["switch.trident"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "play_strum" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:Hide("ARM_carry")
                            owner.AnimState:Show("ARM_normal")
                            owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 远程武器
        ["switch.long_range_weapon"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "slingshot_shoot" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            owner.AnimState:OverrideSymbol("swap_object", "swap_slingshot", "swap_slingshot")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:Hide("ARM_carry")
                            owner.AnimState:Show("ARM_normal")
                            owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 近战武器
        ["switch.short_range_weapon"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "attack" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            owner.AnimState:OverrideSymbol("swap_object", "swap_nightmaresword", "swap_nightmaresword")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
                        owner._miraculous_machine_secret_scroll_state = nil
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        owner._miraculous_machine_secret_scroll__unequipt_fn = function()
                            ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:Hide("ARM_carry")
                            owner.AnimState:Show("ARM_normal")
                            owner.AnimState:ClearOverrideSymbol("swap_object")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}


local function player_statename(weapon_inst,owner,statename,weapon_type)
    print("info  player  statename",statename)
    if weapon_type_with_fn[weapon_type] then        
        weapon_type_with_fn[weapon_type](weapon_inst,owner,statename,weapon_type)
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        

        inst.___newstate_event_fn = function(player,_table)
            if _table and _table.statename then
                local weapon_type = inst.components.miraculous_machine_secret_scroll:Get("type")
                player_statename(inst,player,_table.statename,weapon_type)
            end
        end

        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                _table.owner:ListenForEvent("newstate",inst.___newstate_event_fn)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                _table.owner:RemoveEventCallback("newstate",inst.___newstate_event_fn)

                if _table.owner._miraculous_machine_secret_scroll__unequipt_fn then
                    _table.owner._miraculous_machine_secret_scroll__unequipt_fn()
                    _table.owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                end
                
            end
        end)

        ---- 切模式的时候瞬间清掉手上动画
        inst:ListenForEvent("weapon_type_changed",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                if _table.owner._miraculous_machine_secret_scroll__unequipt_fn then
                    _table.owner._miraculous_machine_secret_scroll__unequipt_fn()
                    _table.owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                end
                
            end
        end)


        
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
        
    end
    -----------------------------------------------------------------------------------------------------------------
}