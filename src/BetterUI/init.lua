local RunService = game:GetService("RunService")
if RunService:IsClient() then
	return error("BetterUIError: This script is a server module. It should be imported in server-sided scripts.")
end
local CreateGui = require(script:WaitForChild("CreateGui"))
local Gui = game:GetService("StarterGui"):FindFirstChild("BetterUIInterface") or CreateGui()
local lib = {
    ["Switch"] = require(script:WaitForChild"Library":WaitForChild"Switch");
	["Alert"] = require(script:WaitForChild("Library"):WaitForChild("Alert"));
	["Gui"] = Gui;
}
return lib