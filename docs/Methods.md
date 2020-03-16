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
- Player [Instance:Player] {Required}

#### **Returns**
- If they are a Premium user [boolean]

<!-- tabs:end -->