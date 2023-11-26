----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 蟾蜍毒
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst:ListenForEvent("toadstool_venom_2_target",function(_,target)
            if target and target.components.health then
                local toadstool_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.toadstool")
                if toadstool_num then
                    if toadstool_num >= 5 then
                        toadstool_num = 5
                    end
                            local base_probability = 0.1
                            if math.random(1000)/1000 <= ( base_probability + (toadstool_num-1)*0.05 ) then
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