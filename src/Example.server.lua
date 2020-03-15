--// Written by ReturnedTrue
--// Example script for Premium wrapper module

--// Module
local Module = require(script.Parent.MainModule);

--// Init it
local Premium = Module.Init();

--// Print a Premium player joined/changed
local function Main(Player)
    print(Player, " is a Premium Roblox User!")
end

--// Create the binds
Premium:BindOnJoin(Main)
Premium:BindOnChange(Main)