



local flg,error_code = pcall(function()
    print("WARNING: FX PCALL START +++++++++++++++++++++++++++++++++++++++++++++++++")
    local x,y,z =    ThePlayer.Transform:GetWorldPosition()
    -- ----------------------------------------------------------------------------------------------------------------
    -- TUNING.TEST_PARAM = {}
    
    -- local function IntColour(r, g, b, a)
    --     return { r / 255, g / 255, b / 255, a / 255 }
    -- end



    -- local SCALE_ENVELOPE_NAME_RAINBOW_POINT_NPC_FX = "SCALE_ENVELOPE_NAME_RAINBOW_POINT_NPC_FX"

    -- local NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINTS_DATA = {
    --     [1] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_RED" , Vector3(255,0,0) },
    --     [2] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_ORANGE" , Vector3(255,165,0) },
    --     [3] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_YELLOW" , Vector3(255,255,0) },
    --     [4] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_GREEN" , Vector3(0,255,0) },
    --     [5] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_CYAN" , Vector3(0,255,255) },
    --     [6] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_BLUE" , Vector3(0,0,255) },
    --     [7] = {"NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINT_PURPLE" , Vector3(139,0,255) }
    -- }

    -- TUNING.TEST_PARAM.InitEnvelope = function()
    --         local transparency = 200

    --         for i, temp_table in pairs(NPC_FX_COLOUR_ENVELOPE_NAME_RAINBOW_POINTS_DATA) do
    --             local name = temp_table[1]
    --             local color = temp_table[2]
    --             EnvelopeManager:AddColourEnvelope(
    --                 name,
    --                 {
    --                     -- { 0,    IntColour(color.x, color.y, color.z, transparency) },
    --                     { 0,    IntColour(255, 255, 255, transparency) },
    --                 }
    --             )
    --         end
            
    --         local scale_num = 0.2
    --         EnvelopeManager:AddVector2Envelope(
    --             SCALE_ENVELOPE_NAME_RAINBOW_POINT_NPC_FX,
    --             {
    --                 { 0,    { 0, 0 } },
    --                 { 0.3,  { scale_num, scale_num } },
    --                 { 0.8,  { scale_num, scale_num } },
    --                 { 1,    { 0, 0 } },
    --             }
    --         )
    -- end

    -- TUNING.TEST_PARAM.MAX_LIFETIME = 1.2
    -- local MAX_LIFETIME = TUNING.TEST_PARAM.MAX_LIFETIME
    -- TUNING.TEST_PARAM.emit_fn = function(effect, sphere_emitter)
    --     local vx, vy, vz = 0,0,0
    --     local lifetime = MAX_LIFETIME * (.9 + UnitRand() * .1)
    --     local px, py, pz = sphere_emitter()
    
    --     for i = 1, 7, 1 do
    --         local py_2 = 0.3*(i-1) + py
    --         effect:AddRotatingParticleUV(
    --             i-1,                --- 从0开始的
    --             lifetime,           -- lifetime
    --             px, py_2, pz,         -- position
    --             vx, vy, vz,         -- velocity
    --             math.random() * 360,--* 2 * PI, -- angle
    --             UnitRand() * 2,     -- angle velocity
    --             0, 0                -- uv offset
    --         )
    --     end

        
    -- end
    -- ----------------------------------------------------------------------------------------------------------------
    if ThePlayer.test_fx then
        ThePlayer.test_fx:Remove()
    end
    if ThePlayer.test_fx2 then
        ThePlayer.test_fx2:Remove()
    end

    ThePlayer.test_fx = ThePlayer:SpawnChild("rainbow_fx_test")
    ThePlayer:DoTaskInTime(0.5,function()
        ThePlayer.test_fx2 = ThePlayer:SpawnChild("rainbow_fx_test")
    end)
    -- local fx =     SpawnPrefab("rainbow_fx_test")
    -- fx.Transform:SetPosition(x, y, z)
    -- fx:DoTaskInTime(5,function()
    --     print("fx remove")
    --     fx:Remove()
    -- end)
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:FX PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/fx_test.lua"))
