-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- hook health or combat api
--- 实现 霸体
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                -- AddPlayerPostInit(function(inst)
                --     if not TheWorld.ismastersim then
                --         return
                --     end

                --     -- function Health:DoDelta(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
                --     if inst.components.health then

                --         local health_com = inst.components.health


                --         health_com.__mmss_fns = {}
                --         health_com.mms_scroll_dodelta_add_fn = function(self,fn)
                --             if type(fn) == "function" then
                --                 table.insert(self.__mmss_fns, fn)
                --             end
                --         end
                --         health_com.mms_scroll_dodelta_remove_fn = function(self,fn)
                --             if type(fn) == "function" then
                --                 local new_fns = {}
                --                 for i, temp_fn in ipairs(self.__mmss_fns) do
                --                     if fn ~= temp_fn then
                --                         table.insert(new_fns, temp_fn)
                --                     end
                --                 end
                --                 self.__mmss_fns = new_fns
                --             end
                --         end


                --         health_com.DoDelta__mms_scroll_old = health_com.DoDelta
                --         health_com.DoDelta = function(self,amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
                --             for i, tempfn in ipairs(self.__mmss_fns) do
                --                 amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb =  tempfn(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
                --             end
                --             return self:DoDelta__mms_scroll_old(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
                --         end

                --     end


                -- end)


AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end
        
    -- function Combat:GetAttacked(attacker, damage, weapon, stimuli, spdamage)
    
    local combat_com = inst.components.combat

    if combat_com then

        combat_com._mms_scroll_rigid_fns = {}

        combat_com.mms_scroll_add_rigid_fn = function(self,fn)
            if type(fn) == "function" then
                table.insert(self._mms_scroll_rigid_fns,fn)
            end            
        end
        combat_com.mms_scroll_remove_rigid_fn = function(self,fn)
            if type(fn) == "function" then
                local new_table = {}
                for i, temp_fn in ipairs(self._mms_scroll_rigid_fns) do
                    if temp_fn ~= fn then
                        table.insert(new_table, temp_fn)
                    end
                end
                self._mms_scroll_rigid_fns = new_table
            end
        end



        combat_com.GetAttacked__mms_scroll_old = combat_com.GetAttacked
        combat_com.GetAttacked = function(self , attacker, damage, weapon, stimuli, spdamage )
            for i, temp_fn in ipairs(self._mms_scroll_rigid_fns) do
                attacker, damage, weapon, stimuli, spdamage = temp_fn(attacker, damage, weapon, stimuli, spdamage)
            end
            return self:GetAttacked__mms_scroll_old( attacker, damage, weapon, stimuli, spdamage )
        end

    end


end)