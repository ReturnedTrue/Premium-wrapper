--// Written by ReturnedTrue
--// A simple wrapper module for people who want a straight to the point API

--// Dependencies
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");

--// Class
local PremiumWrapper = {};
PremiumWrapper.__index = PremiumWrapper;

--// Functions
function PremiumWrapper.Init()
    local self = setmetatable({
        BindedFunctionsOnChange = {};
        BindedFunctionsOnJoin = {};
    }, PremiumWrapper);

    local function PlayerAdded(Player)
        if (self:PlayerIsPremium(Player)) then
            for _, Function in ipairs(self.BindedFunctionsOnJoin) do
                Function(Player);
            end
        end
    end
    
    Players.PlayerAdded:Connect(PlayerAdded);
    table.foreach(Players:GetPlayers(), PlayerAdded);

    return self;
end

function PremiumWrapper:PlayerIsPremium(Player)
    if (Player == nil) then
        if (RunService:IsClient()) then
            Player = Players.LocalPlayer;
        else
            error("Expected Player, got nil!");
        end
    elseif (not typeof(Player) == "Instance") then
        error("Expected Player, got " .. typeof(Player));
    elseif (not Player:IsA("Player")) then
        error("Expected Player, got ", Player.ClassName);
    end

    return Player.MembershipType == Enum.MembershipType.Premium
end

