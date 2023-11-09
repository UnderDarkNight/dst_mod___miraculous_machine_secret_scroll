-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---- 地图跃迁
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- return {
--     -----------------------------------------------------------------------------------------------------------------
--     main = function(inst)
--         -- inst:AddComponent("mms_scroll_com_blink_map")

--         inst.___blink_map_fn = function(player)
--             if player.components.playeractionpicker ~= nil then
--                 player.components.playeractionpicker.pointspecialactionsfn = function(inst, pos, useitem, right)
--                     print("66666666666666666666666666666666666666666")
--                     return { ACTIONS.BLINK }
--                 end
--             end
--         end

--         inst:ListenForEvent("equipped",function(_,_table)
--             if _table and _table.owner then                
--                 _table.owner:ListenForEvent("setowner", inst.___blink_map_fn)
--             end
--         end)
--         inst:ListenForEvent("unequipped",function(_,_table)
--             if _table and _table.owner then
--                 _table.owner:RemoveEventCallback("setowner", inst.___blink_map_fn)

--             end
--         end)



--     end,
--     -----------------------------------------------------------------------------------------------------------------
--     replica = function(inst)
        


--     end
--     -----------------------------------------------------------------------------------------------------------------
-- }