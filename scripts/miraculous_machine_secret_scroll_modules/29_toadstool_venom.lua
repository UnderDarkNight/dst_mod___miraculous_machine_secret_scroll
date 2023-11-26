----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 蟾蜍毒
--[[
        · 【完成】击杀【毒菌蟾蜍】：  toadstool
            · 击杀1只后解锁【蟾蜍毒素】功能。攻击目标会有几率给目标上debuff ： 每秒造成 10点伤害，持续 10秒。  debuff可叠加。
            · 初始概率为10%。每击杀1只，增加5%概率。上限30%（不可被二连击触发）
]]--
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