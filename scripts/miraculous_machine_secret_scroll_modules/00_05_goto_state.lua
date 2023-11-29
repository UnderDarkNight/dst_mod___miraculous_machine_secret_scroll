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
        -- ["switch.orange_staff"] = function(weapon_inst,owner,statename,weapon_type)
        --     if statename == "quicktele" and owner._miraculous_machine_secret_scroll_state ~= statename then
        --                 owner._miraculous_machine_secret_scroll_state = statename
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     owner.AnimState:OverrideSymbol("swap_object", "swap_staffs", "swap_orangestaff")
        --                     owner.AnimState:Show("ARM_carry")
        --                     owner.AnimState:Hide("ARM_normal")
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     weapon_inst:PushEvent("weapon_in_hand","switch.orange_staff")
        --                 ---------------------------------------------------------------------------------------------------------------------


        --     elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
        --                 owner._miraculous_machine_secret_scroll_state = nil
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 owner._miraculous_machine_secret_scroll__unequipt_fn = function()
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                         owner.AnimState:Hide("ARM_carry")
        --                         owner.AnimState:Show("ARM_normal")
        --                         owner.AnimState:ClearOverrideSymbol("swap_object")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                         weapon_inst:PushEvent("weapon_in_hand","off")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     owner._miraculous_machine_secret_scroll__unequipt_fn = nil
        --                 end
        --                 owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

        --     end

        -- end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 紫色法杖
        -- ["switch.purple_staff"] = function(weapon_inst,owner,statename,weapon_type)
        --     if statename == "castspell" and owner._miraculous_machine_secret_scroll_state ~= statename then
        --                 owner._miraculous_machine_secret_scroll_state = statename
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     owner.AnimState:OverrideSymbol("swap_object", "swap_staffs", "swap_purplestaff")
        --                     owner.AnimState:Show("ARM_carry")
        --                     owner.AnimState:Hide("ARM_normal")
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     weapon_inst:PushEvent("weapon_in_hand","switch.purple_staff")
        --                 ---------------------------------------------------------------------------------------------------------------------
                        

        --     elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
        --                 owner._miraculous_machine_secret_scroll_state = nil
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 owner._miraculous_machine_secret_scroll__unequipt_fn = function()
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                         owner.AnimState:Hide("ARM_carry")
        --                         owner.AnimState:Show("ARM_normal")
        --                         owner.AnimState:ClearOverrideSymbol("swap_object")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                         weapon_inst:PushEvent("weapon_in_hand","off")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     owner._miraculous_machine_secret_scroll__unequipt_fn = nil

        --                 end
        --                 owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

        --     end

        -- end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 池钓
        ["switch.fishingrod"] = function(weapon_inst,owner,statename,weapon_type)
            local fishing_states = {
                ["fishing_nibble"] = true,
                ["fishing_pre"] = true,
                ["fishing"] = true,
                ["fishing_pst"] = true,
            }
            if fishing_states[statename] and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_fishingrod_red" or "mms_scroll_fishingrod_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_fishingrod")
                            owner.AnimState:OverrideSymbol("fishingline", build, "fishingline")
                            owner.AnimState:OverrideSymbol("FX_fishing", build, "FX_fishing")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.fishingrod")
                        ---------------------------------------------------------------------------------------------------------------------


            elseif not fishing_states[statename] and state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
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
                                weapon_inst:PushEvent("weapon_in_hand","off")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil                            
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end

        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 海钓
        -- ["switch.ocean_fishingrod"] = function(weapon_inst,owner,statename,weapon_type)
        --     if statename == "oceanfishing_cast" and owner._miraculous_machine_secret_scroll_state ~= statename then
        --                 owner._miraculous_machine_secret_scroll_state = statename
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     owner.AnimState:OverrideSymbol("swap_object", "swap_fishingrod_ocean", "swap_fishingrod_ocean")
        --                     owner.AnimState:OverrideSymbol("fishingline", "swap_fishingrod_ocean", "fishingline")
        --                     owner.AnimState:OverrideSymbol("FX_fishing", "swap_fishingrod_ocean", "FX_fishing")
        --                     owner.AnimState:Show("ARM_carry")
        --                     owner.AnimState:Hide("ARM_normal")
        --                 ---------------------------------------------------------------------------------------------------------------------


        --     elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
        --                 owner._miraculous_machine_secret_scroll_state = nil
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 owner._miraculous_machine_secret_scroll__unequipt_fn = function()
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                         owner.AnimState:Hide("ARM_carry")
        --                         owner.AnimState:Show("ARM_normal")
        --                         owner.AnimState:ClearOverrideSymbol("fishingline")
        --                         owner.AnimState:ClearOverrideSymbol("FX_fishing")
        --                         owner.AnimState:ClearOverrideSymbol("swap_object")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     owner._miraculous_machine_secret_scroll__unequipt_fn = nil
        --                 end
        --                 owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

        --     end
        -- end,
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
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_bugnet", "swap_bugnet")
                            -- owner.AnimState:OverrideSymbol("swap_object", "mms_scroll_bugnet_red", "swap_bugnet")
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_bugnet_red" or "mms_scroll_bugnet_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_bugnet")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.bugnet")
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
                                weapon_inst:PushEvent("weapon_in_hand","off")
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
            if (statename == "play_strum" or statename == "attack" ) and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_trident_red" or "mms_scroll_trident_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.trident")
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
                                weapon_inst:PushEvent("weapon_in_hand","off")
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
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_bow_red" or "mms_scroll_bow_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                            -- owner.AnimState:OverrideSymbol("swap_object", "mms_scroll_bow_red", "swap_object")
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_slingshot", "swap_slingshot")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.long_range_weapon")
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
                            weapon_inst:PushEvent("weapon_in_hand","off")
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
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_sword_red" or "mms_scroll_sword_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.short_range_weapon")
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
                            weapon_inst:PushEvent("weapon_in_hand","off")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 工具
        ["switch.tools"] = function(weapon_inst,owner,statename,weapon_type)
            local states = {
                ["chop_start"] = "chop",        --- 斧头
                ["mine_start"] = "mine",        --- 矿锄
                ["hammer_start"] = "hammer",    --- 锤子
                ["dig_start"] = "dig",          --- 铲子
                ["till_start"] = "till",        --- 园艺锄
            }
            ----------------------------------------------------------
            --- 园艺锄的动作有点特殊
                if statename == "till_start" then
                    owner.AnimState:PlayAnimation("till_pre")
                elseif statename == "till" then
                    owner.AnimState:PlayAnimation("till_loop")                
                end
            ----------------------------------------------------------
            
            if states[statename] and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            local fns = {
                                ["chop"] = function()   --- 斧头
                                    local build = weapon_inst:HasTag("max_level") and "mms_scroll_axe_red" or "mms_scroll_axe_blue"
                                    owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                                end,
                                ["mine"] = function()   --- 矿锄
                                    local build = weapon_inst:HasTag("max_level") and "mms_scroll_pickaxe_red" or "mms_scroll_pickaxe_blue"
                                    owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                                end,
                                ["hammer"] = function()   --- 锤子
                                    local build = weapon_inst:HasTag("max_level") and "mms_scroll_hammer_red" or "mms_scroll_hammer_blue"
                                    owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                                end,
                                ["dig"] = function()   --- 铲子
                                    local build = weapon_inst:HasTag("max_level") and "mms_scroll_shovel_red" or "mms_scroll_shovel_blue"
                                    owner.AnimState:OverrideSymbol("swap_object", build, "swap_shovel")
                                end,
                                ["till"] = function()   --- 园艺锄
                                    local build = weapon_inst:HasTag("max_level") and "mms_scroll_till_red" or "mms_scroll_till_blue"
                                    owner.AnimState:OverrideSymbol("swap_object", build, "swap_quagmire_hoe")
                                end,
                            }
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            -- owner.AnimState:OverrideSymbol("swap_object", "mms_scroll_sword_blue", "swap_object")
                            if fns[tostring(states[statename])] then
                                fns[tostring(states[statename])]()
                            end
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.tools")
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
                                weapon_inst:PushEvent("weapon_in_hand","off")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 冰杖
        -- ["switch.ice_staff"] = function(weapon_inst,owner,statename,weapon_type)
        --     if statename == "attack" and owner._miraculous_machine_secret_scroll_state ~= statename then
        --                 owner._miraculous_machine_secret_scroll_state = statename
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
        --                     owner.AnimState:OverrideSymbol("swap_object", "swap_staffs", "swap_bluestaff")
        --                     owner.AnimState:Show("ARM_carry")
        --                     owner.AnimState:Hide("ARM_normal")
        --                 ---------------------------------------------------------------------------------------------------------------------
        --                     weapon_inst:PushEvent("weapon_in_hand","switch.ice_staff")
        --                 ---------------------------------------------------------------------------------------------------------------------


        --     elseif state_leave_states[statename] and owner._miraculous_machine_secret_scroll_state ~= nil then
        --                 owner._miraculous_machine_secret_scroll_state = nil
        --                 if owner._miraculous_machine_secret_scroll_task then
        --                     owner._miraculous_machine_secret_scroll_task:Cancel()
        --                 end
        --                 owner._miraculous_machine_secret_scroll__unequipt_fn = function()
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     owner.AnimState:Hide("ARM_carry")
        --                     owner.AnimState:Show("ARM_normal")
        --                     owner.AnimState:ClearOverrideSymbol("swap_object")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     weapon_inst:PushEvent("weapon_in_hand","off")
        --                     ---------------------------------------------------------------------------------------------------------------------
        --                     owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
        --                 end
        --                 owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

        --     end
        -- end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 剃刀
        ["switch.razor"] = function(weapon_inst,owner,statename,weapon_type)
            if statename == "attack" and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            -- owner.AnimState:OverrideSymbol("swap_object", "swap_trident", "swap_trident")
                            -- owner.AnimState:OverrideSymbol("swap_object", "mms_scroll_sword_blue", "swap_object")
                            local build = weapon_inst:HasTag("max_level") and "mms_scroll_razor_red" or "mms_scroll_razor_blue"
                            owner.AnimState:OverrideSymbol("swap_object", build, "swap_object")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.razor")
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
                            weapon_inst:PushEvent("weapon_in_hand","off")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------- 乐器
        ["switch.music"] = function(weapon_inst,owner,statename,weapon_type)
            if (statename == "enter_onemanband" or statename == "play_onemanband") and owner._miraculous_machine_secret_scroll_state ~= statename then
                        owner._miraculous_machine_secret_scroll_state = statename
                        if owner._miraculous_machine_secret_scroll_task then
                            owner._miraculous_machine_secret_scroll_task:Cancel()
                        end
                        ---------------------------------------------------------------------------------------------------------------------
                            owner.AnimState:OverrideSymbol("swap_body_tall", "armor_onemanband", "swap_body_tall")
                            owner.AnimState:Show("ARM_carry")
                            owner.AnimState:Hide("ARM_normal")
                        ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","switch.music")
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
                            owner.AnimState:ClearOverrideSymbol("swap_body_tall")
                            ---------------------------------------------------------------------------------------------------------------------
                            weapon_inst:PushEvent("weapon_in_hand","off")
                            ---------------------------------------------------------------------------------------------------------------------
                            owner._miraculous_machine_secret_scroll__unequipt_fn = nil
                        
                        end
                        owner._miraculous_machine_secret_scroll_task = owner:DoTaskInTime(weapon_in_hand_cd_time,owner._miraculous_machine_secret_scroll__unequipt_fn)

            end
        end,
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

}


local function player_statename(weapon_inst,owner,statename,weapon_type)
    -- print("info  player  statename",statename)
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