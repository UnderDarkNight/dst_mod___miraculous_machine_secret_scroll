GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})


Assets = {
	-- Asset("SCRIPT", "lib/lib_test3.lua"),
}

modimport("imports_of_miraculous_machine_secret_scroll/__All_imports_init.lua")	---- 所有 import 

PrefabFiles = 
{
	"_miraculous_machine_secret_scroll",	---- 穿戴的物品
}



