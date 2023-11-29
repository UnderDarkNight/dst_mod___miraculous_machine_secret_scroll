-- 本文件和 modmain.lua 同级别

if Assets == nil then
    Assets = {}
end

local temp_assets = {


	Asset( "IMAGE", "images/inventoryimages/miraculous_machine_secret_scroll.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/miraculous_machine_secret_scroll.xml" ),
	Asset( "IMAGE", "images/inventoryimages/miraculous_machine_secret_scroll_red.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/miraculous_machine_secret_scroll_red.xml" ),

	Asset("IMAGE", "images/ui_images/mms_scroll_widget.tex"),
	Asset("ATLAS", "images/ui_images/mms_scroll_widget.xml"),

	Asset("IMAGE", "images/ui_images/mms_scroll_unlock_progress_material.tex"),
	Asset("ATLAS", "images/ui_images/mms_scroll_unlock_progress_material.xml"),
	Asset("IMAGE", "images/ui_images/mms_scroll_unlock_widget.tex"),
	Asset("ATLAS", "images/ui_images/mms_scroll_unlock_widget.xml"),



	Asset("ANIM", "anim/mms_scroll_sword_red.zip"),
	Asset("ANIM", "anim/mms_scroll_sword_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_axe_red.zip"),
	Asset("ANIM", "anim/mms_scroll_axe_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_bow.zip"),
	Asset("ANIM", "anim/mms_scroll_bow_red.zip"),
	Asset("ANIM", "anim/mms_scroll_bow_blue.zip"),


	Asset("ANIM", "anim/mms_scroll_shovel_red.zip"),
	Asset("ANIM", "anim/mms_scroll_shovel_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_bugnet_red.zip"),
	Asset("ANIM", "anim/mms_scroll_bugnet_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_trident_red.zip"),
	Asset("ANIM", "anim/mms_scroll_trident_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_hammer_red.zip"),
	Asset("ANIM", "anim/mms_scroll_hammer_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_razor_red.zip"),
	Asset("ANIM", "anim/mms_scroll_razor_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_pickaxe_red.zip"),
	Asset("ANIM", "anim/mms_scroll_pickaxe_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_fishingrod_red.zip"),
	Asset("ANIM", "anim/mms_scroll_fishingrod_blue.zip"),

	Asset("ANIM", "anim/mms_scroll_till_red.zip"),
	Asset("ANIM", "anim/mms_scroll_till_blue.zip"),

}

for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

-- AddMinimapAtlas("images/map_icons/npc_item_treasure_map.xml")	----- 小地图上的标记得用这个func 在modmain 里加载
RegisterInventoryItemAtlas("images/inventoryimages/miraculous_machine_secret_scroll.xml", "miraculous_machine_secret_scroll.tex")
RegisterInventoryItemAtlas("images/inventoryimages/miraculous_machine_secret_scroll_red.xml", "miraculous_machine_secret_scroll_red.tex")