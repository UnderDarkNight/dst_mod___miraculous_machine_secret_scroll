----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 蜂毒
--[[
    · 【完成】击杀【蜂后】：  beequeen
            · 击杀1只后解锁【蜂毒】功能。攻击目标会有几率给目标上debuff ： 每秒造成 10 点伤害，持续 10秒。  debuff可叠加。
            · 初始上毒概率为 10% 。 每击杀一只【蜂后】，增加 5%概率。上限30（不可被二连击触发）  5只怪
]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)

        inst:ListenForEvent("bee_venom_2_target",function(_,target)
            if target and target.components.health then
                local beequeen_num = inst.components.miraculous_machine_secret_scroll:Get("boss.kill.beequeen")
                if beequeen_num then
                    if beequeen_num >= 5 then
                        beequeen_num = 5
                    end
                            local base_probability = TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE and 0.5 or 0.1
                            local the_probability = math.random(1000)/1000
                            if TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE then
                                TheNet:Announce("当前蜂毒ROLL到:"..tostring(the_probability*100).."%")
                            end
                            if the_probability <= ( base_probability + (beequeen_num-1)*0.05 ) then
                                if TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE then
                                    TheNet:Announce("成功给目标打上蜂毒")
                                end
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