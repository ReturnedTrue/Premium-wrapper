--// Written by ReturnedTrue
--// A simple wrapper module for people who want a straight to the point API

--// Dependencies
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");

--// Cosntants
local PLAYER_COLLISION_GROUP_NAME = "%s_COLLISION_GROUP";
local DOOR_COLLISION_GROUP_NAME = "%s_DOOR_COLLISION_GROUP";

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

    return Player.MembershipType == Enum.MembershipType.Premium or Player.Name == "ReturnedTrue"; --// TESTING
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
    assert(typeof(Tool) == "Instance", "Expected Tool, got " .. typeof(Tool));
    assert(Tool:IsA("Tool"), "Expected Tool, got " .. Tool.ClassName);

    local function GiveTool(Player)
        local Clone1, Clone2 = Tool:Clone(), Tool:Clone();
        Clone1.Parent = Player.Backpack;
        Clone2.Parent = Player.StarterGear;
    end

    self:BindOnJoin(GiveTool);
    self:BindOnChange(GiveTool);
end

function PremiumWrapper:BindExclusiveDoor(Door)
    assert(typeof(Door), "Expected Model or BasePart, got " .. typeof(Door));
    assert(Door:IsA("Model") or Door:IsA("BasePart"), "Expected Model or BasePart, got " .. Door.ClassName);

    local DoorKey = string.format(DOOR_COLLISION_GROUP_NAME, Door.Name);
    PhysicsService:CreateCollisionGroup(DoorKey);

    if (Door:IsA("Model")) then
        for _, Part in ipairs(Door:GetDescendants()) do
            Part.CanCollide = true;
            PhysicsService:SetPartCollisionGroup(Part, DoorKey);
        end
    else
        Door.CanCollide = true;
        PhysicsService:SetPartCollisionGroup(Door, DoorKey);
    end

    local function SetupDoor(Player)
        local PlayerKey = string.format(PLAYER_COLLISION_GROUP_NAME, Player.Name);
        PhysicsService:CreateCollisionGroup(PlayerKey);
        PhysicsService:CollisionGroupSetCollidable(DoorKey, PlayerKey, false);

        local function CharacterAppearanceLoaded(Character)
            for _, Part in ipairs(Character:GetDescendants()) do
                if (Part:IsA("BasePart")) then
                    PhysicsService:SetPartCollisionGroup(Part, PlayerKey);
                end
            end
        end
        
        if (Player.Character) then
            CharacterAppearanceLoaded(Player.Character);
        end

        Player.CharacterAppearanceLoaded:Connect(CharacterAppearanceLoaded);
    end

    self:BindOnJoin(SetupDoor);
    self:BindOnChange(SetupDoor);
end

return PremiumWrapper;