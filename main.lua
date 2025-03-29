local library = {}

-- Loading Screen
local function showLoadingScreen()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 400, 0, 200)
    LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    LoadingFrame.Parent = ScreenGui
    
    local LoadingLabel = Instance.new("TextLabel")
    LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
    LoadingLabel.Text = "Loading UI..."
    LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingLabel.Parent = LoadingFrame
    
    -- Simple Animation
    for i = 1, 3 do
        LoadingLabel.Text = "Loading UI" .. string.rep(".", i)
        task.wait(0.5)
    end
    ScreenGui:Destroy()
end

showLoadingScreen()

function library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 800, 0, 600)
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TopBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(128, 0, 128)
    Title.TextSize = 20
    Title.Parent = TopBar

    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(1, 0, 0, 40)
    SideBar.Position = UDim2.new(0, 0, 0, 50)
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SideBar.Parent = MainFrame

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -90)
    ContentFrame.Position = UDim2.new(0, 0, 0, 90)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentFrame.Parent = MainFrame

    -- UI Toggle Key Selection
    local DefaultHideKey = Enum.KeyCode.RightControl
    local HideKeyTextbox = Instance.new("TextBox")
    HideKeyTextbox.Size = UDim2.new(0, 200, 0, 30)
    HideKeyTextbox.Position = UDim2.new(0, 10, 0, 10)
    HideKeyTextbox.Text = "RightControl"
    HideKeyTextbox.Parent = MainFrame
    
    HideKeyTextbox.FocusLost:Connect(function()
        local keyInput = HideKeyTextbox.Text:upper()
        for _, key in pairs(Enum.KeyCode:GetEnumItems()) do
            if key.Name == keyInput then
                DefaultHideKey = key
                break
            end
        end
    end)
    
    -- Hide UI Functionality
    local UIS = game:GetService("UserInputService")
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == DefaultHideKey then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
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
    
    return {
        CreateTab = function(name)
            local TabFrame = Instance.new("Frame")
            TabFrame.Size = UDim2.new(1, 0, 1, 0)
            TabFrame.BackgroundTransparency = 1
            TabFrame.Parent = ContentFrame
            TabFrame.Visible = false
            return TabFrame
        end,
        CreateButton = createButton,
        CreateToggle = createToggle,
    }
end

return library


