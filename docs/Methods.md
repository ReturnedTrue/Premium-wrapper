# Init
!> You are required to use this function to get the PremiumWrapper class.
<!-- tabs:start -->

#### **Description**
After requiring the Module, you will need to Init it.
You can do this via calling Init, this will return the PremiumWrapper class.


#### **Code Example**
```lua
local PremiumWrapper = Module.Init()
```

#### **Arguments**
No arguments.

#### **Returned**
- PremiumWrapper [table]

<!-- tabs:end -->

# PlayerIsPremium
?> If you do not supply the Player, and this is client-side, then it will return based on the LocalPlayer.

<!-- tabs:start -->

#### **Description**
This function will return true if the Player passed is a Premium user.

#### **Code Example**
```lua
if (PremiumWrapper:PlayerIsPremium(Player)) then
    print("They're Premium!")
end
```

#### **Arguments**
- Player to check [Instance:Player]

#### **Returned**
- If they are a Premium user [boolean]

<!-- tabs:end -->

# BindOnJoin

<!-- tabs:start -->

#### **Description**
Binds a function to run when a Player who's Premium joins.

#### **Code Example**
```lua
local function PremiumPlayerJoined(Player)
    print(Player, "joined who is a Premium user.")
end

PremiumWrapper:BindOnJoin(PremiumPlayerJoined)
```

#### **Arguments**
- Function to bind [function]

#### **Returned**
- Nothing returned.

<!-- tabs:end -->

# BindOnChange
!> This only runs the binded function __when a Player changes Membership to Premium__, please use BindOnJoin for when a Premium user joins.

<!-- tabs:start -->

#### **Description**
Binds a function to run when a Player Membership changes to Premium.

#### **Code Example**
```lua
local function PlayerChanged(Player)
    print(Player .. "'s Membership changed and is now a Premium user,")
end

PremiumWrapper:BindOnChange(PlayerChanged)
```

#### **Arguments**
- Function to bind [function]

#### **Returned**
- Nothing returned.

<!-- tabs:end -->

# BindExclusiveTool

<!-- tabs:start -->

#### **Description**
Binds an exclusive Tool given to Premium users.

#### **Code Example**
```lua
PremiumWrapper:BindExclusiveTool(workspace.Tool)
```

#### **Arguments**
- Tool to bind [Instance:Tool]

#### **Returned**
- Nothing returned.

<!-- tabs:end -->

# BindExclusiveDoor
!> Due to replication, this only affects Collisions and not Transparency.

<!-- tabs:start -->

#### **Description**
Binds a door which a Premium user can walk through.

#### **Code Example**
```lua
PremiumWrapper:BindExclusiveDoor(workspace.Door)
```

#### **Arguments**
- Door to bind [Instance:BasePart | Instance:Model]

#### **Returned**
- Nothing returned.

<!-- tabs:end -->