
local prefab_name = "miraculous_machine_secret_scroll"
STRINGS.NAMES[string.upper(prefab_name)] = "神机密卷"
STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(prefab_name)] = "拥有很多功能的卷轴"
STRINGS.RECIPE_DESC[string.upper(prefab_name)] = "拥有很多功能的卷轴"



--------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("miraculous_machine_secret_scroll","WEAPONS")     ---- 添加物品到目标标签
AddRecipe2(
    "miraculous_machine_secret_scroll",            --  --  inst.prefab  实体名字
    { Ingredient("log", 1),Ingredient("papyrus", 1),Ingredient("goldnugget", 1) }, 
    TECH.SCIENCE_ONE, --- TECH.NONE
    {
        -- nounlock=true,
        no_deconstruction=true,
        -- builder_tag = "npng_tag.has_green_amulet",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        -- placer = "fwd_in_pdt_building_special_cookpot_placer",                       -------- 建筑放置器        
        atlas = "images/inventoryimages/miraculous_machine_secret_scroll.xml",
        image = "miraculous_machine_secret_scroll.tex",
    },
    {"WEAPONS"}
)
RemoveRecipeFromFilter("miraculous_machine_secret_scroll","MODS")                       -- -- 在【模组物品】标签里移除这个。


