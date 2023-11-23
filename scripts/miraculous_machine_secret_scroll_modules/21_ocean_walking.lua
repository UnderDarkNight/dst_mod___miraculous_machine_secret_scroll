----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 水上行走
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
            -----------------------------------------------------------------------------------------------------------------
                local function start_ocean_walking(owner)
                    if owner.components.drownable and owner.components.drownable.enabled ~= false then
                        owner.components.drownable.enabled = false
                    end
                    owner.Physics:ClearCollisionMask()
                    owner.Physics:CollidesWith(COLLISION.GROUND)
                    owner.Physics:CollidesWith(COLLISION.OBSTACLES)
                    owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                    owner.Physics:CollidesWith(COLLISION.CHARACTERS)
                    owner.Physics:CollidesWith(COLLISION.GIANTS)
                    owner.Physics:Teleport(owner.Transform:GetWorldPosition())
                end
                local function stop_ocean_walking(owner)
                    if owner.components.drownable then
                        owner.components.drownable.enabled = true
                    end
                    owner.Physics:ClearCollisionMask()
                    owner.Physics:CollidesWith(COLLISION.WORLD)
                    owner.Physics:CollidesWith(COLLISION.OBSTACLES)
                    owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                    owner.Physics:CollidesWith(COLLISION.CHARACTERS)
                    owner.Physics:CollidesWith(COLLISION.GIANTS)
                    owner.Physics:Teleport(inst.Transform:GetWorldPosition())
                end
            -----------------------------------------------------------------------------------------------------------------
            inst:ListenForEvent("func.ocean_walking_switch",function()

                local owner = inst.components.inventoryitem:GetGrandOwner()
                if owner then
                    owner.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active")
                end

                if not inst:HasTag("ocean_walking_switch") then
                    inst:AddTag("ocean_walking_switch")
                    start_ocean_walking(owner)
                else
                    inst:RemoveTag("ocean_walking_switch")
                    stop_ocean_walking(owner)
                end

            end)

            inst:ListenForEvent("equipped",function(_,_table)
                if _table and _table.owner and _table.owner.userid then
                    if inst:HasTag("ocean_walking_switch") then
                        start_ocean_walking(_table.owner)
                    end
                end
            end)
            inst:ListenForEvent("unequipped",function(_,_table)
                if _table and _table.owner and _table.owner.userid then
                    if inst:HasTag("ocean_walking_switch") then
                        stop_ocean_walking(_table.owner)
                    end
                end
            end)

    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)

    end
    -----------------------------------------------------------------------------------------------------------------
}