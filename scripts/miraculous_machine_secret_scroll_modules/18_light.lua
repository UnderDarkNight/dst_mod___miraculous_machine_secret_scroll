----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 灯光
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
            inst:ListenForEvent("func.light_switch",function()
                if inst.__light then
                    inst.__light:Remove()
                    inst.__light = nil

                    inst.__light_fx:Remove()
                else
                    local light_inst = inst:SpawnChild("minerhatlight")
                    inst.__light = light_inst

                    light_inst.Light:Enable(true)
                    -- light_inst.Light:SetRadius(1.5)   -- 光照半径
                    light_inst.Light:SetRadius(2.5)   -- 光照半径
                    light_inst.Light:SetFalloff(.9)   -- 距离衰减速度（越大衰减越快）
                    light_inst.Light:SetIntensity(0.6)    --- 光照强度 --- 靠task 渐变亮度
                    -- light_inst.Light:SetColour(235 / 255, 255 / 255, 255 / 255)   --- 颜色 RGB
                    light_inst.Light:SetColour(255 / 255, 255 / 255, 255 / 255)   --- 颜色 RGB


                    inst.__light_fx = inst.__fx:SpawnChild("mms_scroll_light_fx")
                    inst.__light_fx:PushEvent("Set",{
                        pt = Vector3(0,0.5,0),
                        scale = 0.5,
                    })
                end



                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    owner.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")
                end

            end)

            inst:ListenForEvent("unequipped",function()
                if inst.__light then
                    inst.__light:Remove()
                    inst.__light = nil
                    inst.__light_fx:Remove()
                end
            end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}