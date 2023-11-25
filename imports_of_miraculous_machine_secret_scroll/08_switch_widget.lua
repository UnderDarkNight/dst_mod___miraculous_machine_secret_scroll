------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    界面

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


    function self:mms_scroll_switch_widget_open(weapon_inst,cmd_table)
                ----------------------------------------------------------------
                    cmd_table = cmd_table or {}
                ----------------------------------------------------------------
                    if self.mms_scroll_switch_widget then
                        hud:mms_scroll_switch_widget_close()
                    end
                ----------------------------------------------------------------
                    local root = self:AddChild(Screen())
                    self.mms_scroll_switch_widget = root
                ----------------------------------------------------------------

                    ----------------------------------------------------------------
                        --- 指示文字
                        local temp_button_text_base = self:AddChild(Widget())
                        temp_button_text_base:SetHAnchor(1) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
                        temp_button_text_base:SetVAnchor(2) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
                        temp_button_text_base:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
                        temp_button_text_base:FollowMouse()
                        self.mms_scroll_switch_widget_button_text_base = temp_button_text_base

                        local temp_button_text = temp_button_text_base:AddChild(Text(TALKINGFONT,40,tostring("666666"),{ 255/255 , 255/255 ,255/255 , 1}))
                        temp_button_text:MoveToFront()
                        temp_button_text:SetPosition(0,50)
    
                        temp_button_text:Hide()
                        local function show_text(str)
                            temp_button_text:SetString(str)
                            temp_button_text:Show()
                        end
                        local function hide_text()
                            temp_button_text:Hide()
                        end    

                    ----------------------------------------------------------------


                ----------------------------------------------------------------

                ----------------------------------------------------------------
                    local main_scale_num = 0.8
                -------- 设置锚点
                    root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
                    root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
                    root:SetPosition(0,0)
                    root:MoveToBack()
                    root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
                -------- 添加主背景 
                    local background = root:AddChild(Image())
                    root.background = background
                    background:SetTexture("images/ui_images/mms_scroll_widget.xml","background.tex")
                    background:SetPosition(0,0)
                    background:Show()
                    background:SetScale(main_scale_num,main_scale_num,main_scale_num)
                    background:MoveToBack()
                ----------------------------------------------------------------
                        local function create_button(button_cmd)
                            button_cmd = button_cmd or {}
                            local image = button_cmd.image
                            local click_fn  = button_cmd.click_fn
                            local x = button_cmd.x or 0
                            local y = button_cmd.y or 0
                            local locked = button_cmd.locked or false
                            local the_str = button_cmd.str or ""
                            if locked then
                                image = "locked.tex"
                            end

                            local temp_button = root:AddChild(ImageButton(
                                    "images/ui_images/mms_scroll_widget.xml",
                                    image,
                                    image,
                                    image,
                                    image,
                                    image
                            ))
                            temp_button.locked = locked
                            temp_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
                            temp_button:SetPosition(x,y)
                            temp_button.click_fn = click_fn
                            temp_button.OnMouseButton__mms_scroll_old = temp_button.OnMouseButton
                            temp_button.OnMouseButton = function(self,button,down,x,y)
                                local ret = self.OnMouseButton__mms_scroll_old(self,button,down,x,y)
                                if button == MOUSEBUTTON_LEFT and down == false then
                                    ret = true
                                    ------------------------------------------------
                                        if type(self.click_fn) == "function" and not self.locked then
                                            self.click_fn()
                                        end
                                    ------------------------------------------------
                                    hud:mms_scroll_switch_widget_close()
                                end
                                return ret
                            end



                            temp_button.ongainfocus = function()
                                show_text(the_str)
                                ThePlayer:DoTaskInTime(0,function()
                                    show_text(the_str)                                    
                                end)
                            end
                            temp_button.onlosefocus = function()
                                hide_text()
                            end


                            return temp_button
                        end
                ----------------------------------------------------------------


                ----------------------------------------------------------------
                    for index, button_cmd in pairs(cmd_table) do
                        create_button(button_cmd)
                    end
                ----------------------------------------------------------------

                ----------------------------------------------------------------
                ----- 锁住角色移动操作
                    self:OpenScreenUnderPause(root)
                    root.__old_mms_scroll_OnControl = root.OnControl
                    root.OnControl = function(self,control, down)
                        -- print("widget key down",control,down)
                        if CONTROL_CANCEL == control and down == false or control == CONTROL_OPEN_DEBUG_CONSOLE then
                            hud:mms_scroll_switch_widget_close()
                        end
                        return self:__old_mms_scroll_OnControl(control,down)
                    end
                ----------------------------------------------------------------

                --- 图层调整
                    self.mms_scroll_switch_widget_button_text_base:MoveToFront()
                    root:MoveToBack()


                ----------------------------------------------------------------


    end

    function self:mms_scroll_switch_widget_close()
        if self.mms_scroll_switch_widget then
            TheFrontEnd:PopScreen(self.mms_scroll_switch_widget)

            self.mms_scroll_switch_widget_button_text_base:Kill()

            self.mms_scroll_switch_widget:Kill()
            self.mms_scroll_switch_widget = nil
        end
    end


end)