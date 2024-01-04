----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 武迪砍树效率。  player:HasTag("woodcutter")
---- 需要兼顾玩家原有的 tag，有点麻烦
--[[
    · 【完成】击杀【树精】：  leif   leif_sparse
            · 击杀 10 只后解锁 伍迪砍树效率。  【程序笔记】player:AddTag("woodcutter")
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        ---------
        local function weapon_equip_woodcutter_in_player(player)
            if not inst:HasTag("weapon_woodcutter") then
                return
            end

            if player:HasTag("woodcutter") then
                inst:AddTag("weapon_woodcutter.need_remove_tag")
            else
                player:AddTag("woodcutter")
            end
            player:AddTag("fwd_in_pdt_tag.fracture.block")  -- 兼容【负重前行】MOD进行骨折屏蔽  fwd_in_pdt_tag.fracture.block
        end
        local function weapon_unequip_woodcutter_in_player(player)
            if not inst:HasTag("weapon_woodcutter") then
                return
            end
            
            if inst:HasTag("weapon_woodcutter.need_remove_tag") then
                inst:RemoveTag("weapon_woodcutter.need_remove_tag")
            else
                player:RemoveTag("woodcutter")
            end
            player:RemoveTag("fwd_in_pdt_tag.fracture.block")  -- 兼容【负重前行】MOD进行骨折屏蔽  fwd_in_pdt_tag.fracture.block

        end

        local function woodcutter_init()
            if (inst.components.miraculous_machine_secret_scroll:Get("boss.kill.leif") or 0 ) + (inst.components.miraculous_machine_secret_scroll:Get("boss.kill.leif_sparse") or 0 ) >= 10 then
                inst:AddTag("weapon_woodcutter")
            end
        end


        inst:ListenForEvent("boss_killed",woodcutter_init)
        inst:DoTaskInTime(0,woodcutter_init)


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                woodcutter_init()
                weapon_equip_woodcutter_in_player(_table.owner)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                woodcutter_init()
                weapon_unequip_woodcutter_in_player(_table.owner)
            end
        end)



    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}