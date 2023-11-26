----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 防水
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        local function waterproofer_init(inst)
            local moose_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.moose") or 0
            if moose_num > 5 then
                moose_num = 5
            end
            inst.components.waterproofer:SetEffectiveness(moose_num*0.2)
        end

        inst:ListenForEvent("target_kill_count_end",waterproofer_init)
        inst:DoTaskInTime(0,waterproofer_init)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}