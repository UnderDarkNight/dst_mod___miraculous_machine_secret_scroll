----------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 园艺锄相关的HOOK
----------------------------------------------------------------------------------------------------------------------------------------------------------------


local MMSS_TILL_ACTION = Action({ distance=0.5, theme_music = "farming" })
MMSS_TILL_ACTION.id = "MMSS_TILL_ACTION"
MMSS_TILL_ACTION.strfn = function(act)
    -- if act.target and act.doer and act.invobject then
    --     local flag,action = act.invobject.components.fwd_in_pdt_com_whip:CanCastSpell(act.doer,act.target)
    --     if flag then
    --         return action or "DEFAULT"
    --     end
    -- end
    return "NONE"
end

MMSS_TILL_ACTION.fn = function(act)
    -- if act.invobject and act.invobject.components.fwd_in_pdt_com_whip and act.target then
	-- 	act.invobject.components.fwd_in_pdt_com_whip:CastSpell(act.doer,act.target)
	-- 	return true
    -- end
    return true
end
AddAction(MMSS_TILL_ACTION)
AddComponentAction("POINT", "miraculous_machine_secret_scroll", function(inst, doer, pos, actions, right)   ------ 指定坐标位置用。
    if right and inst:HasTag("special_till") and TheWorld.Map:IsFarmableSoilAtPoint(pos.x, pos.y, pos.z) then
        table.insert(actions, ACTIONS.TILL)
    end
end,modname)

AddStategraphActionHandler("wilson",ActionHandler(MMSS_TILL_ACTION,function(inst)
    return "till_start"
end))
AddStategraphActionHandler("wilson_client",ActionHandler(MMSS_TILL_ACTION, function(inst)
    return "till_start"
end))

STRINGS.ACTIONS.MMSS_TILL_ACTION = {
    ["NONE"] = "6666666666",
}
