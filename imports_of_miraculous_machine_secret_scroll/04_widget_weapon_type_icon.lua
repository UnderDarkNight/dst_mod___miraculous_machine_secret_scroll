------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 武器当前状态图标
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Widget = require "widgets/widget"
local Image = require "widgets/image" -- 引入image控件
local UIAnim = require "widgets/uianim"


local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local TEMPLATES = require "widgets/redux/templates"

-------------------------------------------- 能量条的坐标储存
    -- AddPlayerPostInit(function(inst)    

    --     inst:ListenForEvent("fwd_in_pdt_event.Cross_Archived_Data_Send_2_Server_Finish",function()
    --         if inst.HUD and inst.HUD.fwd_in_pdt_wellness then
    --             local pt_percent_of_screen = inst.replica.fwd_in_pdt_func:Get_Cross_Archived_Data("wellness_bars_screen_xy")
    --             -- print("error +++++++++++++ ")
    --             if pt_percent_of_screen and pt_percent_of_screen.x_percent then
    --                 inst.HUD.fwd_in_pdt_wellness.x_percent = pt_percent_of_screen.x_percent
    --                 inst.HUD.fwd_in_pdt_wellness.y_percent = pt_percent_of_screen.y_percent
    --                 inst.HUD.fwd_in_pdt_wellness:LocationScaleFix()
    --             end

    --             ----- 
    --             local wellness_main_icon_hide_flag = inst.replica.fwd_in_pdt_func:Get_Cross_Archived_Data("wellness_main_icon_hide_flag")
    --             if wellness_main_icon_hide_flag then
    --                 inst.HUD.fwd_in_pdt_wellness:HideMainIcon(true)
    --             else
    --                 inst.HUD.fwd_in_pdt_wellness:HideMainIcon(false)                    
    --             end

    --         end
    --     end)

    --     --------- 监听 体质条 的移动和储存数据到跨存档保存表
    --     inst:DoTaskInTime(1,function()
    --         if inst.HUD and inst.HUD.fwd_in_pdt_wellness then
    --             inst:ListenForEvent("fwd_in_pdt_wellness_bars.save_cmd",function(_,cmd_table)
    --                 if type(cmd_table) ~= "table" then
    --                     return
    --                 end
    --                 if cmd_table.pt and cmd_table.pt.x_percent then
    --                     inst.replica.fwd_in_pdt_func:Set_Cross_Archived_Data("wellness_bars_screen_xy",cmd_table.pt)
    --                 end
    --                 if cmd_table.HideMainIcon ~= nil then
    --                     inst.replica.fwd_in_pdt_func:Set_Cross_Archived_Data("wellness_main_icon_hide_flag",cmd_table.HideMainIcon)
    --                 end

    --             end)
    --         end
    --     end)

    -- end)

-------------------- 直接在这添加界面节点和数据

