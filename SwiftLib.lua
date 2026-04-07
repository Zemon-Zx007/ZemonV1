-- [[ Swift Hub X - ANIMATED LANGUAGE EDITION ]]
-- [[ Border: 3.5 (Fixed White) | SVG Eye-Fix | Language Animation | Redesigned by Pai ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX_Animated"
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

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3.5; MainStroke.Color = Color3.fromRGB(255, 255, 255)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- ปุ่มลอย S
    local ToggleBtn = Instance.new("TextButton", ScreenGui)
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55); ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); ToggleBtn.Text = "S"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 24
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local BtnStroke = Instance.new("UIStroke", ToggleBtn)
    BtnStroke.Thickness = 2.5; BtnStroke.Color = Color3.fromRGB(255, 255, 255)

    -- Header
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40); Header.BackgroundTransparency = 1
    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.Text = "   " .. Title; TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255); TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextSize = 15
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left; TitleLabel.BackgroundTransparency = 1

    -- ปุ่มตา SVG
    local EyeBtn = Instance.new("ImageButton", Header)
    EyeBtn.Size = UDim2.new(0, 24, 0, 24); EyeBtn.Position = UDim2.new(1, -35, 0.5, -12)
    EyeBtn.BackgroundTransparency = 1; EyeBtn.Image = "rbxassetid://10709810534"
    EyeBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)

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

    local isTransparent = false
    EyeBtn.MouseButton1Click:Connect(function()
        isTransparent = not isTransparent
        local targetT = isTransparent and 0.5 or 0
        EyeBtn.Image = isTransparent and "rbxassetid://10709810723" or "rbxassetid://10709810534"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = targetT}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundTransparency = targetT}):Play()
        EyeBtn.ImageTransparency = 0
    end)

    local WindowAPI = {}
    local RainbowConnection = nil
    local AllElements = {}
    local AllTabs = {}

    -- [[ ฟังก์ชันสำหรับอนิเมชั่นข้อความ ]]
    local function AnimateText(label, newText)
        local TI = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        -- Fade Out
        local fadeOut = TweenService:Create(label, TI, {TextTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        -- Change Text
        label.Text = newText
        -- Fade In
        local fadeIn = TweenService:Create(label, TI, {TextTransparency = 0})
        fadeIn:Play()
    end

    function WindowAPI:Notify(Msg)
        local NotifFrame = Instance.new("Frame", ScreenGui)
        NotifFrame.Size = UDim2.new(0, 200, 0, 40); NotifFrame.Position = UDim2.new(1, 10, 1, -50)
        NotifFrame.BackgroundColor3 = MainFrame.BackgroundColor3
        Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 10)
        local NotifStroke = Instance.new("UIStroke", NotifFrame)
        NotifStroke.Thickness = 2; NotifStroke.Color = Color3.fromRGB(255, 255, 255)
        local NotifText = Instance.new("TextLabel", NotifFrame)
        NotifText.Text = Msg; NotifText.Size = UDim2.new(1, 0, 1, 0); NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotifText.Font = Enum.Font.GothamSemibold; NotifText.BackgroundTransparency = 1
        NotifFrame:TweenPosition(UDim2.new(1, -210, 1, -50), "Out", "Quart", 0.5, true)
        task.wait(3); NotifFrame:TweenPosition(UDim2.new(1, 10, 1, -50), "In", "Quart", 0.5, true)
        task.wait(0.5); NotifFrame:Destroy()
    end

    function WindowAPI:SetColor(NewColor)
        if RainbowConnection then RainbowConnection:Disconnect(); RainbowConnection = nil end
        TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundColor3 = NewColor}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.5), {BackgroundColor3 = NewColor}):Play()
    end

    function WindowAPI:SetRainbow()
        if RainbowConnection then RainbowConnection:Disconnect() end
        RainbowConnection = RunService.RenderStepped:Connect(function()
            local Color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
            MainFrame.BackgroundColor3 = Color; ToggleBtn.BackgroundColor3 = Color
        end)
    end

    -- [[ ระบบเปลี่ยนภาษาแบบ Animated ]]
    function WindowAPI:ChangeLanguage(LangTable)
        -- อนิเมชั่น Tab
        for _, tabData in pairs(AllTabs) do
            if LangTable[tabData.ID] then
                task.spawn(function() AnimateText(tabData.Instance, LangTable[tabData.ID]) end)
            end
        end
        -- อนิเมชั่น Elements
        for _, element in pairs(AllElements) do
            if LangTable[element.ID] then
                local finalTxt = element.Type == "Dropdown" and "  " .. LangTable[element.ID] .. ": " .. element.CurrentValue or LangTable[element.ID]
                task.spawn(function() AnimateText(element.Instance, finalTxt) end)
            end
        end
    end

    -- UI Containers
    local TabContainer = Instance.new("ScrollingFrame", MainFrame)
    TabContainer.Size = UDim2.new(0, 110, 1, -80); TabContainer.Position = UDim2.new(0, 12, 0, 50)
    TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)

    local ContentHolder = Instance.new("Frame", MainFrame)
    ContentHolder.Position = UDim2.new(0, 130, 0, 50); ContentHolder.Size = UDim2.new(1, -142, 1, -65)
    ContentHolder.BackgroundTransparency = 1

    local firstTab = true
    function WindowAPI:CreateTab(TabName, TabID)
        local TabID = TabID or TabName
        local TabBtn = Instance.new("TextButton", TabContainer)
        TabBtn.Size = UDim2.new(1, 0, 0, 32); TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = TabName; TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150); TabBtn.Font = Enum.Font.Gotham
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
        table.insert(AllTabs, {Instance = TabBtn, ID = TabID})

        local Page = Instance.new("ScrollingFrame", ContentHolder)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = firstTab; Page.ScrollBarThickness = 0
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

            function Sub:CreateButton(Txt, ElementID, Call)
                local ElementID = ElementID or Txt
                local B = Instance.new("TextButton", Holder)
                B.Size = UDim2.new(1, 0, 0, 35); B.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                B.Text = Txt; B.TextColor3 = Color3.fromRGB(255, 255, 255); B.Font = Enum.Font.GothamSemibold
                Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
                B.MouseButton1Click:Connect(function() if Call then Call() end end)
                table.insert(AllElements, {Instance = B, ID = ElementID, Type = "Button"})
            end

            function Sub:CreateDropdown(Txt, ElementID, List, Call)
                local ElementID = ElementID or Txt
                local D = Instance.new("TextButton", Holder)
                D.Size = UDim2.new(1, 0, 0, 35); D.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                D.Text = "  " .. Txt .. ": None"; D.TextColor3 = Color3.fromRGB(200, 200, 200)
                D.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", D).CornerRadius = UDim.new(0, 8)
                
                local currentVal = "None"
                local dropdownData = {Instance = D, ID = ElementID, Type = "Dropdown", CurrentValue = currentVal}
                table.insert(AllElements, dropdownData)

                local DF = Instance.new("Frame", Holder)
                DF.Size = UDim2.new(1, 0, 0, 0); DF.Visible = false; DF.ClipsDescendants = true
                DF.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UIListLayout", DF)
                Instance.new("UICorner", DF).CornerRadius = UDim.new(0, 8)

                D.MouseButton1Click:Connect(function()
                    DF.Visible = not DF.Visible
                    local targetSize = DF.Visible and UDim2.new(1, 0, 0, #List * 30) or UDim2.new(1, 0, 0, 0)
                    TweenService:Create(DF, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
                end)
                for _, v in pairs(List) do
                    local O = Instance.new("TextButton", DF)
                    O.Size = UDim2.new(1, 0, 0, 30); O.BackgroundTransparency = 1; O.Text = v
                    O.TextColor3 = Color3.fromRGB(180, 180, 180); O.Font = Enum.Font.Gotham
                    O.MouseButton1Click:Connect(function()
                        currentVal = v; dropdownData.CurrentValue = v
                        D.Text = "  " .. Txt .. ": " .. v
                        DF.Visible = false; DF.Size = UDim2.new(1, 0, 0, 0); Call(v)
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
