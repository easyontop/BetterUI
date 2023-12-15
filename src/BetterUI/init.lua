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
	@since 1.0.0
	@prop Switch SwitchLibrary
	@within BetterUI
]=]
--[=[
	@since 1.0.1
	@prop Alert AlertLibrary
	@within BetterUI
]=]
--[=[
	@since 2.0.0
	@prop Progress ProgressLibrary
	@within BetterUI
]=]
--[=[
	@private
	@readonly
	@since 1.0.1
	@prop Gui ScreenGui
	@within BetterUI
	:::danger
	Overwriting this variable will directly break the module.
	:::
]=]

--[=[
	@server
	@since 3.0.0
	@prop Firebase FirebaseService
	@within BetterUI
]=]

local lib = {
    ["Switch"] = require(script:WaitForChild"Library":WaitForChild"Switch");
	["Alert"] = require(script:WaitForChild("Library"):WaitForChild("Alert"));
	["Progress"] = require(script:WaitForChild"Library":WaitForChild"Progress");
	["Gui"] = Gui;
	["Firebase"] = require(script:WaitForChild"Extra":WaitForChild"Firebase");
}

if RunService:IsServer() then
	return lib
else
	lib.Firebase = nil
	return lib
end