AddClassPostConstruct("widgets/controls", function(self, owner)
    ------ 把界面挂载到  owner.HUD 里面，方便调用
    if owner == nil or owner.HUD == nil then
        return
    end
    -----------------------------------------------------------------------------------------------------------------
        local weapon_inst = nil
        function ThePlayer.HUD:miraculous_machine_secret_scroll_widget_open(__weapon_inst)
                -----------------------------------------------------------------------------------------------------------------
                weapon_inst = __weapon_inst
                if weapon_inst == nil then
                    return
                end
                if self.miraculous_machine_secret_scroll_widget ~= nil then
                    return
                end
                -----------------------------------------------------------------------------------------------------------------
                self.miraculous_machine_secret_scroll_widget_inst = CreateEntity()
                -----------------------------------------------------------------------------------------------------------------
                ----- 添加主节点
                    local main_scale_num = 0.6
                    local root = self:AddChild(Widget())
                    -------- 设置锚点
                        root:SetHAnchor(1) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
                        root:SetVAnchor(2) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
                        root:SetPosition(100,100)
                        root:MoveToBack()
                    -------- 设置缩放模式
                        root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   
                        owner.HUD.miraculous_machine_secret_scroll_widget = root        --- 挂载到  HUD节点，方便replica 调用
                    -------- 启动坐标跟随缩放循环任务，缩放的时候去到指定位置。官方好像没预留这类API，或者暂时找不到方法
                        function root:LocationScaleFix()
                            if self.x_percent and not self.__mouse_holding  then
                                local scrnw, scrnh = TheSim:GetScreenSize()
                                if self.____last_scrnh ~= scrnh then
                                    local tarX = self.x_percent * scrnw
                                    local tarY = self.y_percent * scrnh
                                    self:SetPosition(tarX,tarY)
                                end
                                self.____last_scrnh = scrnh
                            end
                        end

                        owner:DoPeriodicTask(0.3,function()
                            root:LocationScaleFix()
                        end)
                -----------------------------------------------------------------------------------------------------------------
                ----- 往主节点添加透明按钮
                            local temp_button = root:AddChild(ImageButton(
                                "images/ui_images/miraculous_machine_secret_scroll_icon.xml",
                                "miraculous_machine_secret_scroll_icon.tex",
                                "miraculous_machine_secret_scroll_icon.tex",
                                "miraculous_machine_secret_scroll_icon.tex",
                                "miraculous_machine_secret_scroll_icon.tex",
                                "miraculous_machine_secret_scroll_icon.tex"
                            ))



                            temp_button:SetScale(main_scale_num,main_scale_num,main_scale_num)

                            temp_button:SetOnDown(function()                      --- 鼠标按下去的时候
                                    if not root.__mouse_holding  then
                                        root.__mouse_holding = true      --- 上锁
                                            --------- 添加鼠标移动监听任务
                                            root.___follow_mouse_event = TheInput:AddMoveHandler(function(x, y)  
                                                root:SetPosition(x,y,0)
                                            end)
                                            --------- 添加鼠标按钮监听
                                            root.___mouse_button_up_event = TheInput:AddMouseButtonHandler(function(button, down, x, y) 
                                                if button == MOUSEBUTTON_LEFT and down == false then    ---- 左键被抬起来了
                                                    root.___mouse_button_up_event:Remove()       ---- 清掉监听
                                                    root.___mouse_button_up_event = nil

                                                    root.___follow_mouse_event:Remove()          ---- 清掉监听
                                                    root.___follow_mouse_event = nil

                                                    root:SetPosition(x,y,0)                      ---- 设置坐标
                                                    root.__mouse_holding = false                 ---- 解锁

                                                    local scrnw, scrnh = TheSim:GetScreenSize()
                                                    root.x_percent = x/scrnw
                                                    root.y_percent = y/scrnh

                                                    -- owner:PushEvent("fwd_in_pdt_wellness_bars.save_cmd",{    --- 发送储存坐标。
                                                    --     pt = {x_percent = root.x_percent,y_percent = root.y_percent},
                                                    -- })

                                                end
                                            end)
                                    end                            
                            end)
                -----------------------------------------------------------------------------------------------------------------
                ----- 添加文字
                    local inside_text = temp_button:AddChild(Text(TALKINGFONT,50,"XXXXX",{ 0/255 , 255/255 ,0/255 , 1}))
                    inside_text:Hide()
                    local weapon_types = {
                        ["NONE"] = "NONE",
                        ["switch.orange_staff"] = "懒人",
                        ["switch.purple_staff"] = "传送",
                    }
                    self.miraculous_machine_secret_scroll_widget_inst:DoPeriodicTask(0.3,function()
                        if weapon_inst and weapon_inst:IsValid() then
                            inside_text:Show()
                            inside_text:SetString(weapon_types[weapon_inst.replica.miraculous_machine_secret_scroll:Get("type") or "NONE"])
                        end
                    end)
                -----------------------------------------------------------------------------------------------------------------
        end
    -----------------------------------------------------------------------------------------------------------------
        function ThePlayer.HUD:miraculous_machine_secret_scroll_widget_close()
            if self.miraculous_machine_secret_scroll_widget then
                self.miraculous_machine_secret_scroll_widget:Kill()
                self.miraculous_machine_secret_scroll_widget = nil

                self.miraculous_machine_secret_scroll_widget_inst:Remove()
            end
        end
    
    

    -----------------------------------------------------------------------------------------------------------------
    


end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------