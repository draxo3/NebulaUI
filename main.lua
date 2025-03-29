local library = {}

function library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 800, 0, 600)  -- Increased the size
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 200, 1, 0)  -- Increased the size of the sidebar
    SideBar.Position = UDim2.new(0, 0, 0, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SideBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)  -- Increased height for the title
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(204, 0, 255)  -- Purple color for the title
    Title.TextScaled = true
    Title.TextSize = 24  -- Made the text smaller
    Title.Parent = SideBar

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -200, 1, 0)  -- Adjusted based on sidebar size
    ContentFrame.Position = UDim2.new(0, 200, 0, 0)  -- Adjusted based on sidebar size
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentFrame.Parent = MainFrame

    local function createTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundTransparency = 1
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Parent = SideBar

        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Parent = ContentFrame
        TabFrame.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentFrame:GetChildren()) do
                v.Visible = false
            end
            TabFrame.Visible = true
        end)

        return TabFrame
    end

    local function createButton(parent, text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -20, 0, 30)
        Button.Position = UDim2.new(0, 10, 0, 10)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Parent = parent

        Button.MouseButton1Click:Connect(callback)
    end

    local function createToggle(parent, text, callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, -20, 0, 30)
        Toggle.Position = UDim2.new(0, 10, 0, 50)
        Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Toggle.Text = text .. ": OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Parent = parent

        local toggled = false
        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            Toggle.Text = text .. ": " .. (toggled and "ON" or "OFF")
            callback(toggled)
        end)
    end

    local function createSlider(parent, text, min, max, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1, -20, 0, 30)
        SliderFrame.Position = UDim2.new(0, 10, 0, 90)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        SliderFrame.Parent = parent

        local SliderText = Instance.new("TextLabel")
        SliderText.Size = UDim2.new(1, 0, 1, 0)
        SliderText.Text = text .. ": " .. min
        SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderText.BackgroundTransparency = 1
        SliderText.Parent = SliderFrame

        local SliderButton = Instance.new("TextButton")
        SliderButton.Size = UDim2.new(0.2, 0, 1, 0)
        SliderButton.Position = UDim2.new(0, 0, 0, 0)
        SliderButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        SliderButton.Parent = SliderFrame

        local dragging = false
        SliderButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        SliderButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relX = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                SliderButton.Position = UDim2.new(relX, 0, 0, 0)
                local value = math.floor(min + (max - min) * relX)
                SliderText.Text = text .. ": " .. value
                callback(value)
            end
        end)
    end

    return {
        CreateTab = createTab,
        CreateButton = createButton,
        CreateToggle = createToggle,
        CreateSlider = createSlider,
    }
end

return library
