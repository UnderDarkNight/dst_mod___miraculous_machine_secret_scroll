------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 灯光特效
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local assets =
{
    -- Asset("ANIM", "anim/staff_projectile.zip"),
}





local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()



    inst.AnimState:SetBank("fx_book_research_station")
    inst.AnimState:SetBuild("fx_book_research_station")
    inst.AnimState:PlayAnimation("play_fx_mount", true)

    inst.Transform:SetSixFaced()

    inst:AddTag("INLIMBO")
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")      --- 不可点击
    inst:AddTag("CLASSIFIED")   --  私密的，client 不可观测， FindEntity 默认过滤
    inst:AddTag("NOBLOCK")      -- 不会影响种植和放置

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:ListenForEvent("Set",function(_,_table)
        if _table == nil then
            return
        end
        if _table.pt and _table.pt.x then
            inst.Transform:SetPosition(_table.pt.x, _table.pt.y, _table.pt.z)
        end
        if _table.scale then
            inst.AnimState:SetScale(_table.scale, _table.scale, _table.scale)
        end
    end)

    return inst
end





return Prefab("mms_scroll_light_fx", fn, assets)
