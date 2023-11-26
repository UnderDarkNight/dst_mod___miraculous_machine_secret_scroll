----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 蜂毒
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst:ListenForEvent("bee_venom_2_target",function(_,target)
            if target and target.components.health then
                local beequeen_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.beequeen")
                if beequeen_num then
                    if beequeen_num >= 5 then
                        beequeen_num = 5
                    end
                            local base_probability = 0.1
                            if math.random(1000)/1000 <= ( base_probability + (beequeen_num-1)*0.05 ) then
                                        for i = 1, 10, 1 do
                                            target:DoTaskInTime(i,function()
                                                target.components.health:DoDelta(-10)
                                            end)
                                        end
                            end
                end
            end
        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}