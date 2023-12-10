----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

位面伤害

    · 击杀【暗影三基佬】：  shadow_knight   shadow_rook   shadow_bishop
        · 每击杀一种，增加8点位面伤害，首次击杀有效，最高形态才算数。共计24点位面伤害加成。解锁位面伤害目标 ：lunar_aligned
                · 【程序笔记】：位面伤害组件：inst:AddComponent("planardamage") 
                                位面目标组件 ：inst:AddComponent("damagetypebonus") 。绑定目标位面 ：lunar_aligned / shadow_aligned
                                详情参考 亮茄剑 sword_lunarplant 和 收割者 voidcloth_scythe

    · 击杀【天体英雄】：alterguardian_phase3
        · 击杀解锁【灯光】开启功能（快捷键）
        · 增加20点位面伤害，首次击杀有效。解锁位面伤害目标：shadow_aligned

    · 击杀【地下暗影三基佬】：  shadowthrall_hands  shadowthrall_wings  shadowthrall_horns
        ·每击杀一种，增加2点位面伤害，首次击杀有效。共计6点位面伤害加成。解锁位面伤害目标 ：lunar_aligned
    
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        local boss_prefabs = {
            ["shadow_knight"] = {level = 3,damage = 8},
            ["shadow_rook"] = {level = 3,damage = 8},
            ["shadow_bishop"] = {level = 3,damage = 8},

            ["alterguardian_phase3"] = {level = 0,damage = 20},

            ["shadowthrall_hands"] = {level = 0,damage = 2},
            ["shadowthrall_wings"] = {level = 0,damage = 2},
            ["shadowthrall_horns"] = {level = 0,damage = 2},
        }

        inst.components.planardamage:SetBaseDamage(0)

        local function planardamage_init()
            local planardamage = 0
            for the_prefab, flag in pairs(boss_prefabs) do
                if inst.components.miraculous_machine_secret_scroll:Get("planardamage."..the_prefab) then
                    planardamage = boss_prefabs[the_prefab].damage + planardamage
                end
            end
            -- print("error ++++ level right and damage change",planardamage)
            inst.components.miraculous_machine_secret_scroll:Set("planardamage",planardamage)
            inst.components.planardamage:SetBaseDamage(planardamage)
        end

        inst:ListenForEvent("monster_killed",function(_,boss_inst)
            if boss_prefabs[boss_inst.prefab] then
                if (boss_inst.level or 0) == boss_prefabs[boss_inst.prefab].level then                    
                    inst.components.miraculous_machine_secret_scroll:Set("planardamage."..boss_inst.prefab,true)
                    planardamage_init()
                end
            end
        end)

        inst:DoTaskInTime(0,planardamage_init)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}