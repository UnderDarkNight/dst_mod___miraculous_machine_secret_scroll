----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 移动速度加成
--[[
    · 【完成】移速加成：
        · 初始10% 。
        · 使用【手杖】进行移速升级。一根【手杖】增加17%速。最多5个【手杖】。
        · 击杀88个【大海象】和88个【小海象】则继续增加8%移速。
        【大海象】和【小海象】。    little_walrus    walrus
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
            local function walk_speed_init()
                local base_speed_mult = 1.1
                local cane_num = inst.components.miraculous_machine_secret_scroll:Add("cane.num",0)
                local ret_speed = base_speed_mult + 0.17*(cane_num-1)

                ---- 
                if inst.components.miraculous_machine_secret_scroll:Add("monster.kill.walrus",0) >= 88 
                    and inst.components.miraculous_machine_secret_scroll:Add("monster.kill.little_walrus",0) >= 88 then
                        ret_speed = ret_speed + 0.08
                end

                inst.components.equippable.walkspeedmult = ret_speed                
            end

            -- walk_speed_init()
            inst:ListenForEvent("walk_speed_init",walk_speed_init)
            inst:ListenForEvent("target_kill_count_end",walk_speed_init)
            -- inst:ListenForEvent("scroll_data_load_end",walk_speed_init)
            inst:DoTaskInTime(0,walk_speed_init)
            -----------------------------------------------------------------------------------------------------------------
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}