-- 本文件和 modmain.lua 同级别


modimport("imports_of_miraculous_machine_secret_scroll/00_load_Assets.lua")	---- 加载mod 所用素材资源

modimport("imports_of_miraculous_machine_secret_scroll/01_rpc_register.lua")	---- 注册关键RPC

modimport("imports_of_miraculous_machine_secret_scroll/02_com_register.lua")	---- 注册组件

modimport("imports_of_miraculous_machine_secret_scroll/03_action_acceptable.lua")	---- 注册接受动作

modimport("imports_of_miraculous_machine_secret_scroll/04_widget_weapon_type_icon.lua")	---- 武器图标

modimport("imports_of_miraculous_machine_secret_scroll/05_action_blink_map.lua")	---- 地图跃迁

modimport("imports_of_miraculous_machine_secret_scroll/06_action_fix_for_fishing.lua")	---- 钓鱼相关动作修正参数


modimport("imports_of_miraculous_machine_secret_scroll/07_playercontroller.lua")	---- 地图跃迁相关的组件hook


modimport("imports_of_miraculous_machine_secret_scroll/08_switch_widget.lua")	---- 按键 界面

modimport("imports_of_miraculous_machine_secret_scroll/09_player_combat_hook.lua")	---- 霸体相关的hook

modimport("imports_of_miraculous_machine_secret_scroll/10_unlocked_widget.lua")	---- 解锁界面

modimport("imports_of_miraculous_machine_secret_scroll/11_strings_and_recipe.lua")	---- 文本和制作

modimport("imports_of_miraculous_machine_secret_scroll/12_mod_config.lua")	---- MOD 设置

modimport("imports_of_miraculous_machine_secret_scroll/13_farm_till_action_change.lua")	---- 园艺锄相关的HOOK

modimport("imports_of_miraculous_machine_secret_scroll/14_componentactions_crash_fix.lua")	---- 园艺锄相关的HOOK

modimport("imports_of_miraculous_machine_secret_scroll/15_boss_daywalker_event.lua")	---- 噩梦猪人BOSS 相关的操作
