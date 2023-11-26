----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 冰冻目标
--[[
        · 【完成】给予冰魔杖解锁【冰冻攻击】
            · 寒冰法杖解锁【冰冻攻击】，攻击有概率使敌人冰冻（可被二连击触发）
            · 初始几率5%，蓝宝石升级，每颗增加1%的几率，最高20%    最多喂食15个
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)



        inst:ListenForEvent("player_onhitother",function(_,_table)

            local target = _table.target
            local attacker = _table.attacker
            local damage = _table.damage
            local weapon = _table.weapon
            -- print(" double attack event",attacker,target,damage,weapon)
            if not (target and attacker and damage and weapon) then
                return
            end
            if weapon ~= inst then
                return
            end
            -----------------------------------------------------------------------
            ---- 冰冻目标
                if target.components.freezable and not target.components.freezable:IsFrozen() then
                    if inst.components.miraculous_machine_secret_scroll:Get("icestaff.full") then
                        local bluegem_num = inst.components.miraculous_machine_secret_scroll:Add("bluegem.num",0)
                        -- · 初始几率5%，蓝宝石升级，每颗增加1%的几率，最高20%    最多喂食15个
                        local base_bluegem_percent = 0.05
                        if math.random(10000)/10000 <= (base_bluegem_percent + bluegem_num * 0.01) then
                            target.components.freezable:Freeze(5)   --- 5秒就行了
                        end
                    end
                end
            -----------------------------------------------------------------------



        end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}