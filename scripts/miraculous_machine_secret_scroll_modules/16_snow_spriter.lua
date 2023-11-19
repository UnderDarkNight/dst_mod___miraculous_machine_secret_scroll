----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 护目镜
----------------------------------------------------------------------------------------------------------------------------------------------------------
    local function spawn_snow_spriter(inst,player)
        if inst.____snow_spriter ~= nil then
            return
        end
        ---------------------------------------------------------------------------------------
            inst.____snow_spriter = SpawnPrefab("mms_scroll_snow_spriter")
            local snow_spriter = inst.____snow_spriter

            snow_spriter:PushEvent("Set",{
                player = player
            })
      
        ---------------------------------------------------------------------------------------
        ----- 2 秒发射一次
            local attack_range = 30
            local attack_damage = 50
            
            
            snow_spriter:DoPeriodicTask(2,function()
                if snow_spriter.attack_target and snow_spriter.attack_target:IsValid() then
                    local attack_target = snow_spriter.attack_target
                    if attack_target.components.combat and attack_target.components.health and not attack_target.components.health:IsDead() then
                                if snow_spriter:GetDistanceSqToInst(attack_target) < attack_range*attack_range then

                                            snow_spriter:Face_Target_And_Stop(attack_target)
                                            snow_spriter:DoTaskInTime(0.6,function()
                                                        if not snow_spriter:IsValid() or not attack_target:IsValid() then
                                                            return
                                                        end
                                                        local project = SpawnPrefab("mms_scroll_ice_projectile")

                                                        project.Transform:SetPosition(snow_spriter.Transform:GetWorldPosition())
                                                        project.components.projectile:Throw(snow_spriter, attack_target, snow_spriter)
                                                        project.components.projectile:SetOnHitFn(function()
                                                            -- attack_target.components.combat:GetAttacked( player, 50, snow_spriter ) -- 伤害 50  。伤害指向为玩家造成。
                                                            attack_target.components.combat:GetAttacked( player, attack_damage, snow_spriter ) -- 伤害 50  。伤害指向为玩家造成。
                                                            project:Remove()
                                                        end)
                                            
                                            end)


                                end
                    end
                else
                    snow_spriter.attack_target = nil
                end
            end)
        ---------------------------------------------------------------------------------------
    end
    local function remove_snow_spriter(inst,player)
        if inst.____snow_spriter then
            inst.____snow_spriter:Remove()
            inst.____snow_spriter = nil
        end
    end

    local function snow_spriter_atk_target(inst,target)
        if inst.____snow_spriter then
            inst.____snow_spriter.attack_target = target
        end
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        inst:AddTag("snow_spriter")
        
        if not TheWorld.ismastersim then
            return
        end

        -------------------------------------------------------------------------------------------------------------------
        

        -------------------------------------------------------------------------------------------------------------------
        ----- 加载时候检查 是否已经解锁，然后上tag
            inst:ListenForEvent("scroll_data_load_end",function()
                if inst.components.miraculous_machine_secret_scroll:Get("snow_spriter") then
                    inst:AddTag("snow_spriter")
                    inst:DoTaskInTime(0,function()
                        inst:PushEvent("snow_spriter_unlock")
                    end)
                end
            end)
        -------------------------------------------------------------------------------------------------------------------
        ----- 解锁 event
            inst:ListenForEvent("snow_spriter_unlock",function()
                inst:AddTag("snow_spriter")
                inst.components.miraculous_machine_secret_scroll:Set("snow_spriter",true)
                if inst.components.equippable.isequipped then
                    local owner = inst.components.inventoryitem:GetGrandOwner()
                    if owner then
                        spawn_snow_spriter(inst, owner)
                    end
                end
            end)
        -------------------------------------------------------------------------------------------------------------------
        ----- 攻击目标
            inst:ListenForEvent("player_onhitother",function(_,_table)
                if not inst:HasTag("snow_spriter") then
                    return
                end
                print("player_onhitother +++++++++++++ ",_table.attacker , _table.target, _table.weapon,_table.damage)

                if _table and _table.target then
                    if _table.weapon == nil or _table.weapon.prefab ~= "mms_scroll_snow_spriter" then
                        snow_spriter_atk_target(inst,_table.target)
                    end
                end
            end)
        -------------------------------------------------------------------------------------------------------------------


        inst:ListenForEvent("equipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then
                -------------------------------------------------------------------------------------
                    if inst:HasTag("snow_spriter") then
                        spawn_snow_spriter(inst,_table.owner)
                    end
                -------------------------------------------------------------------------------------
            end
        end)
        inst:ListenForEvent("unequipped",function(_,_table)
            if _table and _table.owner and _table.owner.userid then

                -------------------------------------------------------------------------------------
                    -- if inst:HasTag("snow_spriter") then
                        remove_snow_spriter(inst,_table.owner)
                    -- end
                -------------------------------------------------------------------------------------

            end
        end)


    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}