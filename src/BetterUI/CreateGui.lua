return function ()
	local gui = Instance.new("ScreenGui", game:GetService("StarterGui"))
	gui.Name = "BetterUIInterface"
	gui.AutoLocalize = false
	gui.DisplayOrder = 10000
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
	gui.ScreenInsets = Enum.ScreenInsets.None
	
	-- Alerts
	
	local blurFrame = Instance.new("Frame", gui)
	blurFrame.Visible = false
	blurFrame.BackgroundColor3 = Color3.fromRGB(119, 119, 119)
	blurFrame.BackgroundTransparency = 0.4
	blurFrame.Size = UDim2.new(1, 0, 1, 0)
	blurFrame.Name = "BlurAlertFrame"
	blurFrame.Active = true
	
	local alert = Instance.new("Frame", gui)
	alert.Name = "AlertFrame"
	alert.AnchorPoint = Vector2.new(0.5, 0.5)
	alert.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	alert.Position = UDim2.new(0.5, 0, 0.5, 0)
	alert.Size = UDim2.new(0.3, 0, 0.4, 0)
	alert.Visible = false
	
	local alertc = Instance.new("UICorner", alert)
	alertc.CornerRadius = UDim.new(0, 12)
	
	local alertTitle = Instance.new("TextLabel", alert)
	alertTitle.AnchorPoint = Vector2.new(0.5, 0.5)
	alertTitle.BackgroundTransparency = 1
	alertTitle.Position = UDim2.new(0.5, 0, 0.125, 0)
	alertTitle.Size = UDim2.new(.8, 0, .1, 0)
	alertTitle.Name = "Title"
	alertTitle.Text = ""
	alertTitle.Font = Enum.Font.SourceSansBold
	alertTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	alertTitle.TextScaled = true
	alertTitle.TextXAlignment = Enum.TextXAlignment.Left
	
	local alertDesc = Instance.new("TextLabel", alert)
	alertDesc.Name = "Description"
	alertDesc.Text = ""
	alertDesc.AnchorPoint = Vector2.new(0.5, 0)
	alertDesc.Position = UDim2.new(0.5, 0, 0.2, 0)
	alertDesc.Size = UDim2.new(0.8, 0, 0.55, 0)
	alertDesc.Font = Enum.Font.Arial
	alertDesc.TextColor3 = Color3.new(1, 1, 1)
	alertDesc.TextSize = 20
	alertDesc.TextXAlignment = Enum.TextXAlignment.Left
	alertDesc.TextYAlignment = Enum.TextYAlignment.Top
	alertDesc.BackgroundTransparency = 1
	
	local alertDescUI = Instance.new("UITextSizeConstraint", alertDesc)
	alertDescUI.MaxTextSize = 20
	
	local btm = Instance.new("Frame", alert)
	btm.Name = "Bottom"
	btm.AnchorPoint = Vector2.new(0, 1)
	btm.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	btm.Position = UDim2.new(0, 0, 1, 0)
	btm.Size = UDim2.new(1, 0, .2, 0)
	btm.ZIndex = 2
	
	local Hider = Instance.new("Frame", alert)
	Hider.Name = "Hider"
	Hider.AnchorPoint = Vector2.new(0, 1)
	Hider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Hider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Hider.BorderSizePixel = 0
	Hider.Position = UDim2.new(0, 0, 0.899999976, 0)
	Hider.Size = UDim2.new(1, 0, 0.100000001, 0)
	Hider.ZIndex = 1
	
	local bc = Instance.new("UICorner", btm)
	bc.CornerRadius = UDim.new(0, 12)
	
	local close = Instance.new("TextButton", btm)
	close.Name = "CloseAlert"
	close.AnchorPoint = Vector2.new(1, 0.5)
	close.BackgroundColor3 = Color3.new(0.376471, 0.803922, 1)
	close.Position = UDim2.new(0.977, 0, 0.5, 0)
	close.Size = UDim2.new(0.2, 0, 0.6, 0)
	close.Text = ""
	close.ZIndex = 3
	
	local cc = Instance.new("UICorner", close)
	cc.CornerRadius = UDim.new(0, 4)
	
	local ct = Instance.new("TextLabel", close)
	ct.Name = "CloseAlertTextLabel"
	ct.AnchorPoint = Vector2.new(.5, .5)
	ct.BackgroundTransparency = 1
	ct.Position = UDim2.new(.5, 0, .5, 0)
	ct.Size = UDim2.new(.8, 0, .8, 0)
	ct.TextSize = 20
	ct.Text = "Close"
	ct.ZIndex = 4
	
	local cty = Instance.new("UITextSizeConstraint", ct)
	cty.MaxTextSize = 20
	
	return gui
end