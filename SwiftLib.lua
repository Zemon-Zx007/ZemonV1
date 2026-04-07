-- [[ Swift Hub X - PROFESSIONAL TOGGLE FIXED ]]
-- [[ Fix: Toggle S Button (Hide/Show UI) | Other Systems: Untouched ]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SwiftHubX_Zemon_Pro"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    -- [[ Main Window ]]
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true -- เริ่มต้นให้เห็น UI
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3.5; MainStroke.Color = Color3.fromRGB(255, 255, 255)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- [[ Floating Button S (FIXED: NOW WORKS 100%) ]]
    local ToggleBtn = Instance.new("TextButton", ScreenGui)
    ToggleBtn.Name = "S_Toggle"
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55); ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); ToggleBtn.Text = "S"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 24
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local BtnStroke = Instance.new("UIStroke", ToggleBtn)
    BtnStroke.Thickness = 2.5; BtnStroke.Color = Color3.fromRGB(255, 255, 255)

    -- *** ระบบ Toggle ที่ซีม่อนสั่งแก้ไข ***
    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- [[ Separate Borders (UNTOUCHED - AS REQUESTED) ]]
    local TabBorder = Instance.new("Frame", MainFrame)
    TabBorder.Size = UDim2.new(0, 115, 1, -85); TabBorder.Position = UDim2.new(0, 10, 0, 50)
    TabBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", TabBorder).CornerRadius = UDim.new(0, 12)
    local TabStroke = Instance.new("UIStroke", TabBorder)
    TabStroke.Thickness = 2.5; TabStroke.Color = Color3.fromRGB(255, 255, 255)

    local MenuBorder = Instance.new("Frame", MainFrame)
    MenuBorder.Position = UDim2.new(0, 132, 0, 50); MenuBorder.Size = UDim2.new(1, -142, 1, -85)
    MenuBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", MenuBorder).CornerRadius = UDim.new(0, 12)
    local MenuStroke = Instance.new("UIStroke", MenuBorder)
    MenuStroke.Thickness = 2.5; MenuStroke.Color = Color3.fromRGB(255, 255, 255)

    -- Header & Eye Button
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40); Header.BackgroundTransparency = 1
    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.Text = "   " .. Title; TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255); TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextSize = 15
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left; TitleLabel.BackgroundTransparency = 1

    local EyeBtn = Instance.new("ImageButton", Header)
    EyeBtn.Size = UDim2.new(0, 24, 0, 24); EyeBtn.Position = UDim2.new(1, -35, 0.5, -12)
    EyeBtn.BackgroundTransparency = 1; EyeBtn.Image = "rbxassetid://10709810534"
    EyeBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)

    -- API & Connections
    local WindowAPI = {}
    local RainbowConnection = nil
    local AllElements = {}
    local AllTabs = {}

    -- [[ Transparency System (UNTOUCHED) ]]
    local isTransparent = false
    EyeBtn.MouseButton1Click:Connect(function()
        isTransparent = not isTransparent
        local targetT = isTransparent and 0.5 or 0
        local targetSubT = isTransparent and 0.7 or 0
        EyeBtn.Image = isTransparent and "rbxassetid://10709810723" or "rbxassetid://10709810534"
        local TI = TweenInfo.new(0.3)
        TweenService:Create(MainFrame, TI, {BackgroundTransparency = targetT}):Play()
        TweenService:Create(TabBorder, TI, {BackgroundTransparency = targetSubT}):Play()
        TweenService:Create(MenuBorder, TI, {BackgroundTransparency = targetSubT}):Play()
        TweenService:Create(ToggleBtn, TI, {BackgroundTransparency = targetT}):Play()
        EyeBtn.ImageTransparency = 0
    end)

    function WindowAPI:SetColor(NewColor)
        if RainbowConnection then RainbowConnection:Disconnect(); RainbowConnection = nil end
        local TI = TweenInfo.new(0.5); TweenService:Create(MainFrame, TI, {BackgroundColor3 = NewColor}):Play(); TweenService:Create(ToggleBtn, TI, {BackgroundColor3 = NewColor}):Play()
    end

    function WindowAPI:SetRainbow()
        if RainbowConnection then RainbowConnection:Disconnect() end
        RainbowConnection = RunService.RenderStepped:Connect(function()
            local Color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1); MainFrame.BackgroundColor3 = Color; ToggleBtn.BackgroundColor3 = Color
        end)
    end

    function WindowAPI:ChangeLanguage(LangTable)
        local function Anim(label, txt)
            local T = TweenService:Create(label, TweenInfo.new(0.2), {TextTransparency = 1}); T:Play(); T.Completed:Wait()
            label.Text = txt; TweenService:Create(label, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        end
        for _, v in pairs(AllTabs) do if LangTable[v.ID] then task.spawn(function() Anim(v.Instance, LangTable[v.ID]) end) end end
        for _, v in pairs(AllElements) do if LangTable[v.ID] then
            local final = v.Type == "Dropdown" and "  " .. LangTable[v.ID] .. ": " .. v.CurrentValue or LangTable[v.ID]
            task.spawn(function() Anim(v.Instance, final) end)
        end end
    end

    -- Dragging
    local function drag(f)
        local d, i, s, p
        f.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then d = true; s = input.Position; p = f.Position end end)
        f.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then i = input end end)
        UserInputService.InputChanged:Connect(function(input) if input == i and d then local delta = input.Position - s; f.Position = UDim2.new(p.X.Scale, p.X.Offset + delta.X, p.Y.Scale, p.Y.Offset + delta.Y) end end)
        f.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then d = false end end)
    end
    drag(MainFrame); drag(ToggleBtn)

    -- Containers
    local TabContainer = Instance.new("ScrollingFrame", TabBorder)
    TabContainer.Size = UDim2.new(1, -10, 1, -10); TabContainer.Position = UDim2.new(0, 5, 0, 5); TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)
    local ContentHolder = Instance.new("Frame", MenuBorder)
    ContentHolder.Position = UDim2.new(0, 8, 0, 8); ContentHolder.Size = UDim2.new(1, -16, 1, -16); ContentHolder.BackgroundTransparency = 1

    local first = true
    function WindowAPI:CreateTab(Name, ID)
        local ID = ID or Name
        local B = Instance.new("TextButton", TabContainer)
        B.Size = UDim2.new(1, 0, 0, 32); B.BackgroundColor3 = Color3.fromRGB(22, 22, 22); B.Text = Name
        B.TextColor3 = Color3.fromRGB(150, 150, 150); B.Font = Enum.Font.Gotham; Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        table.insert(AllTabs, {Instance = B, ID = ID})
        local P = Instance.new("ScrollingFrame", ContentHolder)
        P.Size = UDim2.new(1, 0, 1, 0); P.BackgroundTransparency = 1; P.Visible = first; P.ScrollBarThickness = 0
        Instance.new("UIListLayout", P).Padding = UDim.new(0, 10)
        if first then B.TextColor3 = Color3.fromRGB(255, 255, 255); first = false end
        B.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, btn in pairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end end
            P.Visible = true; B.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        local El = {}
        function El:CreateSection()
            local H = Instance.new("Frame", P); H.Size = UDim2.new(1, 0, 0, 0); H.AutomaticSize = Enum.AutomaticSize.Y; H.BackgroundTransparency = 1
            Instance.new("UIListLayout", H).Padding = UDim.new(0, 6)
            local Sub = {}
            function Sub:CreateButton(T, EID, C)
                local EID = EID or T; local btn = Instance.new("TextButton", H)
                btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.Text = T
                btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
                btn.MouseButton1Click:Connect(function() if C then C() end end)
                table.insert(AllElements, {Instance = btn, ID = EID, Type = "Button"})
            end
            function Sub:CreateDropdown(T, EID, L, C)
                local EID = EID or T; local d = Instance.new("TextButton", H)
                d.Size = UDim2.new(1, 0, 0, 35); d.BackgroundColor3 = Color3.fromRGB(22, 22, 22); d.Text = "  " .. T .. ": None"; d.TextColor3 = Color3.fromRGB(200, 200, 200)
                d.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", d).CornerRadius = UDim.new(0, 8)
                local data = {Instance = d, ID = EID, Type = "Dropdown", CurrentValue = "None"}
                table.insert(AllElements, data)
                local df = Instance.new("Frame", H); df.Size = UDim2.new(1, 0, 0, 0); df.Visible = false; df.ClipsDescendants = true
                df.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UIListLayout", df); Instance.new("UICorner", df).CornerRadius = UDim.new(0, 8)
                d.MouseButton1Click:Connect(function() df.Visible = not df.Visible; TweenService:Create(df, TweenInfo.new(0.3), {Size = df.Visible and UDim2.new(1, 0, 0, #L * 30) or UDim2.new(1, 0, 0, 0)}):Play() end)
                for _, v in pairs(L) do
                    local o = Instance.new("TextButton", df); o.Size = UDim2.new(1, 0, 0, 30); o.BackgroundTransparency = 1; o.Text = v; o.TextColor3 = Color3.fromRGB(180, 180, 180)
                    o.MouseButton1Click:Connect(function() data.CurrentValue = v; d.Text = "  " .. T .. ": " .. v; df.Visible = false; df.Size = UDim2.new(1, 0, 0, 0); C(v) end)
                end
            end
            return Sub
        end
        return El
    end
    return WindowAPI
end

return Library
