----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 绝缘体、防雷
--[[
    · 击杀【电羊】：  lightninggoat
        · 击杀10只带电的羊，解锁防雷。
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst:ListenForEvent("player_killed",function(_,_table)
            if _table and _table.target and _table.target.prefab == "lightninggoat" and _table.target:HasTag("charged") then
                inst.components.miraculous_machine_secret_scroll:Add("lightninggoat_charged",1)
            end
        end)

        local function equip_hook(player)
            if player.components.playerlightningtarget then
                player.components.playerlightningtarget.GetHitChance__mms_scroll_old = player.components.playerlightningtarget.GetHitChance
                player.components.playerlightningtarget.GetHitChance = function(self,...)

                    local lightninggoat_charged_num = inst.components.miraculous_machine_secret_scroll:Get("lightninggoat_charged") or 0
                    if lightninggoat_charged_num >= 10 then
                        return -1
                    else
                        return self:GetHitChance__mms_scroll_old(...)
                    end

                end
            end
        end

        local function unequip_unhook(player)
            if player.components.playerlightningtarget and player.components.playerlightningtarget.GetHitChance__mms_scroll_old then
                player.components.playerlightningtarget.GetHitChance = player.components.playerlightningtarget.GetHitChance__mms_scroll_old
            end
        end


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                equip_hook(_table.owner)
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                unequip_unhook(_table.owner)
            end
        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}