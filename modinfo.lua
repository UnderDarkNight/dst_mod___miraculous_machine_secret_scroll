name = "神机密卷"
-- description = "各种功能武器卷轴"
description = [[


    各种功能武器卷轴

    需要一本科技

    在【武器】一栏制作


]]


author = "幕夜之下"
version = "0.1"
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
forumthread = ""
dont_starve_compatible = true
dst_compatible = true
all_clients_require_mod = true


local keys_option = {
    {description = "KEY_A", data = "KEY_A"},
    {description = "KEY_B", data = "KEY_B"},
    {description = "KEY_C", data = "KEY_C"},
    {description = "KEY_D", data = "KEY_D"},
    {description = "KEY_E", data = "KEY_E"},
    {description = "KEY_F", data = "KEY_F"},
    {description = "KEY_G", data = "KEY_G"},
    {description = "KEY_H", data = "KEY_H"},
    {description = "KEY_I", data = "KEY_I"},
    {description = "KEY_J", data = "KEY_J"},
    {description = "KEY_K", data = "KEY_K"},
    {description = "KEY_L", data = "KEY_L"},
    {description = "KEY_M", data = "KEY_M"},
    {description = "KEY_N", data = "KEY_N"},
    {description = "KEY_O", data = "KEY_O"},
    {description = "KEY_P", data = "KEY_P"},
    {description = "KEY_Q", data = "KEY_Q"},
    {description = "KEY_R", data = "KEY_R"},
    {description = "KEY_S", data = "KEY_S"},
    {description = "KEY_T", data = "KEY_T"},
    {description = "KEY_U", data = "KEY_U"},
    {description = "KEY_V", data = "KEY_V"},
    {description = "KEY_W", data = "KEY_W"},
    {description = "KEY_X", data = "KEY_X"},
    {description = "KEY_Y", data = "KEY_Y"},
    {description = "KEY_Z", data = "KEY_Z"},
    {description = "KEY_F1", data = "KEY_F1"},
    {description = "KEY_F2", data = "KEY_F2"},
    {description = "KEY_F3", data = "KEY_F3"},
    {description = "KEY_F4", data = "KEY_F4"},
    {description = "KEY_F5", data = "KEY_F5"},
    {description = "KEY_F6", data = "KEY_F6"},
    {description = "KEY_F7", data = "KEY_F7"},
    {description = "KEY_F8", data = "KEY_F8"},
    {description = "KEY_F9", data = "KEY_F9"},

}

configuration_options =
{
    {
      name = "SWTCH_WIDGET_KEY",
      label = "轮盘界面",
      hover = "轮盘界面,切换模式",
      options = keys_option,
      default = "KEY_F1",
    },
    {
      name = "UNLOCK_WIDGET_KEY",
      label = "解锁进度界面",
      hover = "解锁进度界面，查看当前武器的解锁进度",
      options = keys_option,
      default = "KEY_F3",
    },
    {
      name = "DEBUG_MODE",
      label = "测试模式",
      hover = "进入测试模式，解锁某些东西",
      options = {
        {description = "开", data = true},
        {description = "关", data = false},
      },
      default = false,
    },
  
}