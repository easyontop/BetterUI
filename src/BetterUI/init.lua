local RunService = game:GetService("RunService")
if RunService:IsClient() then
	return error("BetterUIError: This script is a server module. It should be imported in server-sided scripts.")
end
local CreateGui = require(script:WaitForChild("CreateGui"))
local Gui = game:GetService("StarterGui"):FindFirstChild("BetterUIInterface") or CreateGui()

--[=[
	@class BetterUI
]=]
--[=[
	@prop Switch SwitchLibrary
	@within BetterUI
]=]
--[=[
	@prop Alert AlertLibrary
	@within BetterUI
]=]
--[=[
	@prop Progress ProgressLibrary
	@within BetterUI
]=]
--[=[
	@readonly
	@prop Gui ScreenGui
	@within BetterUI
	:::danger
	Overwriting this variable will directly break the module.
	:::
]=]
local lib = {
    ["Switch"] = require(script:WaitForChild"Library":WaitForChild"Switch");
	["Alert"] = require(script:WaitForChild("Library"):WaitForChild("Alert"));
	["Progress"] = require(script:WaitForChild"Library":WaitForChild"Progress");
	["Gui"] = Gui;
}

if RunService:IsServer() then
	return lib
else
	return lib
end