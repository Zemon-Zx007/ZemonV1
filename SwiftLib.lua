-- [[ Swift Hub X - Mobile UI v2 ]]
-- [[ Size: 420 x 340 | With Floating Button ]]
-- [[ Redesigned by Pai for Zemon ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Xelora Hub"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX_V2"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Main Frame (ปรับขนาดเป็น 420 x 340)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    -- [[ Floating Button (ปุ่มลอยสำหรับ เปิด/ปิด) ]]
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = "FloatingButton"
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBtn.Text = "S" -- อักษรย่อ Swift Hub
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 20
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0) -- วงกลม
    BtnCorner.Parent = ToggleBtn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(0, 150, 255)
    BtnStroke.Thickness = 2
    BtnStroke.Parent = ToggleBtn

    -- ระบบลากปุ่มลอย และ ลากหน้าต่างหลัก (Drag System)
    local function MakeDraggable(frame)
        local dragging, dragInput, dragStart, startPos
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
    
    MakeDraggable(MainFrame)
    MakeDraggable(ToggleBtn)

    -- ฟังชั่น เปิด/ปิด UI
    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Sidebar (Tabs ฝั่งซ้าย)
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Sidebar.Size = UDim2.new(0, 120, 1, -40)
    Sidebar.Position = UDim2.new(0, 10, 0, 30)
    Sidebar.BackgroundTransparency = 1

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.Padding = UDim.new(0, 5)

    -- Content Holder (ฝั่งขวา)
    local ContentHolder = Instance.new("Frame")
    ContentHolder.Parent = MainFrame
    ContentHolder.Position = UDim2.new(0, 135, 0, 45)
    ContentHolder.Size = UDim2.new(1, -145, 1, -55)
    ContentHolder.BackgroundTransparency = 1

    local Tabs = {}

    function Tabs:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 12
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = ContentHolder
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 1
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.Padding = UDim.new(0, 8)
        
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end
            end
            Page.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local Elements = {}
        function Elements:CreateSection(SectionName)
            local SecFrame = Instance.new("Frame")
            SecFrame.Parent = Page
            SecFrame.Size = UDim2.new(1, -5, 0, 25)
            SecFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Instance.new("UICorner", SecFrame).CornerRadius = UDim.new(0, 6)
            
            local SecTitle = Instance.new("TextLabel")
            SecTitle.Parent = SecFrame
            SecTitle.Text = "  " .. SectionName
            SecTitle.Size = UDim2.new(1, 0, 1, 0)
            SecTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SecTitle.Font = Enum.Font.GothamBold
            SecTitle.TextSize = 12
            SecTitle.TextXAlignment = Enum.TextXAlignment.Left
            SecTitle.BackgroundTransparency = 1

            local ItemHolder = Instance.new("Frame")
            ItemHolder.Parent = Page
            ItemHolder.Size = UDim2.new(1, -5, 0, 0)
            ItemHolder.AutomaticSize = Enum.AutomaticSize.Y
            ItemHolder.BackgroundTransparency = 1
            Instance.new("UIListLayout", ItemHolder).Padding = UDim.new(0, 5)

            local Sub = {}
            function Sub:CreateButton(Text, Callback)
                local B = Instance.new("TextButton")
                B.Parent = ItemHolder
                B.Size = UDim2.new(1, 0, 0, 30)
                B.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                B.Text = Text
                B.TextColor3 = Color3.fromRGB(255, 255, 255)
                B.Font = Enum.Font.GothamSemibold
                Instance.new("UICorner", B).CornerRadius = UDim.new(0, 5)
                B.MouseButton1Click:Connect(pcall(Callback))
            end

            function Sub:CreateToggle(Text, Default, Callback)
                local T = Instance.new("TextButton")
                T.Parent = ItemHolder
                T.Size = UDim2.new(1, 0, 0, 30)
                T.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                T.Text = "  " .. Text
                T.TextColor3 = Color3.fromRGB(200, 200, 200)
                T.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", T).CornerRadius = UDim.new(0, 5)

                local Ind = Instance.new("Frame")
                Ind.Parent = T
                Ind.Position = UDim2.new(1, -35, 0.5, -8)
                Ind.Size = UDim2.new(0, 25, 0, 16)
                Ind.BackgroundColor3 = Default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
                Instance.new("UICorner", Ind).CornerRadius = UDim.new(1, 0)

                local State = Default
                T.MouseButton1Click:Connect(function()
                    State = not State
                    TweenService:Create(Ind, TweenInfo.new(0.2), {BackgroundColor3 = State and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)}):Play()
                    pcall(Callback, State)
                end)
            end
            return Sub
        end
        return Elements
    end

    task.delay(0.2, function()
        local first = TabContainer:FindFirstChildOfClass("TextButton")
        if first then first.MouseButton1Click:Fire() end
    end)

    return Tabs
end

return Library
