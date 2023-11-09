----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 键盘监听和执行
---- 会以 30FPS 轮询，注意处理
---- 按键宏列表在  constants.lua  里
--[[
    KEY_A = 97
    KEY_B = 98
    KEY_C = 99
    KEY_D = 100
    KEY_E = 101
    KEY_F = 102
    KEY_G = 103
    KEY_H = 104
    KEY_I = 105
    KEY_J = 106
    KEY_K = 107
    KEY_L = 108
    KEY_M = 109
    KEY_N = 110
    KEY_O = 111
    KEY_P = 112
    KEY_Q = 113
    KEY_R = 114
    KEY_S = 115
    KEY_T = 116
    KEY_U = 117
    KEY_V = 118
    KEY_W = 119
    KEY_X = 120
    KEY_Y = 121
    KEY_Z = 122
    KEY_F1 = 282
    KEY_F2 = 283
    KEY_F3 = 284
    KEY_F4 = 285
    KEY_F5 = 286
    KEY_F6 = 287
    KEY_F7 = 288
    KEY_F8 = 289
    KEY_F9 = 290
    KEY_F10 = 291
    KEY_F11 = 292
    KEY_F12 = 293
]]
----------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst,key,down)
    -- print("test 6666666",key,down)
    if not down and (  (key >= KEY_A and key <= KEY_Z) or (key >= KEY_F1 and key <= KEY_F12)  ) then    --- 按键抬起
        -- print("key up",key)
        pcall(function()
            inst.replica.miraculous_machine_secret_scroll:RPC_PushEvent("key_up",key)            
        end)
    end
end