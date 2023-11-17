----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 模块分割初始化
---- 主入口函数 在 server 和 client 都执行，注册相关的切换函数
--[[

    · 标记位命名格式注意事项：
        · 武器当前模式储存于 ： inst.components.miraculous_machine_secret_scroll:Get("type")
        · 启用该模式的的PushEvent事件为   "weapon_type.start"
        · 关闭该模式的的PushEvent事件为   "weapon_type.stop"
    
    · reticule 组件笔记：该模块应该是用来辅助手柄/鼠标 在指定位置可交互使用，只在client端生效，不用担心组件在server端缺失造成崩溃。

    · 目前已经定义的模式名：
        switch.orange_staff   懒人法杖（橙色法杖）
        switch.purple_staff   传送法杖（紫色法杖）

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------
return function(inst)
    
    ------------------------------------------------------------------------------------
    ---- 注册各个模块应有的函数
        local modules = {
            "miraculous_machine_secret_scroll_modules/00_00_rpc_channel_register",                 --- 注册RPC的API 给组件，方便调用
            "miraculous_machine_secret_scroll_modules/00_01_type_switcher",                        --- 模式切换器
            "miraculous_machine_secret_scroll_modules/00_02_keyboard_listener_rigister",           --- 键盘监听
            "miraculous_machine_secret_scroll_modules/00_04_widget_controller",                    --- 界面图标控制
            "miraculous_machine_secret_scroll_modules/00_05_goto_state",                           --- 角色做动画瞬间把外观套上去
            "miraculous_machine_secret_scroll_modules/00_06_hit_kill_event_listener",              --- 玩家 击打、击杀 的event 转发到 武器 inst 身上
            "miraculous_machine_secret_scroll_modules/00_07_tools_work_finish_event_listener",     --- 玩家 锤、挖、砍、虫网、 的event 转发到 武器 inst 身上


            "miraculous_machine_secret_scroll_modules/01_acceptable",                           --- 物品接受组件
            "miraculous_machine_secret_scroll_modules/02_container",                            --- 容器组件
            "miraculous_machine_secret_scroll_modules/04_tools",                                --- 工具
            "miraculous_machine_secret_scroll_modules/05_orange_staff",                         --- 橙色法杖
            "miraculous_machine_secret_scroll_modules/06_purple_staff",                         --- 紫色法杖
            "miraculous_machine_secret_scroll_modules/07_blink_map",                            --- 地图跃迁
            "miraculous_machine_secret_scroll_modules/08_fishingrod",                           --- 池钓
            -- "miraculous_machine_secret_scroll_modules/09_ocean_fishingrod",                     --- 海钓【废弃】
            "miraculous_machine_secret_scroll_modules/10_bugnet",                               --- 虫网
            "miraculous_machine_secret_scroll_modules/11_trident",                              --- 三叉戟
            "miraculous_machine_secret_scroll_modules/12_long_range_weapon",                    --- 远程武器
            "miraculous_machine_secret_scroll_modules/13_short_range_weapon",                   --- 近战武器
            "miraculous_machine_secret_scroll_modules/14_ice_staff",                            --- 冰杖
            "miraculous_machine_secret_scroll_modules/15_goggles",                              --- 沙尘暴护目镜

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
        inst:DoTaskInTime(0,function()  --- 没洞穴的存档居然不会执行 OnEntityReplicated ？？？？？？ 科雷这是在搞毛。
            if inst.OnEntityReplicated then
                inst:OnEntityReplicated()
            end
        end)
    ------------------------------------------------------------------------------------
    ------ 存档读取、洞穴跨越的时候，读取武器的状态，下发事件切换。
        inst:ListenForEvent("scroll_data_load_end",function()
            inst:DoTaskInTime(0,function()
                local type_event_name = inst.components.miraculous_machine_secret_scroll:Get("type")
                if type(type_event_name) == "string" then
                    inst:PushEvent(type_event_name..".start")
                end
            end)
        end)
    ------------------------------------------------------------------------------------



end