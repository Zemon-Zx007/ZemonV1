-- [[ Swift Hub X - RAINBOW & BORDER EDITION ]]
-- [[ Redesigned by Pai | Special for Zemon ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX_Rainbow"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.BorderSizePixel = 0
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

    -- [[ เพิ่มขอบเส้นใหญ่ๆ ชัดๆ ]]
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3.5 -- เส้นใหญ่เห็นชัดตามสั่งเลยค้าบ
    MainStroke.Color = Color3.fromRGB(255, 255, 255)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- [[ Floating Button ]]
    local ToggleBtn = Instance.new("TextButton", ScreenGui)
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
    ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ToggleBtn.Text = "S"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 24
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local BtnStroke = Instance.new("UIStroke", ToggleBtn)
    BtnStroke.Thickness = 2.5
    BtnStroke.Color = Color3.fromRGB(255, 255, 255)

    -- Header & Eye Icon
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1

    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.Text = "   " .. Title
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1

    local EyeBtn = Instance.new("TextButton", Header)
    EyeBtn.Text = "👁️"
    EyeBtn.Size = UDim2.new(0, 35, 0, 35)
    EyeBtn.Position = UDim2.new(1, -40, 0, 3)
    EyeBtn.BackgroundTransparency = 1
    EyeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    EyeBtn.TextSize = 20

    -- Drag System
    local function MakeDraggable(frame)
        local dragging, dragInput, dragStart, startPos
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = frame.Position
                input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
            end
        end)
        frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
    MakeDraggable(MainFrame); MakeDraggable(ToggleBtn)

    ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    -- Transparency System
    local isTransparent = false
    EyeBtn.MouseButton1Click:Connect(function()
        isTransparent = not isTransparent
        local targetT = isTransparent and 0.5 or 0
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = targetT}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundTransparency = targetT}):Play()
    end)

    local WindowAPI = {}
    local RainbowConnection = nil

    -- [[ SetColor System ]]
    function WindowAPI:SetColor(NewColor)
        if RainbowConnection then RainbowConnection:Disconnect(); RainbowConnection = nil end -- ปิดเรนโบว์ถ้าเลือกสีปกติ
        
        local TI = TweenInfo.new(0.5, Enum.EasingStyle.Quart)
        TweenService:Create(MainFrame, TI, {BackgroundColor3 = NewColor}):Play()
        TweenService:Create(MainStroke, TI, {Color = NewColor}):Play() -- ขอบเปลี่ยนตามสี UI
        TweenService:Create(ToggleBtn, TI, {BackgroundColor3 = NewColor}):Play()
        TweenService:Create(BtnStroke, TI, {Color = NewColor}):Play()
    end

    -- [[ Rainbow Mode System ]]
    function WindowAPI:SetRainbow()
        if RainbowConnection then RainbowConnection:Disconnect() end
        
        RainbowConnection = RunService.RenderStepped:Connect(function()
            local Hue = tick() % 5 / 5 -- วนลูปสี
            local Color = Color3.fromHSV(Hue, 0.8, 1)
            
            -- อัปเดตสีแบบทันที
            MainFrame.BackgroundColor3 = Color
            MainStroke.Color = Color
            ToggleBtn.BackgroundColor3 = Color
            BtnStroke.Color = Color
        end)
    end

    -- Tab System
    local TabContainer = Instance.new("ScrollingFrame", MainFrame)
    TabContainer.Size = UDim2.new(0, 110, 1, -80); TabContainer.Position = UDim2.new(0, 12, 0, 50)
    TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)

    local ContentHolder = Instance.new("Frame", MainFrame)
    ContentHolder.Position = UDim2.new(0, 130, 0, 50); ContentHolder.Size = UDim2.new(1, -142, 1, -65)
    ContentHolder.BackgroundTransparency = 1

    local firstTab = true
    function WindowAPI:CreateTab(TabName)
        local TabBtn = Instance.new("TextButton", TabContainer)
        TabBtn.Size = UDim2.new(1, 0, 0, 32); TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = TabName; TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150); TabBtn.Font = Enum.Font.Gotham
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

        local Page = Instance.new("ScrollingFrame", ContentHolder)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = firstTab
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)

        if firstTab then TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255); firstTab = false end

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, btn in pairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end end
            Page.Visible = true; TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local Elements = {}
        function Elements:CreateSection(Name)
            local Holder = Instance.new("Frame", Page)
            Holder.Size = UDim2.new(1, 0, 0, 0); Holder.AutomaticSize = Enum.AutomaticSize.Y; Holder.BackgroundTransparency = 1
            Instance.new("UIListLayout", Holder).Padding = UDim.new(0, 6)

            local Sub = {}
            function Sub:CreateButton(Txt, Call)
                local B = Instance.new("TextButton", Holder)
                B.Size = UDim2.new(1, 0, 0, 35); B.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                B.Text = Txt; B.TextColor3 = Color3.fromRGB(255, 255, 255); B.Font = Enum.Font.GothamSemibold
                Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
                B.MouseButton1Click:Connect(function() if Call then Call() end end)
            end

            function Sub:CreateDropdown(Txt, List, Call)
                local D = Instance.new("TextButton", Holder)
                D.Size = UDim2.new(1, 0, 0, 35); D.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                D.Text = "  " .. Txt .. ": None"; D.TextColor3 = Color3.fromRGB(200, 200, 200)
                D.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", D).CornerRadius = UDim.new(0, 8)

                local DF = Instance.new("Frame", Holder)
                DF.Size = UDim2.new(1, 0, 0, 0); DF.Visible = false; DF.ClipsDescendants = true
                DF.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UIListLayout", DF)
                Instance.new("UICorner", DF).CornerRadius = UDim.new(0, 8)

                D.MouseButton1Click:Connect(function()
                    DF.Visible = not DF.Visible; DF.Size = DF.Visible and UDim2.new(1, 0, 0, #List * 30) or UDim2.new(1, 0, 0, 0)
                end)

                for _, v in pairs(List) do
                    local O = Instance.new("TextButton", DF)
                    O.Size = UDim2.new(1, 0, 0, 30); O.BackgroundTransparency = 1; O.Text = v
                    O.TextColor3 = Color3.fromRGB(180, 180, 180); O.Font = Enum.Font.Gotham
                    O.MouseButton1Click:Connect(function()
                        D.Text = "  " .. Txt .. ": " .. v; DF.Visible = false; DF.Size = UDim2.new(1, 0, 0, 0); Call(v)
                    end)
                end
            end
            return Sub
        end
        return Elements
    end
    return WindowAPI
end

return Library
