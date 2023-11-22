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


AddClassPostConstruct("screens/playerhud",function(self)
    local hud = self


    function self:mms_scroll_switch_widget_open(weapon_inst,cmd_table)
                ----------------------------------------------------------------
                    cmd_table = cmd_table or {}
                ----------------------------------------------------------------
                    if self.mms_scroll_switch_widget then
                        -- self.mms_scroll_switch_widget:Kill()
                        hud:mms_scroll_switch_widget_close()
                    end
                    local root = self:AddChild(Screen())
                    self.mms_scroll_switch_widget = root
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
                    background:SetTexture("images/ui_images/mms_scroll_switch_widget.xml","background.tex")
                    background:SetPosition(0,0)
                    background:Show()
                    background:SetScale(main_scale_num,main_scale_num,main_scale_num)
                ----------------------------------------------------------------
                        local function create_button(image,x,y,click_fn)
                            local temp_button = root:AddChild(ImageButton(
                                    "images/ui_images/mms_scroll_switch_widget.xml",
                                    image,
                                    image,
                                    image,
                                    image,
                                    image
                            ))
                            temp_button:SetScale(main_scale_num,main_scale_num,main_scale_num)
                            temp_button:SetPosition(x,y)
                            temp_button.click_fn = click_fn
                            temp_button.OnMouseButton__mms_scroll_old = temp_button.OnMouseButton
                            temp_button.OnMouseButton = function(self,button,down,x,y)
                                local ret = self.OnMouseButton__mms_scroll_old(self,button,down,x,y)
                                if button == MOUSEBUTTON_LEFT and down == false then
                                    ret = true
                                    ------------------------------------------------
                                        if type(self.click_fn) == "function" then
                                            self.click_fn()
                                        end
                                    ------------------------------------------------
                                    hud:mms_scroll_switch_widget_close()
                                end
                                return ret
                            end
                            return temp_button
                        end
                ----------------------------------------------------------------
                            -- cmd_table = cmd_table or {
                            --     ["button_blink_map"] = { x = 0, y = 200 },

                            --     ["button_bow"] = { x = 100, y = 100 },

                            --     ["button_sword"] = { x = -100, y = 100 },

                            --     ["button_tools"] = { x = 0, y = -10 },

                                
                            --     ["button_goggle"] = { x = -300, y = -180 },
                            --     ["button_music"] = { x = -150, y = -180 },
                            --     ["button_orange"] = { x = 0, y = -180 },
                            --     ["button_razor"] = { x = 150, y = -180 },
                            --     ["button_trident"] = { x = 300, y = -180 },


                            --     ["button_water_run"] = { x = -300, y = 180 },
                            --     ["button_light"] = { x = -300, y = 0 },

                            --     ["button_fishingrod"] = { x = 300, y = 180 },
                            --     ["button_bugnet"] = { x = 300, y = 0 },
                                

                            -- }
                ----------------------------------------------------------------
                        -- cmd_table.button_sword = cmd_table.button_sword or {}
                        -- local button_sword = create_button("button_sword.tex",cmd_table.button_sword.x or 0,cmd_table.button_sword.y or 0,cmd_table.button_sword.click_fn)

                        -- cmd_table.button_bow = cmd_table.button_bow or {}
                        -- local button_bow = create_button("button_bow.tex",cmd_table.button_bow.x or 0,cmd_table.button_bow.y or 0,cmd_table.button_bow.click_fn)

                        -- cmd_table.button_blink_map = cmd_table.button_blink_map or {}
                        -- local button_blink_map = create_button("button_blink_map.tex",cmd_table.button_blink_map.x or 0,cmd_table.button_blink_map.y or 0,cmd_table.button_blink_map.click_fn)

                        -- cmd_table.button_bugnet = cmd_table.button_bugnet or {}
                        -- local button_bugnet = create_button("button_bugnet.tex",cmd_table.button_bugnet.x or 0,cmd_table.button_bugnet.y or 0,cmd_table.button_bugnet.click_fn)

                        -- cmd_table.button_fishingrod = cmd_table.button_fishingrod or {}
                        -- local button_fishingrod = create_button("button_fishingrod.tex",cmd_table.button_fishingrod.x or 0,cmd_table.button_fishingrod.y or 0,cmd_table.button_fishingrod.click_fn)

                        -- cmd_table.button_goggle = cmd_table.button_goggle or {}
                        -- local button_goggle = create_button("button_goggle.tex",cmd_table.button_goggle.x or 0,cmd_table.button_goggle.y or 0,cmd_table.button_goggle.click_fn)

                        -- cmd_table.button_light = cmd_table.button_light or {}
                        -- local button_light = create_button("button_light.tex",cmd_table.button_light.x or 0,cmd_table.button_light.y or 0,cmd_table.button_light.click_fn)

                        -- cmd_table.button_music = cmd_table.button_music or {}
                        -- local button_music = create_button("button_music.tex",cmd_table.button_music.x or 0,cmd_table.button_music.y or 0,cmd_table.button_music.click_fn)

                        -- cmd_table.button_orange = cmd_table.button_orange or {}
                        -- local button_orange = create_button("button_orange.tex",cmd_table.button_orange.x or 0,cmd_table.button_orange.y or 0,cmd_table.button_orange.click_fn)

                        -- cmd_table.button_razor = cmd_table.button_razor or {}
                        -- local button_razor = create_button("button_razor.tex",cmd_table.button_razor.x or 0,cmd_table.button_razor.y or 0,cmd_table.button_razor.click_fn)

                        -- cmd_table.button_tools = cmd_table.button_tools or {}
                        -- local button_tools = create_button("button_tools.tex",cmd_table.button_tools.x or 0,cmd_table.button_tools.y or 0,cmd_table.button_tools.click_fn)

                        -- cmd_table.button_trident = cmd_table.button_trident or {}
                        -- local button_trident = create_button("button_trident.tex",cmd_table.button_trident.x or 0,cmd_table.button_trident.y or 0,cmd_table.button_trident.click_fn)

                        -- cmd_table.button_water_run = cmd_table.button_water_run or {}
                        -- local button_water_run = create_button("button_water_run.tex",cmd_table.button_water_run.x or 0,cmd_table.button_water_run.y or 0,cmd_table.button_water_run.click_fn)




                ----------------------------------------------------------------
                    for index, button_cmd in pairs(cmd_table) do
                        create_button(index..".tex",button_cmd.x or 0,button_cmd.y or 0,button_cmd.click_fn)
                    end
                ----------------------------------------------------------------
                ----- 锁住角色移动操作
                    self:OpenScreenUnderPause(root)
                    root.__old_mms_scroll_OnControl = root.OnControl
                    root.OnControl = function(self,control, down)
                        -- print("widget key down",control,down)
                        -- if CONTROL_CANCEL == control and down == false or control == CONTROL_OPEN_DEBUG_CONSOLE then
                        --     hud:mms_scroll_switch_widget_close()
                        -- end
                        return self:__old_mms_scroll_OnControl(control,down)
                    end
                ----------------------------------------------------------------





                ----------------------------------------------------------------


    end

    function self:mms_scroll_switch_widget_close()
        if self.mms_scroll_switch_widget then
            TheFrontEnd:PopScreen(self.mms_scroll_switch_widget)
            self.mms_scroll_switch_widget:Kill()
            self.mms_scroll_switch_widget = nil
        end
    end


end)