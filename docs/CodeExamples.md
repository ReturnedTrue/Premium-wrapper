?> All of these Examples require the PremiumWrapper to be Parented to ReplicatedStorage.

# Basic example
Show a Message on the Screen when a Premium user joins.
```lua
local Module = require(game:GetService("ReplicatedStorage").PremiumWrapper);
local PremiumWrapper = Module.Init();

local function PremiumPlayerJoin(Player)
    local Message = Instance.new("Message");
    Message.Text = string.format("A Premium Player named %s joined!", Player.Name);
    Message.Parent = workspace;

    wait(3);
    Message:Destroy();
end

PremiumWrapper:BindOnJoin(PremiumPlayerJoin);
```
___
!> More soon!