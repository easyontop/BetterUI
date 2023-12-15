--[=[
    @class ProgressLibrary
    A library to create progress bar
]=]
--[=[
    @function new
    @within ProgressLibrary
    Creates a new progress bar
    @param options ProgressCreationOptions
    @return ProgressReturnLibrary
]=]

--- @interface ProgressCreationOptions
--- @within ProgressLibrary
--- The options to create a progress bar
--- .parent Instance -- the parent to set to the progress bar
--- .progress number -- The progress as default (Max: 100)

return {
    ["new"] = function(options)
        --[=[
            @class ProgressReturnLibrary
            _L returned from [ProgressLibrary](/api/ProgressLibrary)
        ]=]
            --[=[
                @prop Object Instance | nil
                @within ProgressReturnLibrary
                The object (pg bar) 
            ]=]
        local ProgressReturnLibrary = {
            ["Object"] = nil
        }

        --[=[
            @method setParent
            @within ProgressReturnLibrary
            Sets the parent of the switch (create)
            @return Frame
            @param t ScreenGui|BillboardGui|Frame|TextLabel|ImageLabel|TextBox|ImageButton|TextButton|CanvasGroup -- Parent of the pg bar
        ]=]

        function ProgressReturnLibrary:setParent(t: Instance)
            local x = Instance.new"Frame"
            x.Name = "PgBar_"
            x.Parent = t
            x.Size = UDim2.new(.9,0,.05,0)
            x.Position = UDim2.new(0, 0, .5, 0)
            local y = Instance.new"Frame"
            y.Name = "I_"
            y.Parent = x 
            y.Size = UDim2.new(0, 1)
            ProgressReturnLibrary.Object = x
            return x
        end

        if options.parent then
            ProgressReturnLibrary:setParent(options.parent)
        end

        --[=[
            @method setBackground 
            @within ProgressReturnLibrary
            Sets the background color of the progress bar
            @param y Color3 -- The color of the background
            @return boolean
        ]=]
        function ProgressReturnLibrary:setBackground(y: Color3)
            ProgressReturnLibrary.Object.BackgroundColor3 = y 
            return true
        end
--[=[
            @method setCorner 
            @within ProgressReturnLibrary
            Sets the corner radius of the progress bar
            @param y UDim -- The corner of the background
            @return boolean
        ]=]
        function ProgressReturnLibrary:setCorner(y: UDim)
            local EDIT = ProgressReturnLibrary.Object:FindFirstChild"UICorner" or Instance.new("UICorner", ProgressReturnLibrary.Object)
            EDIT.CornerRadius = y
            local _D = ProgressReturnLibrary.Object.I_:FindFirstChild"UICorner" or Instance.new("UICorner", ProgressReturnLibrary.Object.I_)
            _D.CornerRadius = y
            return true
        end

        --[=[
            @method setStroke
            @within ProgressReturnLibrary
            Sets the stroke of the pg bar
            @param x Color3 -- The color of the stroke
            @param y number -- The thickness of the stroke
            @return boolean
        ]=]
        function ProgressReturnLibrary:setStroke(x: Color3, y: number)
            local e = ProgressReturnLibrary.Object:FindFirstChild"UIStroke" or Instance.new("UIStroke", ProgressReturnLibrary.Object)
            e.Thickness = y
            e.Color = x 
            return true
        end

        --[=[
            @method setProgress
            @within ProgressReturnLibrary
            Sets the progress of the pg bar
            @param x number -- Sets the progress of the pg bar. Min: 0, Max: 100
            @return boolean
        ]=]
        function ProgressReturnLibrary:setProgress(x: number)
            if x < 0 then return error("Failed to set progress, it can not be negative") end
            if x > 100 then return error("Failed to set progress, it can not be larger than 100") end
            ProgressReturnLibrary.Object.I_.Size = UDim2.new(x / 100, 0, 1, 0)
            return true
        end

        if options.progress then
            ProgressReturnLibrary:setProgress(options.progress)
        end

        --[=[
            @method setPgColor
            @return boolean
            @within ProgressReturnLibrary
            Sets the progress color
            @param x Color3 -- The color of the progress
        ]=]
        function ProgressReturnLibrary:setPgColor(x: Color3)
            ProgressReturnLibrary.Object.I_.BackgroundColor3 = x
            return true
        end

        --[=[
            @method setAnchorPoint
            @return boolean
            @within ProgressReturnLibrary
            Sets the anchor point of the pg bar
            @param x Vector2 -- AnchorPoint
        ]=]
        function ProgressReturnLibrary:setAnchorPoint(x: Vector2)
            ProgressReturnLibrary.Object.AnchorPoint = x
            return true
        end

        --[=[
            @method setPosition
            @return boolean
            @within ProgressReturnLibrary
            Sets the position of the pg bar
            @param x UDim2 -- Position
        ]=]
        function ProgressReturnLibrary:setPosition(x: UDim2)
            ProgressReturnLibrary.Object.Position = x
            return true
        end

        --[=[
            @method setSize
            @return boolean
            @within ProgressReturnLibrary
            Sets the size of the pg bar
            @param x UDim2 -- Size
        ]=]
        function ProgressReturnLibrary:setSize(x: UDim2)
            ProgressReturnLibrary.Object.Size = x
            return true
        end 

        return ProgressReturnLibrary
    end
}