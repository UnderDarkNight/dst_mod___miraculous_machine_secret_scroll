----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 回San光环
---- SANITYAURA
--[[
    
    · 【完成】击杀【克眼】：  eyeofterror
            · 击杀1只后，开启回San光环。默认 TUNING.SANITYAURA_TINY。   inst.components.equippable.dapperness = TUNING.SANITYAURA_SMALL
            · 每击杀1只，光环升级一次。 SANITYAURA_TINY ---> SANITYAURA_SUPERHUGE
                    【程序笔记】官方可选光环：
                        seg_time = 30
                        SANITYAURA_TINY = 100/(seg_time*32),
                        SANITYAURA_SMALL_TINY = 100/(seg_time*20),
                        SANITYAURA_SMALL = 100/(seg_time*8),
                        SANITYAURA_MED = 100/(seg_time*5),
                        SANITYAURA_LARGE = 100/(seg_time*2),
                        SANITYAURA_HUGE = 100/(seg_time*.5),
                        SANITYAURA_SUPERHUGE = 100/(seg_time*.25),


]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        local SANITYAURA_DURATION = {
            [1] = TUNING.SANITYAURA_TINY,
            [2] = TUNING.SANITYAURA_SMALL_TINY,
            [3] = TUNING.SANITYAURA_SMALL,
            [4] = TUNING.SANITYAURA_MED,
            [5] = TUNING.SANITYAURA_LARGE,
            [6] = TUNING.SANITYAURA_HUGE,
            [7] = TUNING.SANITYAURA_SUPERHUGE,
        }
        local function sanityaura_init(inst)
            local eyeofterror_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.eyeofterror") or 0
            if eyeofterror_num >= 1 then
                inst.components.equippable.dapperness = SANITYAURA_DURATION[eyeofterror_num] or TUNING.SANITYAURA_SUPERHUGE
            end
        end

        inst:ListenForEvent("target_kill_count_end",sanityaura_init)
        inst:DoTaskInTime(0,sanityaura_init)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}