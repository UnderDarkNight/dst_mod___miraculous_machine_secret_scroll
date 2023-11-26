----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 武器不掉落。  player:HasTag("stronggrip")
---- 需要兼顾玩家原有的 tag，有点麻烦
--[[
    · 【完成】击杀【熊大】：  bearger   mutatedbearger
            · 击杀 5 只解锁 武器不掉落。   【程序笔记】player:HasTag("stronggrip") 则不会被打掉武器。
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        ---------
        local function weapon_equip_stronggrip_in_player(player)
            if not inst:HasTag("weapon_stronggrip") then
                return
            end

            if player:HasTag("stronggrip") then
                inst:AddTag("weapon_stronggrip.need_remove_tag")
            else
                player:AddTag("stronggrip")
            end
        end
        local function weapon_unequip_stronggrip_in_player(player)
            if not inst:HasTag("weapon_stronggrip") then
                return
            end
            
            if inst:HasTag("weapon_stronggrip.need_remove_tag") then
                inst:RemoveTag("weapon_stronggrip.need_remove_tag")
            else
                player:RemoveTag("stronggrip")
            end
        end

        local function stronggrip_init()
            if (inst.components.miraculous_machine_secret_scroll:Get("boss.kill.bearger") or 0 ) >= 5 then
                inst:AddTag("weapon_stronggrip")
            end
        end


        inst:ListenForEvent("target_kill_count_end",stronggrip_init)
        inst:DoTaskInTime(0,stronggrip_init)


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                stronggrip_init()
                weapon_equip_stronggrip_in_player(_table.owner)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                stronggrip_init()
                weapon_unequip_stronggrip_in_player(_table.owner)
            end
        end)



    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}