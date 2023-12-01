----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 蟾蜍毒
--[[
        · 【完成】击杀【毒菌蟾蜍】：  toadstool
            · 击杀1只后解锁【蟾蜍毒素】功能。攻击目标会有几率给目标上debuff ： 每秒造成 10点伤害，持续 10秒。  debuff可叠加。
            · 初始概率为10%。每击杀1只，增加5%概率。上限30%（不可被二连击触发）  最大5 只
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
                            local base_probability = TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE and 0.3 or 0.1
                            local the_probability = math.random(1000)/1000
                            local the_target_probability = ( base_probability + (toadstool_num-1)*0.05 ) 
                            if TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE then
                                TheNet:Announce("当前蟾蜍毒ROLL到:"..tostring(the_probability*100).."%，需要小于"..tostring(the_target_probability*100).."%才能触发")
                            end
                            if the_probability <= the_target_probability then
                                if TUNING.MIRACULOUS_MACHINE_SECRET_SCROLL.DEBUG_MODE then
                                    TheNet:Announce("成功给目标打上蟾蜍毒")
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