----------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

秒杀

    ·【秒杀】
            · 红宝石法杖解锁【秒杀】，攻击有几率秒杀任何敌人（不可被二连击触发）
            · 初始概率0.1%，每给予一颗红宝石增加0.01%的概率，最高0.5%   最多喂食 40 个

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)


        inst:ListenForEvent("spike_target",function(_,target)
            if inst.components.miraculous_machine_secret_scroll:Get("firestaff.full") then
                local redgem_num = inst.components.miraculous_machine_secret_scroll:Add("redgem.num",0)
                local percent = 0.1/100 + redgem_num*0.01/100
                if percent >= 0.5/100 then
                    percent = 0.5/100
                end
                local attacker = inst.components.inventoryitem:GetGrandOwner()
                if math.random(10000)/10000 < percent then
                    if target.components.health and target.components.combat then
                        local max_health = target.components.health.maxhealth
                        target.components.combat:GetAttacked(attacker,max_health,inst)
                    end
                    return
                end
            end

        end)


    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}