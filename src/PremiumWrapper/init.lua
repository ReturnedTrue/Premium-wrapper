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
    
    local function PlayerChanged(Player)
        if (self:PlayerIsPremium(Player)) then
            for _, Function in ipairs(self.BindedFunctionsOnChange) do
                Function(Player)
            end
        end
    end

    table.foreach(Players:GetPlayers(), PlayerAdded);
    Players.PlayerAdded:Connect(PlayerAdded);
    Players.PlayerMembershipChanged:Connect(PlayerChanged);

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
        error("Expected Player, got " .. Player.ClassName);
    end

    return Player.MembershipType == Enum.MembershipType.Premium;
end

function PremiumWrapper:BindOnJoin(Function)
    assert(typeof(Function) == "function", "Expected function, got " .. typeof(Function));
    
    table.insert(self.BindedFunctionsOnJoin, Function);
end

function PremiumWrapper:BindOnChange(Function)
    assert(typeof(Function) == "function", "Expected function, got " .. typeof(Function));
    
    table.insert(self.BindedFunctionsOnChange, Function);
end

function PremiumWrapper:BindExclusiveTool(Tool)
    local function GiveTool(Player)
        local Clone1, Clone2 = Tool:Clone(), Tool:Clone();
        Clone1.Parent = Player.Backpack
        Clone2.Parent = Player.StarterGear
    end

    self:BindOnJoin(GiveTool)
    self:BindOnChange(GiveTool)
end