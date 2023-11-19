------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 冰弹药
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local assets =
{
    Asset("ANIM", "anim/mms_scroll_snow_spriter.zip"),
}
local function follower_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("INLIMBO")
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")      --- 不可点击
    inst:AddTag("CLASSIFIED")   --  私密的，client 不可观测， FindEntity 默认过滤
    inst:AddTag("NOBLOCK")      -- 不会影响种植和放置

    inst.entity:SetPristine()

    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize(1,1)

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("mms_scroll_snow_spriter")
    inst.AnimState:SetBuild("mms_scroll_snow_spriter")
    inst.AnimState:PlayAnimation("idle", true)

    inst.Transform:SetFourFaced()

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.persists = false

    inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(50)

    function inst:Close2Point(pt,speed)
        self:FacePoint(pt.x,0,pt.z)
        self.Physics:ClearCollidesWith(COLLISION.LIMITS)
        self.Physics:SetMotorVel(speed, 0, 0)
    end
    function inst:StopClosing()
        inst.Physics:Stop()
    end

    function inst:Distance_Points(PointA,PointB)
        return ((PointA.x - PointB.x) ^ 2 + (PointA.z - PointB.z) ^ 2) ^ (0.5)
    end

    -- inst:AddComponent("projectile")
    -- inst.components.projectile:SetSpeed(50)
    -- inst.components.projectile:SetOnHitFn(inst.Remove)
    -- inst.components.projectile:SetOnMissFn(inst.Remove)
    -- inst.components.projectile:SetOnHitFn(OnHitIce)
    function inst:GetSurroundPoints(CMD_TABLE)
        -- local CMD_TABLE = {
        --     target = inst or Vector3(),
        --     range = 8,
        --     num = 8
        -- }
        if CMD_TABLE == nil then
            return
        end
        local theMid = nil
        if CMD_TABLE.target == nil then
            theMid = Vector3( self.inst.Transform:GetWorldPosition() )
        elseif CMD_TABLE.target.x then
            theMid = CMD_TABLE.target
        elseif CMD_TABLE.target.prefab then
            theMid = Vector3( CMD_TABLE.target.Transform:GetWorldPosition() )
        else
            return
        end
        -- --------------------------------------------------------------------------------------------------------------------
        -- -- 8 points
        -- local retPoints = {}
        -- for i = 1, 8, 1 do
        --     local tempDeg = (PI/4)*(i-1)
        --     local tempPoint = theMidPoint + Vector3( Range*math.cos(tempDeg) ,  0  ,  Range*math.sin(tempDeg)    )
        --     table.insert(retPoints,tempPoint)
        -- end
        -- --------------------------------------------------------------------------------------------------------------------
        local num = CMD_TABLE.num or 8
        local range = CMD_TABLE.range or 8
        local retPoints = {}
        for i = 1, num, 1 do
            local tempDeg = (2*PI/num)*(i-1)
            local tempPoint = theMid + Vector3( range*math.cos(tempDeg) ,  0  ,  range*math.sin(tempDeg)    )
            table.insert(retPoints,tempPoint)
        end

        return retPoints


    end

    function inst:Face_Target_And_Stop(target)
        inst:StopClosing()
        inst:AddTag("Face_Target_And_Stop")
        inst:PushEvent("atk")
        inst:ForceFacePoint(target.Transform:GetWorldPosition())
        inst:DoTaskInTime(1,function()
            inst:RemoveTag("Face_Target_And_Stop")
        end)
    end

    inst:ListenForEvent("Set",function(_,_table)
        if not type(_table) == "table" or _table.player == nil then
            inst:Remove()
            return
        end
        local player = _table.player
        local x,y,z = player.Transform:GetWorldPosition()
        inst.Transform:SetPosition(x, y, z)
        --------------------------------------------------------------------------------------------
        ---- 配置个inst 以30FPS 放置在玩家身上。
            local follower_inst = SpawnPrefab("mms_scroll_snow_spriter_follower")
            follower_inst:DoPeriodicTask(FRAMES,function()
                if player:IsValid() then
                    follower_inst.Transform:SetPosition(player.Transform:GetWorldPosition())
                else
                    follower_inst:Remove()
                end
            end)
        --------------------------------------------------------------------------------------------
            local range = 10
            local point_num = 15
            inst.__follow_num = 1
            inst:DoPeriodicTask(0.5,function()                ---- 定时刷个环绕目标点
                inst.__follow_num = inst.__follow_num + 1
                if inst.__follow_num > point_num then
                    inst.__follow_num = 1
                end
            end)
        --------------------------------------------------------------------------------------------
            inst:DoPeriodicTask(FRAMES,function()
                if player:IsValid() then
                    local points = inst:GetSurroundPoints({
                        target = follower_inst,
                        range = range,
                        num = point_num
                    })
                    local pt = points[inst.__follow_num]
                    if pt and pt.x then
                        ----------------------------------------------
                            local dis = inst:Distance_Points(pt,Vector3(inst.Transform:GetWorldPosition()))
                            if dis < 40 then
                                if dis < 1.5 then
                                    --- 距离过近，不进行任何操作
                                    inst:StopClosing()
                                else
                                        if not inst:HasTag("Face_Target_And_Stop") then
                                                local speed = dis * 1/2
                                                inst:Close2Point(pt,speed)
                                        end
                                end
                            else
                                inst.Transform:SetPosition(pt.x,0,pt.z)
                            end
                        ----------------------------------------------

                    end
                else
                    inst:Remove()
                end
            end)
        --------------------------------------------------------------------------------------------
        inst:ListenForEvent("atk",function()
            inst.AnimState:PlayAnimation("atk")
            inst.AnimState:PushAnimation("idle")
        end)
        --------------------------------------------------------------------------------------------
        --- 跟随删除
            inst:ListenForEvent("onremove",function()
                follower_inst:Remove()
            end)
        --------------------------------------------------------------------------------------------




    end)

    return inst
end




return Prefab("mms_scroll_snow_spriter_follower", follower_fn, assets)
        ,Prefab("mms_scroll_snow_spriter", fn, assets)
