--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 强制修一些 componentactions.lua 里 崩溃。至于为什么崩溃，不知道。
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- local old_UnregisterComponentActions = EntityScript.UnregisterComponentActions
-- EntityScript.UnregisterComponentActions = function(...)
--     -- print("mms_scroll_test UnregisterComponentActions",...)
--     local crash_flg = pcall(old_UnregisterComponentActions,...)
--     if not crash_flg then
--         print("mms_scroll error : UnregisterComponentActions",...)
--     end
-- end

if GLOBAL.EntityScript.UnregisterComponentActions_mms_scroll_old == nil then


    -------------------------------------------------------------------------------------------
    ---- UnregisterComponentActions
        rawset(GLOBAL.EntityScript,"UnregisterComponentActions_mms_scroll_old",rawget(GLOBAL.EntityScript,"UnregisterComponentActions"))
        rawset(GLOBAL.EntityScript, "UnregisterComponentActions", function(self,...)
                -- print("mms_scroll_test UnregisterComponentActions",self,...)
            local crash_flg = pcall(self.UnregisterComponentActions_mms_scroll_old,self,...)
            if not crash_flg then
                print("mms_scroll error : UnregisterComponentActions",self,...)
            end
        end)
    -------------------------------------------------------------------------------------------
    ---- CollectActions
        rawset(GLOBAL.EntityScript,"CollectActions_mms_scroll_old",rawget(GLOBAL.EntityScript,"CollectActions"))
        rawset(GLOBAL.EntityScript, "CollectActions", function(self,...)
                -- print("mms_scroll_test CollectActions",self,...)
            local crash_flg = pcall(self.CollectActions_mms_scroll_old,self,...)
            if not crash_flg then
                print("mms_scroll error : CollectActions",self,...)
            end
        end)







end