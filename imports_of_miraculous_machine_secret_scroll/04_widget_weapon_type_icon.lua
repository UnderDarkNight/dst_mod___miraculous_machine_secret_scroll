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
--------------------------------------------------------------------------------------------------------------------
--- 基础的文件读写函数
    local function IsClientSide()
        if TheNet:IsDedicated() then
            return false
        end
        return true
    end
    local function Get_Data_File_Name()
        return "mms_scroll_data.text"
    end
    local function Read_All_Json_Data()

        local function Read_data_p()
            local file = io.open(Get_Data_File_Name(), "r")
            local text = file:read('*line')
            file:close()
            return text
        end

        local flag,ret = pcall(Read_data_p)

        if flag == true then
            local retTable = json.decode(ret)
            return retTable
        else
            print("FWD_IN_PDT ERROR :read cross archived data error : Read_All_Json_Data got nil")
            return {}
        end
    end

    local function Write_All_Json_Data(json_data)
        local w_data = json.encode(json_data)
        local file = io.open(Get_Data_File_Name(), "w")
        file:write(w_data)
        file:close()
    end

    local function Get_Cross_Archived_Data_By_userid(userid)
        local temp_json_data = Read_All_Json_Data() or {}
        return temp_json_data[userid] or {}                
    end

    local function Set_Cross_Archived_Data_By_userid(userid,_table)
        if not IsClientSide() then  --- 只在客户端这一侧执行数据写入
            return
        end

        local temp_json_data = Read_All_Json_Data() or {}
        -- temp_json_data[userid] = _table
        temp_json_data[userid] = temp_json_data[userid] or {}
        for index, value in pairs(_table) do
            temp_json_data[userid][index] = value
        end
        temp_json_data = deepcopy(temp_json_data)
        Write_All_Json_Data(temp_json_data)
    end
--------------------------------------------------------------------------------------------------------------------

    local function SaveLoaction(x_percent,y_percent)
        local temp_table = Get_Cross_Archived_Data_By_userid(ThePlayer.userid) or {}
        temp_table.x_percent = x_percent
        temp_table.y_percent = y_percent
        Set_Cross_Archived_Data_By_userid(ThePlayer.userid, temp_table)
    end
    local function ReadLocation()
        local temp_table = Get_Cross_Archived_Data_By_userid(ThePlayer.userid) or {}
        local x_percent = temp_table.x_percent or 0.5
        local y_percent = temp_table.y_percent or 0.5
        return x_percent,y_percent
    end
--------------------------------------------------------------------------------------------------------------------


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
                    local main_scale_num = 0.45
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
                        root.x_percent ,root.y_percent = ReadLocation()

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
                                "images/ui_images/mms_scroll_widget.xml",
                                "status_bar.tex",
                                "status_bar.tex",
                                "status_bar.tex",
                                "status_bar.tex",
                                "status_bar.tex"
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
                                                    SaveLoaction(root.x_percent,root.y_percent)

                                                end
                                            end)
                                    end                            
                            end)
                -----------------------------------------------------------------------------------------------------------------
                ----- 指示
                    local weapon_types = {
                        ["NONE"] = "NONE",
                        ["switch.orange_staff"] = "orangestaff_mini_black.tex",
                        ["switch.fishingrod"]   = "fishingrod_mini_black.tex",
                        ["switch.bugnet"]   = "bugnet_mini_black.tex",
                        ["switch.trident"]   = "trident_mini_black.tex",
                        ["switch.long_range_weapon"]   = "bow_mini_black.tex",
                        ["switch.short_range_weapon"]   = "sword_mini_black.tex",
                        ["switch.tools"]   = "tools_mini_black.tex",
                        ["switch.blink_map"]   = "blink_map_mini_black.tex",
                        ["switch.razor"]   = "razor_mini_black.tex",
                        ["switch.music"]   = "music_mini_black.tex",
                    }
                    local state_icon = temp_button:AddChild(Image())
                    -- state_icon:SetTexture("images/ui_images/mms_scroll_widget.xml","background.tex")
                    state_icon:SetPosition(0,0)
                    state_icon:Hide()
                    -- state_icon:SetScale(main_scale_num,main_scale_num,main_scale_num)

                    ----- 水上行走
                        local state_water_run = temp_button:AddChild(Image())
                        state_water_run:SetPosition(90,0)
                        state_water_run:SetTexture("images/ui_images/mms_scroll_widget.xml","water_run_mini_black.tex")
                        state_water_run:SetScale(0.8,0.8,0.8)
                        state_water_run:Hide()
                    ----- 防沙镜
                        local state_goggles = temp_button:AddChild(Image())
                        state_goggles:SetPosition(-90,0)
                        state_goggles:SetTexture("images/ui_images/mms_scroll_widget.xml","goggles_mini_black.tex")
                        state_goggles:SetScale(0.8,0.8,0.8)
                        state_goggles:Hide()

                    self.miraculous_machine_secret_scroll_widget_inst:DoPeriodicTask(0.3,function()
                        if weapon_inst and weapon_inst:IsValid() then
                            local state_imag = weapon_types[weapon_inst.replica.miraculous_machine_secret_scroll:Get("type")] or "locked.tex"
                            state_icon:Show()
                            state_icon:SetTexture("images/ui_images/mms_scroll_widget.xml",state_imag)

                            if weapon_inst:HasTag("ocean_walking_switch") then
                                state_water_run:Show()
                            else
                                state_water_run:Hide()
                            end

                            if weapon_inst:HasTag("goggles") then
                                state_goggles:Show()
                            else
                                state_goggles:Hide()
                            end
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