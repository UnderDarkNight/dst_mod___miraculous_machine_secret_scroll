----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    · 击杀【远古织影者】：  stalker_atrium
                                                                                        · 解锁功能：【近战】攻击暗影怪有 5% 概率秒杀。每击杀一次，增加5%概率，最高50%概率。         最多 10 只
                                                                                                    【远程】击中的第一只暗影怪后弹射去附近第二只暗影怪。只弹射一次。

                    · 解锁功能：攻击减少怪物0.5%的血量，每击杀一次增加0.5%，最高1%（百分比掉血）

    ["crawlingnightmare"] = true,       -- 洞里打架的影怪
    ["nightmarebeak"] = true,           -- 洞里打架的影怪

    ["crawlinghorror"] = true,       -- 低San的影怪
    ["terrorbeak"] = true,           -- 低San的影怪

    ["shadow_leech"] = true,              -- 影怪
    ["ruins_shadeling"] = true,           -- 影怪
    ["fused_shadeling"] = true,           -- 影怪

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
                            ---------------------------------------------
                            ---- 废弃
                                    -- local shadow_monster_porefab = {
                                    --     ["crawlingnightmare"] = true,       -- 洞里打架的影怪
                                    --     ["nightmarebeak"] = true,           -- 洞里打架的影怪
                                    
                                    --     ["crawlinghorror"] = true,       -- 低San的影怪
                                    --     ["terrorbeak"] = true,           -- 低San的影怪
                                    
                                    --     ["shadow_leech"] = true,              -- 影怪
                                    --     ["ruins_shadeling"] = true,           -- 影怪
                                    --     ["fused_shadeling"] = true,           -- 影怪
                                    -- }


                                    -- inst:ListenForEvent("shadow_monster_kill.sword",function(_,target)
                                    --     if not shadow_monster_porefab[target.prefab] then
                                    --         return
                                    --     end
                                    --     if target.components.combat == nil then
                                    --         return
                                    --     end
                                    --     local boss_num = inst.components.miraculous_machine_secret_scroll:Get("stalker_atrium") or 0
                                    --     if boss_num == 0 then
                                    --         return
                                    --     end
                                    --     if boss_num > 10 then
                                    --         boss_num = 10
                                    --     end
                                    --     local succeed_percent = boss_num * 0.05
                                    --     if math.random(1000)/1000 <= succeed_percent then
                                    --         local owner = inst.components.inventoryitem:GetGrandOwner()
                                    --         inst.components.combat:GetAttacked(owner,100000)
                                    --     end
                                    -- end)


                                    -- inst:ListenForEvent("shadow_monster_kill.bow",function(_,_table)
                                    --     local target = _table.target
                                    --     local damage = _table.damage
                                    --     local attacker = _table.attacker
                                    --     local range = _table.range or 15
                                    --     -- local range = 40
                                    --     if not shadow_monster_porefab[target.prefab] then
                                    --         return
                                    --     end
                                    --     if target.components.combat == nil then
                                    --         return
                                    --     end
                                    --     local boss_num = inst.components.miraculous_machine_secret_scroll:Get("stalker_atrium") or 0
                                    --     if boss_num == 0 then
                                    --         return
                                    --     end

                                    --     local x,y,z = target.Transform:GetWorldPosition()
                                    --     local ents = TheSim:FindEntities(x, y, z, range, {"shadow"}, nil, nil)
                                    --     for k, temp_inst in pairs(ents) do
                                    --         if temp_inst and temp_inst ~= target and shadow_monster_porefab[temp_inst.prefab] and temp_inst.components.combat then
                                    --                     local arrow_inst = SpawnPrefab("mms_scroll_arrow")
                                    --                     arrow_inst.Transform:SetPosition(x, y, z)
                                    --                     if inst:HasTag("max_level") then
                                    --                         arrow_inst:PushEvent("color","red")
                                    --                     end
                                    --                     arrow_inst.components.projectile:Throw___scroll_old(inst, temp_inst, attacker)
                                                        
                                    --                     arrow_inst.components.projectile:SetOnHitFn(function()
                                    --                         temp_inst.components.combat:GetAttacked(attacker,damage)
                                    --                         arrow_inst:Remove()
                                    --                     end)
                                    --                     break
                                    --         end
                                    --     end


                                    -- end)

        inst:ListenForEvent("dmg_target_by_percent",function(_,_table)
            if _table and _table.target and _table.attacker then
                local target = _table.target
                local attacker = _table.attacker
                if target.components.health == nil or target.components.combat == nil then
                    return
                end
                local boss_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.stalker_atrium") or 0
                if boss_num == 0 then
                    return
                end
                if boss_num > 2 then
                    boss_num = 2
                end
                local max_health = target.components.health.maxhealth
                local damage = max_health*0.5/100*boss_num
                if TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE then
                    TheNet:Announce("当前百分比伤害："..tostring(damage))
                end
                target.components.combat:GetAttacked(attacker,damage)

            end
        end)
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}