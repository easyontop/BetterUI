--[=[
	@class SwitchLibrary
	A library to create switches
]=]

--[=[
	Creates a new switch
	@function new
	@within SwitchLibrary
	@return SwitchReturnLibrary
]=]

return {
	["new"] = function()
		local parent = nil
		local function validation()
			return parent ~= nil
		end	

		--[=[
			@class SwitchReturnLibrary
			A library stores the properties and functions of the switch
		]=]

		--[=[
			@prop Locked boolean
			@within SwitchReturnLibrary
			Whether or not the toggler should not be actived.
		]=]
		
		--[=[
			@prop Value boolean
			@within SwitchReturnLibrary
			Whether or not the toggler is toggled on.
		]=]

		local SwitchLibrary = {
			["Locked"] = false;
			["Value"] = false;
		}
		
		local disc = Color3.fromRGB(0, 0, 0)
		local enac = Color3.fromRGB(0, 0, 0)
		local tweenDebounce = false
		
		local lessMotion = false
		--[=[
			@method setParent
			@within SwitchReturnLibrary
			Sets the parent of the switch
			@param t ScreenGui|BillboardGui|Frame|TextLabel|ImageLabel|TextBox|ImageButton|TextButton|CanvasGroup -- The parent of the switch
		]=]
		function SwitchLibrary:setParent(t: Instance)
			if not t then return error("Missing Required Value: t -> Instance") end
			SwitchLibrary["Object"] = Instance.new("Frame")
			SwitchLibrary.Object.Parent = t
			SwitchLibrary.Object.Name = "Switch_"
			SwitchLibrary["Main"] = Instance.new("Frame")
			SwitchLibrary.Main.BackgroundTransparency = 1
			SwitchLibrary.Main.Name = "Inside"
			SwitchLibrary.Main.AnchorPoint = Vector2.new(.5, .5)
			SwitchLibrary.Main.Size = UDim2.new(.9, 0, 1, -50)
			SwitchLibrary.Main.Position = UDim2.new(.5, 0, .5, 0)
			SwitchLibrary.Main.Parent = SwitchLibrary.Object
			SwitchLibrary["Switch"] = Instance.new("TextButton")
			SwitchLibrary.Switch.Parent = SwitchLibrary.Main
			SwitchLibrary.Switch.Text = ""
			SwitchLibrary.Switch.Size = UDim2.new(.2, 0, 1, 0)
			SwitchLibrary.Switch.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			SwitchLibrary.Switch.AutoButtonColor = false
			SwitchLibrary.Switch.MouseButton1Click:Connect(function()
				if SwitchLibrary.Locked then return end
				if SwitchLibrary.Switch.Position == UDim2.new(0, 0, 0, 0) then
                    SwitchLibrary.Value = true
					if lessMotion then
						SwitchLibrary.Switch.BackgroundColor3 = enac
						SwitchLibrary.Switch.AnchorPoint = Vector2.new(1, 0)
						SwitchLibrary.Switch.Position = UDim2.new(1, 0, 0, 0)
					else
						if tweenDebounce then repeat task.wait() until tweenDebounce ~= true end
						tweenDebounce = true
						game:GetService("TweenService"):Create(SwitchLibrary.Switch, TweenInfo.new(.1, Enum.EasingStyle.Sine), {
							BackgroundColor3 = enac;
							AnchorPoint = Vector2.new(1, 0);
							Position = UDim2.new(1, 0, 0, 0)
						}):Play()
						wait(.1)
						tweenDebounce = false
					end
				else
                    SwitchLibrary.Value = false
					if lessMotion then
						SwitchLibrary.Switch.BackgroundColor3 = disc
						SwitchLibrary.Switch.AnchorPoint = Vector2.new(0, 0)
						SwitchLibrary.Switch.Position = UDim2.new(0, 0, 0, 0)
					else
						if tweenDebounce then repeat task.wait() until tweenDebounce ~= true end
						tweenDebounce = true
						game:GetService("TweenService"):Create(SwitchLibrary.Switch, TweenInfo.new(.1, Enum.EasingStyle.Sine), {
							BackgroundColor3 = disc;
							AnchorPoint = Vector2.new(0, 0);
							Position = UDim2.new(0, 0, 0, 0)
						}):Play()
						wait(.1)
						tweenDebounce = false
					end
				end
			end)
			parent = t
			return SwitchLibrary.Object
		end
		--[=[
			@method setLock
			@within SwitchReturnLibrary
			Set whether the switch should response when the user clicked
			@param t boolean -- Should it be locked? Default: true
		]=]
		function SwitchLibrary:setLock(t: boolean?)
			if t == nil then t = true end
			SwitchLibrary.Locked = t
			return SwitchLibrary.Object
		end
		--[=[
			@method setPosition
			@within SwitchReturnLibrary
			Sets the position of the switch
			@param y UDim2 -- The position of the switch
		]=]
		function SwitchLibrary:setPosition(y: UDim2)
			SwitchLibrary.Object.Position = y
			return SwitchLibrary.Object
		end
		--[=[
			@method setAnchorPoint
			@within SwitchReturnLibrary
			Sets the AnchorPoint property of the switch 
			@param y Vector2 -- The anchor point of the switch
		]=]
		function SwitchLibrary:setAnchorPoint(y: Vector2)
			SwitchLibrary.Object.AnchorPoint = y
			return SwitchLibrary.Object
		end
		--[=[
			@method setSize
			@within SwitchReturnLibrary
			Sets the Size of the switch
			@param y UDim2 -- Size of the switch
		]=]
		function SwitchLibrary:setSize(y: UDim2)
			SwitchLibrary.Object.Size = y 
			return SwitchLibrary.Object
		end
		--[=[
			@method setPadding
			@within SwitchReturnLibrary
			Sets the padding of the switch button
			@param x number Padding on x-asis (offset)
			@param y number Padding on y-axis (offset)
		]=]
		function SwitchLibrary:setPadding(x: number, y: number)
			SwitchLibrary.Main.Size = UDim2.new(1, -x, 1, -y)
			return SwitchLibrary.Object
		end
		--[=[
			@method setBgColor
			@within SwitchReturnLibrary
			Sets the background color of switch
			@param x Color3 -- Color of the background of the switch
		]=]
		function SwitchLibrary:setBgColor(x: Color3)
			SwitchLibrary.Object.BackgroundColor3 =  x
			return SwitchLibrary.Object
		end
		--[=[
			@method setCorner
			@within SwitchReturnLibrary
			Sets the CornerRadius property of the switch
			@param c UDim -- The corner udim property should be set to the switch
		]=]
		function SwitchLibrary:setCorner(c: UDim)
			local obj = SwitchLibrary.Object:FindFirstChildWhichIsA("UICorner") or Instance.new("UICorner", SwitchLibrary.Object)
			obj.CornerRadius = c 
			return SwitchLibrary.Object
		end
		--[=[
			@method setButtonColor
			@within SwitchReturnLibrary
			Sets the switch toggler color
			@param c Color3 Color of the toggler
		]=]
		function SwitchLibrary:setButtonColor(c: Color3)
			SwitchLibrary.Switch.BackgroundColor3 = c
			disc = c
			enac = c
			return SwitchLibrary.Object
		end
		--[=[
			@method noTween
			@within SwitchReturnLibrary
			Removes tween for switch toggler movement
		]=]
		function SwitchLibrary:noTween()
			lessMotion = true
			return SwitchLibrary.Object
		end
		--[=[
			@method tween
			@within SwitchReturnLibrary
			Adds tween for switch toggler movement
		]=]
		function SwitchLibrary:tween()
			lessMotion = false
			return SwitchLibrary.Object
		end
		--[=[
			@method setEnabledColor
			@within SwitchReturnLibrary
			Sets the switch toggler color when enabled
			@param c Color3 -- The color of the toggler when enabled
		]=]
		function SwitchLibrary:setEnableColor(c: Color3)
			enac = c
			if SwitchLibrary.Switch.Position == UDim2.new(1, 0, 0, 0) then
				SwitchLibrary.Switch.BackgroundColor3 = c
			end
			return SwitchLibrary.Object
		end
		--[=[
			@method setDisableColor
			@within SwitchReturnLibrary
			Sets the switch toggler color when disabled
			@param c Color3 -- The color of the toggler when disabled
		]=]
		function SwitchLibrary:setDisableColor(c: Color3)
			disc = c
			if SwitchLibrary.Switch.Position == UDim2.new(0, 0, 0, 0) then
				SwitchLibrary.Switch.BackgroundColor3 = c
			end
			return SwitchLibrary.Object
		end
		--[=[
			@method setButtonCorner
			@within SwitchReturnLibrary
			Sets the button corner (switch toggler)
			@param c UDim -- The button cornerRadius property
		]=]
		function SwitchLibrary:setButtonCorner(c: UDim)
			if SwitchLibrary.Switch:FindFirstChildWhichIsA("UICorner") then return false end
			local y = Instance.new("UICorner", SwitchLibrary.Switch)
			y.CornerRadius = c
			return SwitchLibrary.Object
		end
		--[=[
			@method setBorder
			@within SwitchReturnLibrary
			Sets the main border of the switch
			@param c UIStroke -- Provide UIStroke, if already exists, return false instead.
		]=]
		function SwitchLibrary:setBorder(c: UIStroke)
			if SwitchLibrary.Object:FindFirstChildWhichIsA("UIStroke") then return false end
			c.Parent = SwitchLibrary.Object
			return SwitchLibrary.Object
		end
		--[=[
			@method setButtonSize
			@within SwitchReturnLibrary
			@param x number -- The scale size of the toggler. Max: 0.5
			Sets the switch toggler size
		]=]
		function SwitchLibrary:setButtonSize(x: number)
			if x > .5 or x < 0 then
				return error("Button Size Larger Than 0.5 in scale will make it hard to understand") 
			end
			SwitchLibrary.Switch.Size = UDim2.new(x, 0, 1, 0)
		end
		
		return SwitchLibrary
	end,
}