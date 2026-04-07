-- [[ Swift Hub X Custom UI Library for Mobile ]]
-- [[ Size: 480 x 380 ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubMobileUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -190)
    MainFrame.Size = UDim2.new(0, 480, 0, 380) -- ขนาดตามที่ซีม่อนขอค้าบ
    MainFrame.ClipsDescendants = true

    -- Corner for MainFrame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Header / Title
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BorderSizePixel = 0

    local HeaderText = Instance.new("TextLabel")
    HeaderText.Parent = Header
    HeaderText.Text = Title
    HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderText.Font = Enum.Font.GothamBold
    HeaderText.TextSize = 18
    HeaderText.Position = UDim2.new(0, 15, 0, 0)
    HeaderText.Size = UDim2.new(0, 200, 1, 0)
    HeaderText.TextXAlignment = Enum.TextXAlignment.Left
    HeaderText.BackgroundTransparency = 1

    -- Tab Container (Left Side)
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = MainFrame
    TabContainer.Position = UDim2.new(0, 5, 0, 45)
    TabContainer.Size = UDim2.new(0, 100, 1, -50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.Padding = UDim.new(0, 5)

    -- Content Holder (Right Side)
    local ContentHolder = Instance.new("Frame")
    ContentHolder.Parent = MainFrame
    ContentHolder.Position = UDim2.new(0, 110, 0, 45)
    ContentHolder.Size = UDim2.new(1, -115, 1, -50)
    ContentHolder.BackgroundTransparency = 1

    local PageLayout = Instance.new("UIPageLayout")
    PageLayout.Parent = ContentHolder
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.EasingStyle = Enum.EasingStyle.Quart
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.TweenTime = 0.5

    local Tabs = {}

    function Tabs:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = ContentHolder
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 2
        Page.CanvasSize = UDim2.new(0, 0, 2, 0)
        
        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.Padding = UDim.new(0, 8)
        PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center

        TabButton.MouseButton1Click:Connect(function()
            PageLayout:JumpTo(Page)
        end)

        local Elements = {}

        -- Button Element
        function Elements:CreateButton(Text, Callback)
            local Btn = Instance.new("TextButton")
            Btn.Parent = Page
            Btn.Size = UDim2.new(0.9, 0, 0, 35)
            Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Btn.Text = Text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Font = Enum.Font.GothamSemibold
            Btn.TextSize = 14
            
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
            Btn.MouseButton1Click:Connect(function()
                pcall(Callback)
            end)
        end

        -- Toggle Element
        function Elements:CreateToggle(Text, Default, Callback)
            local TglFrame = Instance.new("TextButton")
            TglFrame.Parent = Page
            TglFrame.Size = UDim2.new(0.9, 0, 0, 35)
            TglFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TglFrame.Text = "  " .. Text
            TglFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            TglFrame.Font = Enum.Font.Gotham
            TglFrame.TextSize = 14
            TglFrame.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", TglFrame).CornerRadius = UDim.new(0, 6)

            local StatusLabel = Instance.new("TextLabel")
            StatusLabel.Parent = TglFrame
            StatusLabel.Position = UDim2.new(1, -50, 0, 0)
            StatusLabel.Size = UDim2.new(0, 40, 1, 0)
            StatusLabel.BackgroundTransparency = 1
            StatusLabel.Text = Default and "ON" or "OFF"
            StatusLabel.TextColor3 = Default and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
            StatusLabel.Font = Enum.Font.GothamBold

            local Toggled = Default
            TglFrame.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                StatusLabel.Text = Toggled and "ON" or "OFF"
                StatusLabel.TextColor3 = Toggled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
                pcall(Callback, Toggled)
            end)
        end

        -- Slider Element
        function Elements:CreateSlider(Text, Min, Max, Default, Callback)
            local SldFrame = Instance.new("Frame")
            SldFrame.Parent = Page
            SldFrame.Size = UDim2.new(0.9, 0, 0, 45)
            SldFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", SldFrame).CornerRadius = UDim.new(0, 6)

            local SldText = Instance.new("TextLabel")
            SldText.Parent = SldFrame
            SldText.Text = "  " .. Text .. ": " .. Default
            SldText.Size = UDim2.new(1, 0, 0, 20)
            SldText.BackgroundTransparency = 1
            SldText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SldText.Font = Enum.Font.Gotham
            SldText.TextXAlignment = Enum.TextXAlignment.Left

            local Bar = Instance.new("Frame")
            Bar.Parent = SldFrame
            Bar.Position = UDim2.new(0.1, 0, 0.7, 0)
            Bar.Size = UDim2.new(0.8, 0, 0, 5)
            Bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

            local Fill = Instance.new("Frame")
            Fill.Parent = Bar
            Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            
            -- Simple Mobile Slider Logic (Touch/Click)
            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local moveConn
                    moveConn = UserInputService.InputChanged:Connect(function(move)
                        if move.UserInputType == Enum.UserInputType.MouseMovement or move.UserInputType == Enum.UserInputType.Touch then
                            local pos = math.clamp((move.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                            Fill.Size = UDim2.new(pos, 0, 1, 0)
                            local val = math.floor(Min + (Max - Min) * pos)
                            SldText.Text = "  " .. Text .. ": " .. val
                            pcall(Callback, val)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(ended)
                        if ended.UserInputType == Enum.UserInputType.MouseButton1 or ended.UserInputType == Enum.UserInputType.Touch then
                            moveConn:Disconnect()
                        end
                    end)
                end
            end)
        end

        return Elements
    end
    return Tabs
end

return Library
