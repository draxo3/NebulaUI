local library = {}

function library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 800, 0, 600) -- Doubled size
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TopBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(128, 0, 128) -- Purple color
    Title.TextScaled = true
    Title.Parent = TopBar
    
    local function dragify(frame)
        local dragging, dragInput, startPos, dragStart
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
    dragify(MainFrame)

    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(1, 0, 0, 40)
    SideBar.Position = UDim2.new(0, 0, 0, 40) -- Tabs under title
    SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SideBar.Parent = MainFrame
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -80)
    ContentFrame.Position = UDim2.new(0, 0, 0, 80)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentFrame.Parent = MainFrame
    
    local function createTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Parent = SideBar
        
        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Parent = ContentFrame
        TabFrame.Visible = false
        
        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentFrame:GetChildren()) do v.Visible = false end
            TabFrame.Visible = true
        end)
        return TabFrame
    end
    
    local function createSection(parent, title)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Size = UDim2.new(1, -20, 0, 60)
        SectionFrame.Position = UDim2.new(0, 10, 0, 10)
        SectionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        SectionFrame.Parent = parent
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Size = UDim2.new(1, 0, 0, 20)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Text = title
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.Parent = SectionFrame
        
        return SectionFrame
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
    
    return {
        CreateTab = createTab,
        CreateSection = createSection,
        CreateButton = createButton,
    }
end

return library
