-- [[ Swift Hub X - FIXED COLOR SYSTEM ]]
-- [[ Size: 420 x 340 | Redesigned by Pai for Zemon ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX_ColorFixed"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.BorderSizePixel = 0
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

    -- [[ Floating Button ]]
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBtn.Text = "S"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 20
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    -- Drag System
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

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Sidebar & Content
    local TabContainer = Instance.new("ScrollingFrame", MainFrame)
    TabContainer.Size = UDim2.new(0, 120, 1, -40)
    TabContainer.Position = UDim2.new(0, 10, 0, 30)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

    local ContentHolder = Instance.new("Frame", MainFrame)
    ContentHolder.Position = UDim2.new(0, 135, 0, 45)
    ContentHolder.Size = UDim2.new(1, -145, 1, -55)
    ContentHolder.BackgroundTransparency = 1

    -- สร้าง Table เก็บฟังก์ชันที่จะส่งคืน
    local Tabs = {}
    
    -- *** แก้ไขจุดนี้: ย้าย SetColor เข้ามาอยู่ใน table Tabs ที่เราจะส่งออกไป ***
    function Tabs:SetColor(NewColor)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundColor3 = NewColor}):Play()
    end

    local firstTab = true
    function Tabs:CreateTab(TabName)
        local TabButton = Instance.new("TextButton", TabContainer)
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabButton.Font = Enum.Font.Gotham
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame", ContentHolder)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = firstTab
        Page.ScrollBarThickness = 1
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)

        if firstTab then TabButton.TextColor3 = Color3.fromRGB(255, 255, 255) firstTab = false end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, btn in pairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end end
            Page.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local Elements = {}
        function Elements:CreateSection(SectionName)
            local SecFrame = Instance.new("Frame", Page)
            SecFrame.Size = UDim2.new(1, -5, 0, 25)
            SecFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Instance.new("UICorner", SecFrame).CornerRadius = UDim.new(0, 6)
            
            local SecTitle = Instance.new("TextLabel", SecFrame)
            SecTitle.Text = "  " .. SectionName
            SecTitle.Size = UDim2.new(1, 0, 1, 0)
            SecTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SecTitle.Font = Enum.Font.GothamBold
            SecTitle.TextSize = 11
            SecTitle.BackgroundTransparency = 1
            SecTitle.TextXAlignment = Enum.TextXAlignment.Left

            local ItemHolder = Instance.new("Frame", Page)
            ItemHolder.Size = UDim2.new(1, -5, 0, 0)
            ItemHolder.AutomaticSize = Enum.AutomaticSize.Y
            ItemHolder.BackgroundTransparency = 1
            Instance.new("UIListLayout", ItemHolder).Padding = UDim.new(0, 5)

            local Sub = {}
            function Sub:CreateButton(Text, Callback)
                local B = Instance.new("TextButton", ItemHolder)
                B.Size = UDim2.new(1, 0, 0, 30)
                B.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                B.Text = Text
                B.TextColor3 = Color3.fromRGB(255, 255, 255)
                B.Font = Enum.Font.GothamSemibold
                Instance.new("UICorner", B).CornerRadius = UDim.new(0, 5)
                B.MouseButton1Click:Connect(function() if Callback then Callback() end end)
            end

            function Sub:CreateDropdown(Text, List, Callback)
                local D = Instance.new("TextButton", ItemHolder)
                D.Size = UDim2.new(1, 0, 0, 30)
                D.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                D.Text = "  " .. Text .. ": None"
                D.TextColor3 = Color3.fromRGB(200, 200, 200)
                D.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", D).CornerRadius = UDim.new(0, 5)

                local DropFrame = Instance.new("Frame", ItemHolder)
                DropFrame.Size = UDim2.new(1, 0, 0, 0)
                DropFrame.Visible = false
                DropFrame.ClipsDescendants = true
                DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Instance.new("UIListLayout", DropFrame)
                Instance.new("UICorner", DropFrame)

                D.MouseButton1Click:Connect(function()
                    DropFrame.Visible = not DropFrame.Visible
                    DropFrame.Size = DropFrame.Visible and UDim2.new(1, 0, 0, #List * 25) or UDim2.new(1, 0, 0, 0)
                end)

                for _, val in pairs(List) do
                    local Opt = Instance.new("TextButton", DropFrame)
                    Opt.Size = UDim2.new(1, 0, 0, 25)
                    Opt.BackgroundTransparency = 1
                    Opt.Text = val
                    Opt.TextColor3 = Color3.fromRGB(180, 180, 180)
                    Opt.Font = Enum.Font.Gotham
                    Opt.MouseButton1Click:Connect(function()
                        D.Text = "  " .. Text .. ": " .. val
                        DropFrame.Visible = false
                        DropFrame.Size = UDim2.new(1, 0, 0, 0)
                        if Callback then Callback(val) end
                    end)
                end
            end
            return Sub
        end
        return Elements
    end
    return Tabs
end

return Library
