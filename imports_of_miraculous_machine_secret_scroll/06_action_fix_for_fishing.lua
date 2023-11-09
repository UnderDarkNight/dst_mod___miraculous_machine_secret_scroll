------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 鱼竿模式切换 会导致 组件 在 replica 缺失，造成崩溃
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