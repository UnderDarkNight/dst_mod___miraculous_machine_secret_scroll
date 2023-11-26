----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 温度保护
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        ------------------------------------------------------------------------
        ---- 过热伤害屏蔽
            local function add_overheat_fix(player)                
                local dragonfly_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.dragonfly")
                if player.components.health then
                    player.components.health.externalfiredamagemultipliers:SetModifier(inst , dragonfly_num ~= nil and 0 or 1 )
                end
            end
            local function remove_overheat_fix(player)
                if player.components.health then
                    player.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
                end
            end

            inst:ListenForEvent("target_kill_count_end",function()
                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    add_overheat_fix(owner)
                end
            end)
        ------------------------------------------------------------------------
        ---- 体温限制
            local function temperature_fix(com,value)
                print("temperature_fix",value)
                -- local current_temperature = com.current

                ---------------- 低温保护
                if value <= 20 then

                            local deerclops_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.deerclops") 
                            local mutateddeerclops_num =  inst.components.miraculous_machine_secret_scroll:Get("boss.kill.mutateddeerclops")            
                            if deerclops_num or mutateddeerclops_num then
                                local low_temperature_block_num = (deerclops_num or 0) + (mutateddeerclops_num or 0)
                                if low_temperature_block_num > 20 then
                                    low_temperature_block_num = 20
                                end

                                if value < low_temperature_block_num then
                                    return low_temperature_block_num
                                end
                            end

                end
                
                ---------------- 高温保护
                if value >= 50 then

                    local dragonfly_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.dragonfly")

                    if dragonfly_num then
                        dragonfly_num = dragonfly_num or 0
                        if dragonfly_num > 20 then
                            dragonfly_num = 20
                        end
                        local hight_temperature_block_num = 50 - dragonfly_num
                        if value > hight_temperature_block_num then
                            return hight_temperature_block_num
                        end
                    end

                end

                return value
            end

            local function temperature_com_hook(player)
                if player.components.temperature then
                    player.components.temperature.SetTemperature__mms_scroll_old = player.components.temperature.SetTemperature
                    player.components.temperature.SetTemperature = function(self,value)                                
                        value = temperature_fix(self,value)
                        return self:SetTemperature__mms_scroll_old(value)
                    end
                end
            end
            local function temperature_com_unhook(player)
                if player.components.temperature then
                    if player.components.temperature.SetTemperature__mms_scroll_old then
                        player.components.temperature.SetTemperature = player.components.temperature.SetTemperature__mms_scroll_old
                        player.components.temperature.SetTemperature__mms_scroll_old = nil
                    end
                end
            end
        ------------------------------------------------------------------------
    
        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                        temperature_com_hook(_table.owner)
                        add_overheat_fix(_table.owner)

            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                        temperature_com_unhook(_table.owner)
                        remove_overheat_fix(_table.owner)

            end
        end)



    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}