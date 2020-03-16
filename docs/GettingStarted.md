
# Getting started
To firstly get the Premium wrapper module, you can either:
1. Require it with the assetid, for example:

```lua
local Module = require(4786661926);
```
?> Requiring it by the assetid will give you the most recent module version, furthermore updates and bug fixes!

---

2. Get the [Model](https://www.roblox.com/library/4786661926/PremiumWrapper), put it into your game and require it by the path, for example if you put it in ReplicatedStorage:

```lua
local Module = require(game:GetService("ReplicatedStorage").PremiumWrapper);
```

!> The module doesn't require to be in ReplicatedStorage, however it is recommended to.