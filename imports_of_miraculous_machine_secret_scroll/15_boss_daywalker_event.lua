-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 噩梦猪人 的击杀无法触发 普通的  kill  event， 只能 额外操作。
-----------------------------------------------------------------------------------------------------------------------------------------------------------------




AddPrefabPostInit(
    "daywalker",
    function(inst)
        if not TheWorld.ismastersim then
            return
        end

        inst:ListenForEvent("minhealth",function(_,_table)
            if _table and _table.afflicter and not inst:HasTag("mmss_tag.block") then
                inst:AddTag("mmss_tag.block")
                _table.afflicter:PushEvent("killed",{
                    victim = inst,
                    attacker = _table.afflicter
                })
            end
        end)

    end
)