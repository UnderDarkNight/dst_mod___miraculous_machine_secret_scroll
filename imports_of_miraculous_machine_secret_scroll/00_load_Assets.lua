-- 本文件和 modmain.lua 同级别

if Assets == nil then
    Assets = {}
end

local temp_assets = {


	-- Asset("IMAGE", "images/inventoryimages/npcdebugstone.tex"),
	-- Asset("ATLAS", "images/inventoryimages/npcdebugstone.xml"),
	
	-- Asset("IMAGE", "images/inventoryimages/default.tex"),
	-- Asset("ATLAS", "images/inventoryimages/default.xml"),

	-- Asset("IMAGE", "images/inventoryimages/spell_reject_the_npc.tex"),
	-- Asset("ATLAS", "images/inventoryimages/spell_reject_the_npc.xml"),
	-- Asset("IMAGE", "images/inventoryimages/npc_item_tree_trade_station_kit.tex"),
	-- Asset("ATLAS", "images/inventoryimages/npc_item_tree_trade_station_kit.xml"),
	-- Asset("IMAGE", "images/inventoryimages/npc_item_sign_for_sale.tex"),
	-- Asset("ATLAS", "images/inventoryimages/npc_item_sign_for_sale.xml"),


	-- Asset("ANIM", "anim/anim_test.zip"),
	-- Asset("ANIM", "anim/test_anim.zip"),


	-- Asset( "IMAGE", "images/map_icons/npc_item_treasure_map.tex" ),  
    -- Asset( "ATLAS", "images/map_icons/npc_item_treasure_map.xml" ),


	-- Asset("ANIM", "anim/kriby_action_test.zip"),
	-- Asset("ANIM", "anim/xzkb_xin_donghua_fuhuo.zip"),


	Asset("IMAGE", "images/ui_images/miraculous_machine_secret_scroll_icon.tex"),
	Asset("ATLAS", "images/ui_images/miraculous_machine_secret_scroll_icon.xml"),
}

for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

-- AddMinimapAtlas("images/map_icons/npc_item_treasure_map.xml")	----- 小地图上的标记得用这个func 在modmain 里加载
