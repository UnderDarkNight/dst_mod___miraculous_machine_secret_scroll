----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 模块分割初始化
---- 主入口函数 在 server 和 client 都执行，注册相关的切换函数
----------------------------------------------------------------------------------------------------------------------------------------------------------
return function(inst)
    
    ------------------------------------------------------------------------------------
    ---- 注册各个模块应有的函数
        local modules = {
            "miraculous_machine_secret_scroll_modules/00_rpc_channel_register",                 --- 注册RPC的API 给组件，方便调用
            "miraculous_machine_secret_scroll_modules/01_acceptable",                           --- 物品接受组件
            "miraculous_machine_secret_scroll_modules/02_container",                            --- 容器组件
            "miraculous_machine_secret_scroll_modules/03_keyboard_listener_rigister",           --- 键盘监听
            "miraculous_machine_secret_scroll_modules/04_tools",                                --- 工具

        }
        local replica_modules_fn = {}

        for _, module_addr in ipairs(modules) do
            local the_module = require(module_addr)
            if type(the_module) == "table" then
                if type(the_module.main) == "function" and TheWorld.ismastersim then
                    local crash_flag, crash_msg = pcall(the_module.main, inst)
                    -- the_module.main(inst)
                    if not crash_flag then
                        print("error in",the_module)
                        print(crash_msg)
                    end
                end
                if type(the_module.replica) == "function" then
                    table.insert(replica_modules_fn, the_module.replica)
                end
            end
        end

        inst.OnEntityReplicated = function()        ---- replica 端注册对应的函数
            for k, fn in pairs(replica_modules_fn) do
                -- fn(inst)
                local crash_flag, crash_msg = pcall(fn, inst)
                if not crash_flag then
                    print("OnEntityReplicated error",modules[k])
                    print(crash_msg)
                end
            end
            inst.OnEntityReplicated = nil
        end
        inst:DoTaskInTime(0,function()  --- 没洞穴的存档居然不会执行 OnEntityReplicated ？？？？？？
            if inst.OnEntityReplicated then
                inst:OnEntityReplicated()
            end
        end)
    ------------------------------------------------------------------------------------



    ------------------------------------------------------------------------------------



end