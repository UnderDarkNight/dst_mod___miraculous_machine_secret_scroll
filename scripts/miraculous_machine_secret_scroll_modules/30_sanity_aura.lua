----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 回San光环
---- SANITYAURA
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