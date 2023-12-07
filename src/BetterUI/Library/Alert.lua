--[=[
	@class AlertLibrary
	### A library to create alerts to player
]=]
	--[=[
		Creates an alert to a single player.
		@function new
		@within AlertLibrary
		@param player Player -- Player to be sent
		@param title string -- Title of the alert
		@param description string -- Description of the alert
		@param close string -- The close button text<br/><code>Defualt: "Close"</code>
		@param lightTheme boolean -- Whether it should be light theme or no <br/><code>Defualt: false</code>
	]=]
return {
	["new"] = function(player: Player, title: string, description: string, close: string, lightTheme: boolean)
		if not player then return error("Alert.new(): player must be provided.") end
		if not title then return error("Alert.new(): title must be provided.") end
		if not description then return error("Alert.new(): description must be provided.") end
		close = close or "Close"
		
		local guis = player:FindFirstChildWhichIsA("PlayerGui")
		local gui = guis:FindFirstChild("BetterUIInterface")
		local blur: Frame = gui:FindFirstChild("BlurAlertFrame")
		local alert = gui:FindFirstChild("AlertFrame")
		local alertTitle = alert:FindFirstChild("Title")
		local alertDesc = alert:FindFirstChild("Description")
		local alertCloseText = alert:FindFirstChild("Bottom"):FindFirstChild("CloseAlert")
		local alertCloseText2 = alertCloseText:FindFirstChild("CloseAlertTextLabel")
		local bottom = alert:FindFirstChild("Bottom")
		local hh = alert:FindFirstChild("Hider")
		if alertTitle.Text ~= "" then
			repeat task.wait() until alertTitle.Text == "" -- Alert Debounce
		end
		
		alertTitle.Text = title
		alertDesc.Text = description
		alertCloseText2.Text = close
		alertCloseText2.TextScaled = true
		alertCloseText.BackgroundColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(0.376471, 0.803922, 1) or Color3.new(0, 0.470588, 0.843137)
		alertCloseText2.TextColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
		alertTitle.TextColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
		alertDesc.TextColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
		alert.BackgroundColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
		bottom.BackgroundColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(0.156863, 0.156863, 0.156863) or Color3.fromRGB(243, 243, 243)
		hh.BackgroundColor3 = (lightTheme == false or lightTheme == nil) and Color3.new(0.156863, 0.156863, 0.156863) or Color3.fromRGB(243, 243, 243)
		
		local ts = game:GetService("TweenService")
		local tw = TweenInfo.new
		
		blur.BackgroundTransparency = 1
		blur.Visible = true
		
		ts:Create(blur, tw(.5), {
			BackgroundTransparency = 0.4
		}):Play()
		
		wait(.25)
		
		alert.Size = UDim2.new(0.35, 0, 0.45, 0)
		alert.BackgroundTransparency = 1
		for i, v in pairs(alert:GetDescendants()) do
			if v:IsA("Frame") then
				v.BackgroundTransparency = 1
			elseif v:IsA("TextButton") then
				v.BackgroundTransparency = 1
			elseif v:IsA("TextLabel") then
				v.TextTransparency = 1			
			end
		end
		alert.Visible = true
		for i, v in pairs(alert:GetDescendants()) do
			if v:IsA("Frame") then
				ts:Create(v, tw(.25), {
					BackgroundTransparency = 0
				}):Play()
			elseif v:IsA("TextButton") then
				ts:Create(v, tw(.25), {
					BackgroundTransparency = 0
				}):Play()
			elseif v:IsA("TextLabel") then
				ts:Create(v, tw(.25), {
					TextTransparency = 0
				}):Play()	
			end
		end
		ts:Create(alert, tw(.25), {
			Size = UDim2.new(0.32, 0, 0.42, 0);
			BackgroundTransparency = 0;
		}):Play()
		
		local acte = nil
		acte = alertCloseText.MouseButton1Click:Connect(function()
			acte:Disconnect()
			ts:Create(alert, tw(.25), {
				Size = UDim2.new(0.35, 0, 0.45, 0);
				BackgroundTransparency = 1;
			}):Play()
			for i, v in pairs(alert:GetDescendants()) do
				if v:IsA("Frame") then
					ts:Create(v, tw(.25), {
						BackgroundTransparency = 1
					}):Play()
				elseif v:IsA("TextButton") then
					ts:Create(v, tw(.25), {
						BackgroundTransparency = 1
					}):Play()
				elseif v:IsA("TextLabel") then
					ts:Create(v, tw(.25), {
						TextTransparency = 1
					}):Play()
				end
			end
			wait(.25 / 2)
			ts:Create(blur, tw(.5), {
				BackgroundTransparency = 1
			}):Play()
			wait(.5)
			blur.Visible = false
			blur.BackgroundTransparency = 0
			alert.Visible = false
			alert.Size = UDim2.new(0.3, 0, 0.4, 0)
			alert.BackgroundTransparency = 0
			for i, v in pairs(alert:GetDescendants()) do
				if v:IsA("Frame") then
					ts:Create(v, tw(.25), {
						BackgroundTransparency = 0
					}):Play()
				elseif v:IsA("TextButton") then
					ts:Create(v, tw(.25), {
						BackgroundTransparency = 0
					}):Play()
				elseif v:IsA("TextLabel") then
					ts:Create(v, tw(.25), {
						TextTransparency = 0
					}):Play()	
				end
			end
			alertTitle.Text = ""
			alertDesc.Text = ""
			alertCloseText2.Text = ""
		end)
	end,
}