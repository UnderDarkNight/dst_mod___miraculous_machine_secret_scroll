------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    解锁界面

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Widget = require "widgets/widget"
local Image = require "widgets/image" -- 引入image控件
local UIAnim = require "widgets/uianim"


local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"



AddClassPostConstruct("screens/playerhud",function(self)
    local hud = self


    function self:mms_scroll_unlocked_widget_open(weapon_inst)
        ----------------------------------------------------------------
            hud:mms_scroll_switch_widget_close()    ---- 关闭另外一个界面
        ----------------------------------------------------------------
            if self.mms_scroll_unlocked_widget then
                hud:mms_scroll_unlocked_widget_close()
                return
            end
        ----------------------------------------------------------------
            local root = self:AddChild(Screen())
            self.mms_scroll_unlocked_widget = root
        ----------------------------------------------------------------
        
        ----------------------------------------------------------------
            local main_scale_num = 0.6
        -------- 设置锚点
            root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
            root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
            root:SetPosition(0,0)
            root:MoveToBack()
            root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
        -------- 添加主背景 
            local background = root:AddChild(Image())
            root.background = background
            background:SetTexture("images/ui_images/mms_scroll_unlock_widget.xml","background.tex")
            background:SetPosition(0,0)
            background:Show()
            background:SetScale(main_scale_num,main_scale_num,main_scale_num)
        ----------------------------------------------------------------
        ---- 每一页 
            local fn = require("widgets/mms_scroll_unlock_widget_pages")
            -- local fn = dofile(resolvefilepath("scripts/widgets/mms_scroll_unlock_widget_pages.lua"))
            if type(fn) == "function" then
                local crash_flag,reason = pcall(fn,root,weapon_inst)
                if not crash_flag then
                    print("error")
                    print(reason)
                end
                -- fn(root,weapon_inst)
            end
        ----------------------------------------------------------------
        ---- 上一页
            local last_button = root:AddChild(ImageButton(
                "images/ui_images/mms_scroll_unlock_widget.xml",
                "last_button.tex",
                "last_button.tex",
                "last_button.tex",
                "last_button.tex",
                "last_button.tex"
            ))
            last_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
            last_button:SetPosition(-350,-230)
            last_button:SetOnClick(function()
                if root._last_page then
                    root:_last_page()
                end
            end)
        ----------------------------------------------------------------
        ---- 下一页
            local next_button = root:AddChild(ImageButton(
                "images/ui_images/mms_scroll_unlock_widget.xml",
                "next_button.tex",
                "next_button.tex",
                "next_button.tex",
                "next_button.tex",
                "next_button.tex"
            ))
            next_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
            next_button:SetPosition(275,-230)
            next_button:SetOnClick(function()
                if root._next_page then
                    root:_next_page()
                end
            end)
        ----------------------------------------------------------------
        ---- 关闭按钮
            local close_button = root:AddChild(ImageButton(
                "images/ui_images/mms_scroll_unlock_widget.xml",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex",
                "close_button.tex"
            ))
            close_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
            close_button:SetPosition(350,150)
            close_button:SetOnClick(function()
                ThePlayer:DoTaskInTime(0,function()
                    hud:mms_scroll_unlocked_widget_close()
                end)
            end)
        ----------------------------------------------------------------
        ----- 锁住角色移动操作
            self:OpenScreenUnderPause(root)
            root.__old_mms_scroll_OnControl = root.OnControl
            root.OnControl = function(self,control, down)
                -- print("widget key down",control,down)
                if CONTROL_CANCEL == control and down == false or control == CONTROL_OPEN_DEBUG_CONSOLE then
                    hud:mms_scroll_unlocked_widget_close()
                end
                return self:__old_mms_scroll_OnControl(control,down)
            end
        ----------------------------------------------------------------



    end

    function self:mms_scroll_unlocked_widget_close()
        if self.mms_scroll_unlocked_widget then
            TheFrontEnd:PopScreen(self.mms_scroll_unlocked_widget)
            self.mms_scroll_unlocked_widget:Kill()
            self.mms_scroll_unlocked_widget = nil
        end
    end

end)