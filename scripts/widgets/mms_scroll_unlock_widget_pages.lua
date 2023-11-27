------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    解锁界面
    每一页

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Widget = require "widgets/widget"
local Image = require "widgets/image" -- 引入image控件
local UIAnim = require "widgets/uianim"


local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"



return function(root,inst)
    if inst == nil then
        return
    end
    local com = inst.replica.miraculous_machine_secret_scroll or inst.replica._.miraculous_machine_secret_scroll
    if com == nil or com.Get == nil then
        return
    end

    -- local text = root:AddChild(Text(TALKINGFONT,40,tostring("卷轴等级"),{ 255/255 , 255/255 ,255/255 , 1}))
    -- text:SetPosition(0,50)

    -- local background = root:AddChild(Image())
    -- root.background = background
    -- background:SetTexture("images/ui_images/mms_scroll_widget.xml","background.tex")
    -- background:SetPosition(0,0)
    -- background:SetScale(main_scale_num,main_scale_num,main_scale_num)

    local function create_text(_table)
        -- local _table = {
        --     base = base,
        --     str = str,
        --     x = x,
        --     y = y,
        --     size = size,
        --     font = TALKINGFONT,
        --     color = { 255/255 , 255/255 ,255/255 , 255/255},
        -- }
        -- local text = base:AddChild(Text(TALKINGFONT,size or 40,tostring(str),{ 255/255 , 255/255 ,255/255 , 1}))
        -- text:SetPosition(x or 0,y or 0)
        local text = _table.base:AddChild(   Text(_table.font or TALKINGFONT,_table.size or 40,tostring(_table.str),_table.color or { 255/255 , 255/255 ,255/255 ,1})   )
        text:SetPosition(_table.x or 0,_table.y or 0)
        return text
    end

    local background_imgs = {
        ["box_frame_blue"] = true,
        ["box_frame_red"] = true,
        ["lock_blue"] = true,
        ["lock_red"] = true,
    }
    local state_button_img = {
        ["blink_map"] = true,
        ["blink_map_mini"] = true,
        ["blink_map_mini_black"] = true,
        ["bow"] = true,
        ["bow_mini"] = true,
        ["bow_mini_black"] = true,
        ["bugnet"] = true,
        ["bugnet_mini"] = true,
        ["bugnet_mini_black"] = true,
        ["fishingrod"] = true,
        ["fishingrod_mini"] = true,
        ["fishingrod_mini_black"] = true,
        ["goggles"] = true,
        ["goggles_mini"] = true,
        ["goggles_mini_black"] = true,
        ["light"] = true,
        ["light_mini"] = true,
        ["light_mini_black"] = true,
        ["music"] = true,
        ["music_mini"] = true,
        ["music_mini_black"] = true,
        ["orangestaff"] = true,
        ["orangestaff_mini"] = true,
        ["orangestaff_mini_black"] = true,
        ["razor"] = true,
        ["razor_mini"] = true,
        ["razor_mini_black"] = true,
        ["sword"] = true,
        ["sword_mini"] = true,
        ["sword_mini_black"] = true,
        ["tools"] = true,
        ["tools_mini"] = true,
        ["tools_mini_black"] = true,
        ["trident"] = true,
        ["trident_mini"] = true,
        ["trident_mini_black"] = true,
        ["water_run"] = true,
        ["water_run_mini"] = true,
        ["water_run_mini_black"] = true,
    }
    local function create_image(_table)
        -- local _table = {
        --     base = base,
        --     x = 0,
        --     y = 0,
        --     scale = 1,
        --     image = "box_frame_blue",
        --     a = 1,
        -- }

        local atlas = "images/ui_images/mms_scroll_unlock_progress_material.xml"
        if background_imgs[_table.image] then
            atlas = "images/ui_images/mms_scroll_unlock_widget.xml"
        elseif state_button_img[_table.image] then
            atlas = "images/ui_images/mms_scroll_widget.xml"
        end
        
        local image = _table.base:AddChild(Image())
        image:SetTexture(atlas,_table.image..".tex")
        image:SetPosition(_table.x or 0,_table.y or 0)
        image:SetFadeAlpha(_table.a or 1,true)
        local scale = _table.scale or 1
        image:SetScale(scale,scale,scale)
        return image
    end

    local pages_fns = {}

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        pages_fns[1] = function()        
            local page = root:AddChild(Widget())
            -------------------------------------------------------------------------------------

            create_text({base = page, x = -50, y = 100, str = "物品等级", size = 60})

            -------------------------------------------------------------------------------------
            ---- 等级
                local opalpreciousgem = create_image({base = page , x = -200, y = 0, image = "opalpreciousgem", scale = 1 , a = 1})
                local num = com:Get("weapon_level.num") or 0
                local str = tostring(num) .. " / 60"
                create_text({base = page, x = -200, y = -100, str = str, size = 40})
            -------------------------------------------------------------------------------------
            ---- 移动速度
                if not ( com:Get("monster.kill.walrus") and com:Get("monster.kill.little_walrus") ) then

                        local box = create_image({base = page , x = 100 , y = 0 , image = "box_frame_red" ,scale = 0.5})
                        local cane =  create_image({base = box , x = 0 , y = 0 , image = "cane" ,scale = 1.5})
                        local lock =  create_image({base = box , x = 0 , y = 0 , image = "lock_red" ,scale = 1 ,a = 0.5})

                        if ( com:Get("monster.kill.walrus") or 0 ) == 0 then
                            local walrus = create_image({base = box , x = -50 , y = -200 , image = "walrus" ,scale = 0.5})
                        end
                        if ( com:Get("monster.kill.little_walrus") or 0) == 0 then
                            local little_walrus = create_image({base = box , x = 50 , y = -200 , image = "little_walrus" ,scale = 0.5})
                        end
                
                else


                        local cane =  create_image({base = page , x = 100 , y = 0 , image = "cane" ,scale = 1.5})
                        local cane_num = com:Get("cane.num") or 0
                        local cane_str = tostring(cane_num) .. " / 14"
                        create_text({base = page, x = 100, y = -100, str = cane_str, size = 40})

                end

            -------------------------------------------------------------------------------------


            return page
        end        
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        pages_fns[2] = function()
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 0, y = 100, str = "近战、远程攻击距离", size = 60})

            -------------------------------------------------------------------------------------
            --- 远程
                local bow = create_image({base = page , x = 100 , y = 0 , image = "bow_mini_black" ,scale = 0.5})

                local spiderqueen_num = com:Get("boss.kill.spiderqueen") or 0
                if spiderqueen_num == 0 then

                    local spiderqueen = create_image({base = page , x = 100 , y = -80 , image = "spiderqueen" ,scale = 0.3})
                    local spiderqueen_str = tostring(spiderqueen_num) .. " / 1"
                    create_text({base = page, x = 100, y = -150, str = spiderqueen_str, size = 40})

                else

                    local silk = create_image({base = page , x = 100 , y = -80 , image = "silk" ,scale = 1.5})
                    local silk_num = com:Get("silk.num") or 0
                    local silk_str = tostring(silk_num) .. " / 400"
                    create_text({base = page, x = 100, y = -150, str = silk_str, size = 40})

                end
            -------------------------------------------------------------------------------------
            --- 近战

                local sword_mini_black = create_image({base = page , x = -100 , y = 0 , image = "sword_mini_black" ,scale = 0.5})

                local goldnugget = create_image({base = page , x = -100 , y = -80 , image = "goldnugget" ,scale = 1})

                local goldnugget_num = com:Get("goldnugget.num") or 0
                local goldnugget_str = tostring(goldnugget_num) .. " / 100"
                create_text({base = page, x = -100, y = -150, str = goldnugget_str, size = 40})
            -------------------------------------------------------------------------------------


            return page
        end        
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    pages_fns[#pages_fns]()


end