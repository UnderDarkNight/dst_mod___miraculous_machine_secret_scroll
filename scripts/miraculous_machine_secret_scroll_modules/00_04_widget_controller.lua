----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 界面图标控制
----------------------------------------------------------------------------------------------------------------------------------------------------------
return {
    -----------------------------------------------------------------------------------------------------------------
    main = function(inst)
        
    end,
    -----------------------------------------------------------------------------------------------------------------
    replica = function(inst)
                        inst:ListenForEvent("start_keyboard_listener",function(_,userid)
                            -- print("start_keyboard_listener",userid)
                            if userid and ThePlayer and ThePlayer.userid == userid then
                                ThePlayer:DoTaskInTime(0.5,function()   ---- 延时一下下
                                    ThePlayer.HUD:miraculous_machine_secret_scroll_widget_open(inst)
                                end)
                            end
                        end)
                        inst:ListenForEvent("stop_keyboard_listener",function(_,userid)
                            -- print("stop_keyboard_listener",userid)
                            if userid and ThePlayer and ThePlayer.userid == userid then
                                ThePlayer.HUD:miraculous_machine_secret_scroll_widget_close()
                            end
                        end)
    
    end
    -----------------------------------------------------------------------------------------------------------------
}