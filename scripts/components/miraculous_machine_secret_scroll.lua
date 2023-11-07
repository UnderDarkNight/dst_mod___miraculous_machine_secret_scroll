----------------------------------------------------------------------------------------------------------------------------------
-- 核心记录组件
----------------------------------------------------------------------------------------------------------------------------------
local miraculous_machine_secret_scroll = Class(function(self, inst)
    self.inst = inst
    self.DataTable = {}
    self.TempData = {}
end,
nil,
{

})
------------------------------------------------------------------------------------------------------------------------------
---- 同步数据前往replica
    function miraculous_machine_secret_scroll:synchronized_data_2_replica()
        local replica_com = self.inst.replica.miraculous_machine_secret_scroll or self.inst.replica._.miraculous_machine_secret_scroll
        if replica_com and replica_com.synchronized_data_2_replica then
            replica_com:synchronized_data_2_replica(self.DataTable)
        end
        self.inst:PushEvent("scroll_data_load_end")  --- 数据加载完成，广播发送事件，让武器切换到对应状态
    end
------------------------------------------------------------------------------------------------------------------------------
---- 基础的数据  读写加减
    function miraculous_machine_secret_scroll:SaveData(DataName_Str,theData)
        if DataName_Str then
            self.DataTable[DataName_Str] = theData
        end
        self:synchronized_data_2_replica() --- 同步所有数据去replica
    end

    function miraculous_machine_secret_scroll:ReadData(DataName_Str)
        if DataName_Str then
            if self.DataTable[DataName_Str] then
                return self.DataTable[DataName_Str]
            else
                return nil
            end
        end
    end
    function miraculous_machine_secret_scroll:Get(DataName_Str)
        return self:ReadData(DataName_Str)
    end
    function miraculous_machine_secret_scroll:Set(DataName_Str,theData)
        self:SaveData(DataName_Str, theData)
    end

    function miraculous_machine_secret_scroll:Add(DataName_Str,num)
        if self:Get(DataName_Str) == nil then
            self:Set(DataName_Str, 0)
        end
        if type(num) ~= "number" or type(self:Get(DataName_Str))~="number" then
            return
        end
        self:Set(DataName_Str, self:Get(DataName_Str) + num)
        return self:Get(DataName_Str)
    end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
--- 数据保存进存档里
    function miraculous_machine_secret_scroll:OnSave()
        local data =
        {
            DataTable = self.DataTable
        }

        return next(data) ~= nil and data or nil
    end

    function miraculous_machine_secret_scroll:OnLoad(data)
        if data.DataTable then
            self.DataTable = data.DataTable
        end
        self:synchronized_data_2_replica() --- 同步所有数据去replica
    end
------------------------------------------------------------------------------------------------------------------------------
return miraculous_machine_secret_scroll
