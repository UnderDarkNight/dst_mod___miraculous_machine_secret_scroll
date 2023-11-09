
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--- 动作显示的文本 需要 和 index 对应。
----------------------------------------------------------------------------------------------------------------------------------------------------------------

local function ArriveAnywhere()
    return true
end

local MMS_SCROLL_BLINK_MAP = Action({ priority=999, customarrivecheck=ArriveAnywhere, rmb=true, mount_valid=true, map_action=true, })  
MMS_SCROLL_BLINK_MAP.id = "MMS_SCROLL_BLINK_MAP"
MMS_SCROLL_BLINK_MAP.strfn = function(act) --- 客户端检查是否通过,同时返回显示字段
    if act.doer then
        return "DEFAULT"
    end
end

-- MMS_SCROLL_BLINK_MAP.stroverridefn = function(act)
--     print("777777777777777777777777777777777777777")
--     return true
-- end

MMS_SCROLL_BLINK_MAP.fn = function(act)    --- 只在服务端执行~
    -- local inst = act.invobject
    -- local inst = act.target
    -- local doer = act.doer

    local act_pos = act:GetActionPoint()
    print("info MMS_SCROLL_BLINK_MAP act_pos:", act_pos)

    return true
end



AddAction(MMS_SCROLL_BLINK_MAP)

-- AddComponentAction("EQUIPPED", "npng_com_book" , function(inst, doer, target, actions, right)    --- 装备后多个技能
-- AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right) -- -- 一个物品对另外一个目标用的技能，物品身上有 这个com 就能触发
-- AddComponentAction("SCENE", "npng_com_book" , function(inst, doer, actions, right)-------    建筑一类的特殊交互使用
-- AddComponentAction("INVENTORY", "npng_com_book", function(inst, doer, actions, right)   ---- 拖到玩家自己身上就能用,在背包里就能用
-- AddComponentAction("POINT", "complexprojectile", function(inst, doer, pos, actions, right)   ------ 指定坐标位置用。


AddComponentAction("EQUIPPED", "mms_scroll_com_blink_map" , function(inst, doer, target, actions, right_click) -------    建筑一类的特殊交互使用
    if right_click then
        table.insert(actions, ACTIONS.MMS_SCROLL_BLINK_MAP)
    end
end)




AddStategraphActionHandler("wilson",ActionHandler(MMS_SCROLL_BLINK_MAP,function(player)
    return "dolongaction"
end))
AddStategraphActionHandler("wilson_client",ActionHandler(MMS_SCROLL_BLINK_MAP, function(player)
    return "dolongaction"
end))


STRINGS.ACTIONS.MMS_SCROLL_BLINK_MAP = {
    DEFAULT = "跳跳跳跳跳",
}


