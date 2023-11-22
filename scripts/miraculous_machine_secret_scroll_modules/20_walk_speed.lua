----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 移动速度加成
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
            local function walk_speed_init()
                local base_speed_mult = 1.1
                local cane_num = inst.components.miraculous_machine_secret_scroll:Add("cane.num",0)
                local ret_speed = base_speed_mult + 0.05*cane_num

                ---- 
                if inst.components.miraculous_machine_secret_scroll:Add("monster.kill.walrus",0) >= 88 
                    and inst.components.miraculous_machine_secret_scroll:Add("monster.kill.little_walrus",0) >= 88 then
                        ret_speed = ret_speed + 0.08
                end

                inst.components.equippable.walkspeedmult = ret_speed                
            end

            walk_speed_init()
            inst:ListenForEvent("walk_speed_init",walk_speed_init)
            inst:ListenForEvent("target_kill_count_end",walk_speed_init)
            -----------------------------------------------------------------------------------------------------------------
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}