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

local current_page = 1


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
        -- ["bugnet"] = true,
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
        -- ["orangestaff"] = true,
        ["orangestaff_mini"] = true,
        ["orangestaff_mini_black"] = true,
        -- ["razor"] = true,
        ["razor_mini"] = true,
        ["razor_mini_black"] = true,
        ["sword"] = true,
        ["sword_mini"] = true,
        ["sword_mini_black"] = true,
        ["tools"] = true,
        ["tools_mini"] = true,
        ["tools_mini_black"] = true,
        -- ["trident"] = true,
        ["trident_mini"] = true,
        ["trident_mini_black"] = true,
        ["water_run"] = true,
        ["water_run_mini"] = true,
        ["water_run_mini_black"] = true,
    }
    local monster_imgs = {
        ["alterguardian_phase1"] = true,
        ["alterguardian_phase2"] = true,
        ["alterguardian_phase3"] = true,
        ["antlion"] = true,
        ["bearger"] = true,
        ["crabking"] = true,
        ["daywalker"] = true,
        ["deerclops"] = true,
        ["dragonfly"] = true,
        ["klaus"] = true,
        ["lightninggoat"] = true,
        ["lightninggoat_charged"] = true,
        ["leif"] = true,
        ["little_walrus"] = true,
        ["lordfruitfly"] = true,
        ["malbatross"] = true,
        ["minotaur"] = true,
        ["moose"] = true,
        ["shadow_bishop"] = true,
        ["shadow_knight"] = true,
        ["shadow_rook"] = true,
        ["shadowthrall_hands"] = true,
        ["shadowthrall_horns"] = true,
        ["shadowthrall_wings"] = true,
        ["spiderqueen"] = true,
        ["stalker_atrium"] = true,
        ["toadstool"] = true,
        ["toadstool_dark"] = true,
        ["twinofterror1"] = true,
        ["twinofterror2"] = true,
        ["walrus"] = true,
    }
    local function create_image(_table)
        -- local _table = {
        --     base = base,
        --     x = 0,
        --     y = 0,
        --     scale = 1,
        --     image = "box_frame_blue",
        --     a = 1,
        --     angle = 0,
        -- }

        local image = nil
        if _table.image ~= nil then

                local atlas = "images/ui_images/mms_scroll_unlock_progress_material.xml"
                if GetInventoryItemAtlas(_table.image..".tex") then
                    atlas = GetInventoryItemAtlas(_table.image..".tex")
                end


                if background_imgs[_table.image] then
                    atlas = "images/ui_images/mms_scroll_unlock_widget.xml"
                elseif state_button_img[_table.image] then
                    atlas = "images/ui_images/mms_scroll_widget.xml"
                elseif monster_imgs[_table.image] then
                    atlas = "images/ui_images/mms_scroll_unlock_progress_material.xml" 
                end

        
                image = _table.base:AddChild(Image())
                image:SetTexture(atlas,_table.image..".tex")
        else
                image = _table.base:AddChild(Widget())
        end    


        image:SetPosition(_table.x or 0,_table.y or 0)
        image:SetFadeAlpha(_table.a or 1,true)
        local scale = _table.scale or 1
        image:SetScale(scale,scale,1)
        if _table.angle then
            image:SetRotation(_table.angle)
        end

        return image
    end

    local pages_fns = {}

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 1 页
        pages_fns[1] = function(current_page,max_page)
            -------------------------------------------------------------------------------------
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------

            create_text({base = page, x = 0, y = 100, str = "物品等级", size = 60})

            -------------------------------------------------------------------------------------
            ---- 等级
                local opalpreciousgem = create_image({base = page , x = -100, y = -30, image = "opalpreciousgem", scale = 1 , a = 1})
                local num = com:Get("weapon_level.num") or 0
                local str = tostring(num) .. " / 60"
                create_text({base = page, x = -100, y = -130, str = str, size = 40})
            -------------------------------------------------------------------------------------
            ---- 移动速度
                if not ( com:Get("monster.kill.walrus") and com:Get("monster.kill.little_walrus") ) then

                        local box = create_image({base = page , x = 100 , y = -30 , image = "box_frame_red" ,scale = 0.5})
                        local cane =  create_image({base = box , x = 0 , y = 0 , image = "cane" ,scale = 1.5})
                        local lock =  create_image({base = box , x = 0 , y = 0 , image = "lock_red" ,scale = 1 ,a = 0.5})

                        if ( com:Get("monster.kill.walrus") or 0 ) == 0 then
                            local walrus = create_image({base = box , x = -50 , y = -200 , image = "walrus" ,scale = 0.5})
                        end
                        if ( com:Get("monster.kill.little_walrus") or 0) == 0 then
                            local little_walrus = create_image({base = box , x = 50 , y = -200 , image = "little_walrus" ,scale = 0.5})
                        end
                
                else


                        local cane =  create_image({base = page , x = 100 , y = -30 , image = "cane" ,scale = 1.5})
                        local cane_num = com:Get("cane.num") or 0
                        local cane_str = tostring(cane_num) .. " / 14"
                        create_text({base = page, x = 100, y = -130, str = cane_str, size = 40})

                end

            -------------------------------------------------------------------------------------
            ---- 页码
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})

            return page
        end        
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 2 页
        pages_fns[2] = function(current_page,max_page)
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 20, y = 100, str = "近战、远程攻击距离", size = 60})

            -------------------------------------------------------------------------------------
            --- 近战

                local sword_mini_black = create_image({base = page , x = -100 , y = 20 , image = "sword_mini_black" ,scale = 0.5})
                local goldnugget = create_image({base = page , x = -100 , y = -60 , image = "goldnugget" ,scale = 1})
                local goldnugget_num = com:Get("goldnugget.num") or 0
                local goldnugget_str = tostring(goldnugget_num) .. " / 100"
                create_text({base = page, x = -100, y = -130, str = goldnugget_str, size = 40})
            -------------------------------------------------------------------------------------
            --- 远程
                local bow = create_image({base = page , x = 130 , y = 20 , image = "bow_mini_black" ,scale = 0.5})

                local spiderqueen_num = com:Get("boss.kill.spiderqueen") or 0
                if spiderqueen_num == 0 then

                    local spiderqueen = create_image({base = page , x = 130 , y = -60 , image = "spiderqueen" ,scale = 0.3})
                    local spiderqueen_str = tostring(spiderqueen_num) .. " / 1"
                    create_text({base = page, x = 130, y = -130, str = spiderqueen_str, size = 40})

                else

                    local silk = create_image({base = page , x = 130 , y = -60 , image = "silk" ,scale = 1.5})
                    local silk_num = com:Get("silk.num") or 0
                    local silk_str = tostring(silk_num) .. " / 400"
                    create_text({base = page, x = 130, y = -130, str = silk_str, size = 40})

                end
            -------------------------------------------------------------------------------------


            ---- 页码
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})


            return page
        end
        
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 3 页
        pages_fns[3] = function(current_page,max_page)
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 20, y = 100, str = "传送、图跳", size = 60})

            -------------------------------------------------------------------------------------
            --- 橙色法杖

                local orangestaff_num = com:Get("orangestaff.num") or 0
                if orangestaff_num == 0 then

                    local box_frame_blue = create_image({base = page , x = -100 , y = -20 , image = "box_frame_blue" ,scale = 0.5})
                    local orangestaff = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "orangestaff" ,scale = 2})
                    local lock_blue = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "lock_blue" ,scale = 1 , a = 0.5})
                    local orangestaff_str = tostring(orangestaff_num) .. " / 1"
                    create_text({base = box_frame_blue, x = 0, y = -200, str = orangestaff_str, size = 80})


                else   

                    local orangegem = create_image({base = page , x = -150 , y = -20 , image = "orangegem" ,scale = 0.7})
                    local orangegem_num = com:Get("orangegem.num") or 0
                    local orangegem_str = tostring(orangegem_num) .. " / 10"
                    create_text({base = page, x = -150, y = -100, str = orangegem_str, size = 40})

                    local nightmarefuel = create_image({base = page , x = -30 , y = -20 , image = "nightmarefuel" ,scale = 1.2})
                    local nightmarefuel_num = com:Get("nightmarefuel.num") or 0
                    local nightmarefuel_str = tostring(nightmarefuel_num) .. " / 100"
                    create_text({base = page, x = -30, y = -100, str = nightmarefuel_str, size = 40})

                end

            -------------------------------------------------------------------------------------
            --- 紫色法杖

                if com:Get("telestaff.num") == nil then
                    local box_frame_red = create_image({base = page , x = 150 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                    local telestaff = create_image({base = box_frame_red , x = 0 , y = 0 , image = "telestaff" ,scale = 2})
                    local lock_red = create_image({base = box_frame_red , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                    local telestaff_str = tostring(com:Get("telestaff.num") or 0) .. " / 1"
                    create_text({base = box_frame_red, x = 0, y = -200, str = telestaff_str, size = 80})

                else

                    local purplegem = create_image({base = page , x = 150 , y = -20 , image = "purplegem" ,scale = 0.7})
                    local purplegem_str = tostring( com:Get("purplegem.num") or 0 ) .. " / 20"
                    create_text({base = page, x = 150, y = -100, str = purplegem_str, size = 40})

                end


            -------------------------------------------------------------------------------------
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})

            -------------------------------------------------------------------------------------
            return page
        end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 4 页
        pages_fns[4] = function(current_page,max_page)
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 20, y = 100, str = "钓鱼、捕虫", size = 60})

            -------------------------------------------------------------------------------------
            --- 钓鱼

                    local fishingrod_level_num = com:Get("fishingrod_level.num") or 0

                    local pondeel = create_image({base = page , x = -130 , y = -20 , image = "pondeel" ,scale = 1.5})
                    local pondfish = create_image({base = page , x = -60 , y = -20 , image = "pondfish" ,scale = 1.5})
                    local fishingrod_mini_black = create_image({base = page , x = -140 , y = 30 , image = "fishingrod_mini_black" ,scale = 0.5})

                    local fishingrod_level_str = tostring(fishingrod_level_num) .. " / 100"
                    create_text({base = page, x = -90, y = -100, str = fishingrod_level_str, size = 40})
                

            -------------------------------------------------------------------------------------
            --- 捕虫网

                if com:Get("bugnet.num") == nil then
                    
                    local box_frame_red = create_image({base = page , x = 150 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                    local bugnet = create_image({base = box_frame_red , x = 0 , y = 0 , image = "bugnet" ,scale = 2})
                    local lock_red = create_image({base = box_frame_red , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                    local telestaff_str = tostring(com:Get("bugnet.num") or 0) .. " / 1"
                    create_text({base = box_frame_red, x = 0, y = -200, str = telestaff_str, size = 80})

                else

                    local fireflies = create_image({base = page , x = 150 , y = -20 , image = "fireflies" ,scale = 1.5})
                    local fireflies_str = tostring( com:Get("fireflies.num") or 0 ) .. " / 100"
                    create_text({base = page, x = 150, y = -100, str = fireflies_str, size = 40})

                end


            -------------------------------------------------------------------------------------
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})

            -------------------------------------------------------------------------------------
            return page
        end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 5 页
        pages_fns[5] = function(current_page,max_page)
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 20, y = 100, str = "工具", size = 60})

            -------------------------------------------------------------------------------------
            --- 斧头
                    if (com:Get("axe_level.num") or 0) == 0 then

                        local box_frame_blue = create_image({base = page , x = -180 , y = -20 , image = "box_frame_blue" ,scale = 0.5})
                        local axe = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "axe" ,scale = 2})
                        local lock_blue = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "lock_blue" ,scale = 1 , a = 0.5})
                        local axe_str = tostring(com:Get("axe_level.num") or 0) .. " / 1"
                        create_text({base = box_frame_blue, x = 0, y = -200, str = axe_str, size = 80})

                    else

                        local box_frame_blue = page:AddChild(Widget())
                        box_frame_blue:SetPosition(-180,-20)
                        box_frame_blue:SetScale(0.5,0.5,1)
                        local axe = create_image({base = box_frame_blue , x = 0 , y = 80 , image = "axe" ,scale = 2})
                        local goldenaxe = create_image({base = box_frame_blue , x = -60 , y = 0 , image = "goldenaxe" ,scale = 2})
                        local moonglassaxe = create_image({base = box_frame_blue , x = 60 , y = 0 , image = "moonglassaxe" ,scale = 2})
                        local multitool_axe_pickaxe = create_image({base = box_frame_blue , x = 0 , y = -80 , image = "multitool_axe_pickaxe" ,scale = 2,angle = 30})
                        local axe_str = tostring(com:Get("axe_level.num") or 0) .. " / 1000"
                        create_text({base = box_frame_blue, x = 0, y = -200, str = axe_str, size = 80})

                    end
                

            -------------------------------------------------------------------------------------
            --- 矿镐
                    if (com:Get("pickaxe_level.num") or 0) == 0 then

                        local box_frame_blue2 = create_image({base = page , x = -50 , y = -20 , image = "box_frame_blue" ,scale = 0.5})
                        local pickaxe = create_image({base = box_frame_blue2 , x = 0 , y = 0 , image = "pickaxe" ,scale = 2})
                        local lock_blue = create_image({base = box_frame_blue2 , x = 0 , y = 0 , image = "lock_blue" ,scale = 1 , a = 0.5})
                        local pickaxe_str = tostring(com:Get("pickaxe_level.num") or 0) .. " / 1"
                        create_text({base = box_frame_blue2, x = 0, y = -200, str = pickaxe_str, size = 80})

                    else
                            

                        local box_frame_blue2 = page:AddChild(Widget())
                        box_frame_blue2:SetPosition(-50,-20)
                        box_frame_blue2:SetScale(0.5,0.5,1)
                        local pickaxe = create_image({base = box_frame_blue2 , x = 0 , y = 80 , image = "pickaxe" ,scale = 2})
                        local goldenpickaxe = create_image({base = box_frame_blue2 , x = -60 , y = 0 , image = "goldenpickaxe" ,scale = 2})
                        local pickaxe_lunarplant = create_image({base = box_frame_blue2 , x = 60 , y = 0 , image = "pickaxe_lunarplant" ,scale = 2})
                        local multitool_axe_pickaxe = create_image({base = box_frame_blue2 , x = 0 , y = -80 , image = "multitool_axe_pickaxe" ,scale = 2,angle = 30})
                        local pickaxe_level_str = tostring(com:Get("pickaxe_level.num") or 0) .. " / 1000"
                        create_text({base = box_frame_blue2, x = 0, y = -200, str = pickaxe_level_str, size = 80})

                    end


            -------------------------------------------------------------------------------------
            --- 铲子
                if com:Get("shovel_level.full") ~= true then

                    local box_frame_red = create_image({base = page , x = 80 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                    local shovel = create_image({base = box_frame_red , x = 0 , y = 0 , image = "shovel" ,scale = 2})
                    local lock_red = create_image({base = box_frame_red , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                    local shovel_str = tostring(com:Get("shovel_level.full") and 1 or 0) .. " / 1"
                    create_text({base = box_frame_red, x = 0, y = -200, str = shovel_str, size = 80})

                else
                    

                    local box_frame_red = create_image({base = page , x = 80 , y = -20 , scale = 0.5})
                    local shovel = create_image({base = box_frame_red , x = 0 , y = 0 , image = "shovel" ,scale = 2})
                    local shovel_str = "1 / 1"
                    create_text({base = box_frame_red, x = 0, y = -200, str = shovel_str, size = 80})

                end

            -------------------------------------------------------------------------------------
            --- 锤子

                if com:Get("hammer_level.full") ~= true then

                        local box_frame_red2 = create_image({base = page , x = 220 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                        local hammer = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "hammer" ,scale = 2})
                        local lock_red = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                        local hammer_str = "0 / 1"
                        create_text({base = box_frame_red2, x = 0, y = -200, str = hammer_str, size = 80})

                else                        

                        local box_frame_red2 = create_image({base = page , x = 220 , y = -20 , scale = 0.5})
                        local hammer = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "hammer" ,scale = 2})
                        local hammer_str = "1 / 1"
                        create_text({base = box_frame_red2, x = 0, y = -200, str = hammer_str, size = 80})

                end
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})

            -------------------------------------------------------------------------------------
            return page
        end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---- 第 6 页
        pages_fns[6] = function(current_page,max_page)
            -------------------------------------------------------------------------------------  
                local page = root:AddChild(Widget())
                page:SetPosition(-50,0)
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 20, y = 100, str = "三叉戟、剃刀、护目镜、乐器", size = 60})

            -------------------------------------------------------------------------------------
            --- 三叉戟
                    if (com:Get("trident_level.num") or 0) == 0 then

                        local box_frame_blue = create_image({base = page , x = -180 , y = -20 , image = "box_frame_blue" ,scale = 0.5})
                        local trident = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "trident" ,scale = 2})
                        local lock_blue = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "lock_blue" ,scale = 1 , a = 0.5})
                        create_text({base = box_frame_blue, x = 0, y = -200, str = "0 / 1", size = 80})

                    else

                        local box_frame_blue = create_image({base = page , x = -180 , y = -20 ,scale = 0.5})
                        local trident = create_image({base = box_frame_blue , x = 0 , y = 0 , image = "trident" ,scale = 2})
                        create_text({base = box_frame_blue, x = 0, y = -200, str = "1 / 1", size = 80})

                    end
                

            -------------------------------------------------------------------------------------
            --- 剃刀
                    if (com:Get("razor_level.num") or 0) == 0 then

                        local box_frame_blue2 = create_image({base = page , x = -50 , y = -20 , image = "box_frame_blue" ,scale = 0.5})
                        local razor = create_image({base = box_frame_blue2 , x = 0 , y = 0 , image = "razor" ,scale = 2})
                        local lock_blue = create_image({base = box_frame_blue2 , x = 0 , y = 0 , image = "lock_blue" ,scale = 1 , a = 0.5})
                        create_text({base = box_frame_blue2, x = 0, y = -200, str = "0 / 1", size = 80})

                    else
                            
                        local box_frame_blue2 = create_image({base = page , x = -50 , y = -20 ,scale = 0.5})
                        local razor = create_image({base = box_frame_blue2 , x = 0 , y = 0 , image = "razor" ,scale = 2})
                        create_text({base = box_frame_blue2, x = 0, y = -200, str = "1 / 1", size = 80})


                    end


            -------------------------------------------------------------------------------------
            --- 护目镜
                if com:Get("goggles_level.full") ~= true then

                    local box_frame_red = create_image({base = page , x = 80 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                    local moonstorm_goggleshat = create_image({base = box_frame_red , x = -20 , y = 20 , image = "moonstorm_goggleshat" ,scale = 2})
                    local deserthat = create_image({base = box_frame_red , x = 20 , y = -20 , image = "deserthat" ,scale = 2})
                    local lock_red = create_image({base = box_frame_red , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                    create_text({base = box_frame_red, x = 0, y = -200, str = "0 / 1", size = 80})

                else
                    

                    local box_frame_red = create_image({base = page , x = 80 , y = -20 ,scale = 0.5})
                    local moonstorm_goggleshat = create_image({base = box_frame_red , x = -20 , y = 20 , image = "moonstorm_goggleshat" ,scale = 2})
                    local deserthat = create_image({base = box_frame_red , x = 20 , y = -30 , image = "deserthat" ,scale = 2})
                    create_text({base = box_frame_red, x = 0, y = -200, str = "1 / 1", size = 80})

                end

            -------------------------------------------------------------------------------------
            --- 乐器

                if com:Get("boss.kill.lordfruitfly") == nil then

                        local box_frame_red2 = create_image({base = page , x = 220 , y = -20 , image = "box_frame_red" ,scale = 0.5})
                        local onemanband = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "onemanband" ,scale = 2})
                        local lock_red = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "lock_red" ,scale = 1 , a = 0.5})
                        -- create_text({base = box_frame_red2, x = 0, y = -200, str = "0 / 1", size = 80})
                        create_image({base = box_frame_red2 , x = 0 , y = -200 , image = "lordfruitfly" ,scale = 1 })
                else                        

                    local box_frame_red2 = create_image({base = page , x = 220 , y = -20  ,scale = 0.5})
                    local onemanband = create_image({base = box_frame_red2 , x = 0 , y = 0 , image = "onemanband" ,scale = 2})
                    create_text({base = box_frame_red2, x = 0, y = -200, str = "1 / 1", size = 80})

                end
            -------------------------------------------------------------------------------------
                create_text({base = page, x = 30, y = -200, str = tostring(current_page).." / "..tostring(max_page), size = 25})

            -------------------------------------------------------------------------------------
            return page
        end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- pages_fns[#pages_fns]()  --- 只显示最后一页

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----- 上下页面切换
            local pages_layer = {}
            for i, temp_fn in ipairs(pages_fns) do
                local temp_page = temp_fn(i,#pages_fns)
                table.insert(pages_layer,temp_page)
                temp_page:Hide()
            end

            local max_page = #pages_fns

            current_page = max_page

            pages_layer[current_page]:Show()


            function root:_next_page()
                pages_layer[current_page]:Hide()

                current_page = current_page + 1
                if current_page > max_page then
                    current_page  = 1
                end
                pages_layer[current_page]:Show()
            end
            function root:_last_page()
                pages_layer[current_page]:Hide()

                current_page = current_page - 1
                if current_page <= 0 then
                    current_page  = max_page
                end
                pages_layer[current_page]:Show()
            end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

end