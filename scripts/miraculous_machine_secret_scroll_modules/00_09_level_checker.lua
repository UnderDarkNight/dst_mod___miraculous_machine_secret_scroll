----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 等级检查、改图标、上 tag
----------------------------------------------------------------------------------------------------------------------------------------------------------


return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
                inst:ListenForEvent("scroll_level_init",function()
                    local level_full = inst.components.miraculous_machine_secret_scroll:Get("weapon_level.full") or false
                    if level_full then
                        inst:AddTag("max_level")
                        inst:PushEvent("change_2_red")
                    end
                end)

                inst:ListenForEvent("scroll_data_load_end",function()
                    inst:PushEvent("scroll_level_init")
                end)
            -----------------------------------------------------------------------------------------------------------------

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}