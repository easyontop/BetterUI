---
sidebar_position: 3
---

# Switch

:::danger
You must use :setParent or the switch will <b>NOT</b> be created.
:::

<h3>Example</h3>

```lua
-- LocalScript (Recommended)
local player = game:GetService"Players".LocalPlayer
local _L = require(path.to.BetterUI).Switch -- Replace with the BetterUI Interface you placed into! ReplicatedStorage is recommended.
local gs = player.PlayerGui.gameGui -- what your gui named (Gui Instance is required for it to work!!!)

local g = _L.new()
g:setParent(gs) -- replace with the parent you want to set!!
g:setPosition(UDim2.new(0.5, 0, 0.5, 0))
g:setAnchorPoint(Vector2.new(0.5, 0.5))
g:setSize(UDim2.new(0, 100, 0, 30)) -- Replace with scale if you want.
g:setPadding(5, 5)
g:setBgColor(Color3.new(0.001, 0.001, 0.001))
g:setCorner(UDim.new(0, 2048))
g:setEnableColor(Color3.fromRGB(0, 255, 0))
g:setDisableColor(Color3.fromRGB(255, 0, 0))
g:setButtonCorner(UDim.new(0, 2048))
g:setButtonSize(0.5)
```