------------------------------------------------------------------------------------------------------------------------------
------ replica 模块
------ 根据服务器来的简单数据初始化本模块拥有的函数。
------ 可以传送简单的 数据table
------------------------------------------------------------------------------------------------------------------------------



local miraculous_machine_secret_scroll = Class(function(self, inst)
    self.inst = inst
    self.is_replica = true
    self.TempData = {}
    self.DataTable = {}
    -----------------------------------------------------------------------------------------------------------------------
    ---- 走 net_vars 下发数据，虽然有点延迟，但是问题不大
        self._simple_data_table_json_str = net_string(self.inst.GUID, "miraculous_machine_secret_scroll_net_json_str","miraculous_machine_secret_scroll_net_json_str") 
        if not TheWorld.ismastersim then
            self.inst:ListenForEvent("miraculous_machine_secret_scroll_net_json_str",function()
                -- print("replica: get data from net_vars")
                local str = self._simple_data_table_json_str:value()
                local crash_flag , temp_table = pcall(json.decode, str)
                if crash_flag then
                    self.DataTable  = temp_table
                end
            end)
        end    
    ----------------------------------------------------------------------------------------------------------------------- 
end)
-----------------------------------------------------------------------------------------------------------------------
---- 数据同步replica ，数据读取
    function miraculous_machine_secret_scroll:synchronized_data_2_replica(DataTable)
        self.DataTable = DataTable or {}
        local str = json.encode(self.DataTable)
        self._simple_data_table_json_str:set(str)
    end
    function miraculous_machine_secret_scroll:Get(index)
        if type(index) == "string"  then
            return self.DataTable[index]
        end
    end
    function miraculous_machine_secret_scroll:Set(index,value)
        if type(index) == "string"  then
            self.DataTable[index] = value
        end
    end
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

return miraculous_machine_secret_scroll