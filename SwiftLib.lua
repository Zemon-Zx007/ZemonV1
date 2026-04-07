-- [[ Swift Hub X - Ultra Smooth Mobile UI ]]
-- [[ Redesigned by Pai for Zemon ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Xelora Hub"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Main Frame (ปรับให้โค้งมนและสวยแบบในรูป)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 580, 0, 400)
    MainFrame.BorderSizePixel = 0
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    -- Drag System (ระบบลากสำหรับมือถือ)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)

    -- Sidebar (แถบ Tab ด้านซ้าย)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Sidebar.Size = UDim2.new(0, 140, 1, -40)
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

    -- Content Holder (ที่เก็บหน้า Page)
    local ContentHolder = Instance.new("Frame")
    ContentHolder.Parent = MainFrame
    ContentHolder.Position = UDim2.new(0, 155, 0, 45)
    ContentHolder.Size = UDim2.new(1, -170, 1, -60)
    ContentHolder.BackgroundTransparency = 1

    local Tabs = {CurrentTab = nil}

    function Tabs:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 13
        
        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabButton

        -- Page Frame
        local Page = Instance.new("ScrollingFrame")
        Page.Name = TabName .. "Page"
        Page.Parent = ContentHolder
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.Padding = UDim.new(0, 10)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            Page.Visible = true
            
            -- เอฟเฟกต์สี Tab ที่เลือก
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end
            end
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        -- ฟังก์ชันสร้าง Section (ซ้าย/ขวา)
        local Elements = {}
        
        function Elements:CreateSection(SectionName)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Parent = Page
            SectionFrame.Size = UDim2.new(1, -10, 0, 30)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            
            local SecCorner = Instance.new("UICorner")
            SecCorner.CornerRadius = UDim.new(0, 8)
            SecCorner.Parent = SectionFrame
            
            local SecTitle = Instance.new("TextLabel")
            SecTitle.Parent = SectionFrame
            SecTitle.Text = "  " .. SectionName
            SecTitle.Size = UDim2.new(1, 0, 1, 0)
            SecTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SecTitle.Font = Enum.Font.GothamBold
            SecTitle.TextXAlignment = Enum.TextXAlignment.Left
            SecTitle.BackgroundTransparency = 1

            local ItemHolder = Instance.new("Frame")
            ItemHolder.Parent = Page
            ItemHolder.Size = UDim2.new(1, -10, 0, 0)
            ItemHolder.AutomaticSize = Enum.AutomaticSize.Y
            ItemHolder.BackgroundTransparency = 1
            
            local ItemList = Instance.new("UIListLayout")
            ItemList.Parent = ItemHolder
            ItemList.Padding = UDim.new(0, 5)

            local SubElements = {}

            -- Button
            function SubElements:CreateButton(Text, Callback)
                local B = Instance.new("TextButton")
                B.Parent = ItemHolder
                B.Size = UDim2.new(1, 0, 0, 35)
                B.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                B.Text = Text
                B.TextColor3 = Color3.fromRGB(255, 255, 255)
                B.Font = Enum.Font.GothamSemibold
                Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
                B.MouseButton1Click:Connect(pcall(Callback))
            end

            -- Toggle
            function SubElements:CreateToggle(Text, Default, Callback)
                local T = Instance.new("TextButton")
                T.Parent = ItemHolder
                T.Size = UDim2.new(1, 0, 0, 35)
                T.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                T.Text = "  " .. Text
                T.TextColor3 = Color3.fromRGB(200, 200, 200)
                T.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", T).CornerRadius = UDim.new(0, 6)

                local Indicator = Instance.new("Frame")
                Indicator.Parent = T
                Indicator.Position = UDim2.new(1, -40, 0.5, -10)
                Indicator.Size = UDim2.new(0, 30, 0, 20)
                Indicator.BackgroundColor3 = Default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
                Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

                local State = Default
                T.MouseButton1Click:Connect(function()
                    State = not State
                    TweenService:Create(Indicator, TweenInfo.new(0.3), {BackgroundColor3 = State and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)}):Play()
                    pcall(Callback, State)
                end)
            end

            return SubElements
        end
        return Elements
    end

    -- เริ่มต้นที่ Tab แรกเสมอ
    task.delay(0.1, function()
        local first = TabContainer:FindFirstChildOfClass("TextButton")
        if first then first.MouseButton1Click:Fire() end
    end)

    return Tabs
end

return Library
