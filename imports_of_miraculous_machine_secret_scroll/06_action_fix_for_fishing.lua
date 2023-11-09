------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 海钓的动作优先级太高，降低一些
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- local old_fn = EntityScript.CollectActions
-- EntityScript.CollectActions = function(...)
--     local crash_flag, crash_reason = pcall(old_fn, ...)
-- end


-- AddComponentPostInit("playercontroller", function(self)
--     local old_fn = self.OnUpdate
--     self.OnUpdate = function(...)
--         pcall(old_fn,...)
--     end
-- end)

if ( ACTIONS.FISH_OCEAN.priority or 0 ) >= 0 then
    ACTIONS.FISH_OCEAN.priority = -10    
end