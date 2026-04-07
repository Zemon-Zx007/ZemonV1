-- [[ Swift Hub X - PROFESSIONAL LIBRARY V3.1 (FIXED) ]]
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local Settings = Settings or {}
    local Title = Settings.Title or "Swift Hub X"
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SwiftHubX_Zemon_Fixed"; ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170); MainFrame.Size = UDim2.new(0, 420, 0, 340)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3.5; MainStroke.Color = Color3.fromRGB(255, 255, 255)

    local ToggleBtn = Instance.new("TextButton", ScreenGui)
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55); ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); ToggleBtn.Text = "S"; ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 24; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local BtnStroke = Instance.new("UIStroke", ToggleBtn); BtnStroke.Thickness = 2.5; BtnStroke.Color = Color3.fromRGB(255, 255, 255)

    ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local TabBorder = Instance.new("Frame", MainFrame)
    TabBorder.Size = UDim2.new(0, 115, 1, -85); TabBorder.Position = UDim2.new(0, 10, 0, 50); TabBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", TabBorder).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", TabBorder).Thickness = 2; Instance.new("UIStroke", TabBorder).Color = Color3.fromRGB(255, 255, 255)

    local MenuBorder = Instance.new("Frame", MainFrame)
    MenuBorder.Position = UDim2.new(0, 132, 0, 50); MenuBorder.Size = UDim2.new(1, -142, 1, -85); MenuBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", MenuBorder).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", MenuBorder).Thickness = 2; Instance.new("UIStroke", MenuBorder).Color = Color3.fromRGB(255, 255, 255)

    local EyeBtn = Instance.new("ImageButton", MainFrame)
    EyeBtn.Size = UDim2.new(0, 24, 0, 24); EyeBtn.Position = UDim2.new(1, -35, 0, 10); EyeBtn.BackgroundTransparency = 1; EyeBtn.Image = "rbxassetid://10709810534"

    local WindowAPI = {AllTabs = {}, AllElements = {}, CodeBoxes = {}}
    local RainbowConnection = nil

    function WindowAPI:Notify(Msg)
        local f = Instance.new("Frame", ScreenGui)
        f.Size = UDim2.new(0, 220, 0, 45); f.Position = UDim2.new(1, 20, 1, -60); f.BackgroundColor3 = MainFrame.BackgroundColor3
        Instance.new("UICorner", f); Instance.new("UIStroke", f).Color = Color3.fromRGB(255,255,255)
        local t = Instance.new("TextLabel", f); t.Text = Msg; t.Size = UDim2.new(1,0,1,0); t.TextColor3 = Color3.fromRGB(255,255,255); t.BackgroundTransparency = 1
        f:TweenPosition(UDim2.new(1, -240, 1, -60), "Out", "Quart", 0.5, true)
        task.delay(3, function() f:TweenPosition(UDim2.new(1, 20, 1, -60), "In", "Quart", 0.5, true); task.wait(0.5); f:Destroy() end)
    end

    local isTransparent = false
    EyeBtn.MouseButton1Click:Connect(function()
        isTransparent = not isTransparent
        local targetT = isTransparent and 0.5 or 0
        local TI = TweenInfo.new(0.3)
        TweenService:Create(MainFrame, TI, {BackgroundTransparency = targetT}):Play()
        TweenService:Create(TabBorder, TI, {BackgroundTransparency = targetT + 0.2}):Play()
        TweenService:Create(MenuBorder, TI, {BackgroundTransparency = targetT + 0.2}):Play()
        for _, box in pairs(WindowAPI.CodeBoxes) do TweenService:Create(box, TI, {BackgroundTransparency = targetT + 0.3}):Play() end
    end)

    function WindowAPI:SetColor(NewColor)
        if RainbowConnection then RainbowConnection:Disconnect(); RainbowConnection = nil end
        MainFrame.BackgroundColor3 = NewColor; ToggleBtn.BackgroundColor3 = NewColor
    end

    function WindowAPI:SetRainbow()
        if RainbowConnection then RainbowConnection:Disconnect() end
        RainbowConnection = RunService.RenderStepped:Connect(function()
            local Color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
            MainFrame.BackgroundColor3 = Color; ToggleBtn.BackgroundColor3 = Color
        end)
    end

    function WindowAPI:ChangeLanguage(LangTable)
        for _, v in pairs(WindowAPI.AllTabs) do if LangTable[v.ID] then v.Instance.Text = LangTable[v.ID] end end
        for _, v in pairs(WindowAPI.AllElements) do if LangTable[v.ID] then 
            v.Instance.Text = (v.Type == "Dropdown") and "  " .. LangTable[v.ID] .. ": " .. v.CurrentValue or LangTable[v.ID]
        end end
    end

    local TabContainer = Instance.new("ScrollingFrame", TabBorder); TabContainer.Size = UDim2.new(1, -10, 1, -10); TabContainer.Position = UDim2.new(0, 5, 0, 5); TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)
    local ContentHolder = Instance.new("Frame", MenuBorder); ContentHolder.Position = UDim2.new(0, 8, 0, 8); ContentHolder.Size = UDim2.new(1, -16, 1, -16); ContentHolder.BackgroundTransparency = 1

    local first = true
    function WindowAPI:CreateTab(Name, ID)
        local ID = ID or Name; local B = Instance.new("TextButton", TabContainer); B.Size = UDim2.new(1, 0, 0, 32); B.BackgroundColor3 = Color3.fromRGB(22, 22, 22); B.Text = Name
        B.TextColor3 = Color3.fromRGB(150, 150, 150); B.Font = Enum.Font.Gotham; Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        table.insert(WindowAPI.AllTabs, {Instance = B, ID = ID})
        local P = Instance.new("ScrollingFrame", ContentHolder); P.Size = UDim2.new(1, 0, 1, 0); P.BackgroundTransparency = 1; P.Visible = first; P.ScrollBarThickness = 0
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
                local btn = Instance.new("TextButton", H); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                btn.Text = T; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn)
                btn.MouseButton1Click:Connect(function() if C then C() end end)
                table.insert(WindowAPI.AllElements, {Instance = btn, ID = EID, Type = "Button"})
            end
            function Sub:CreateDropdown(T, EID, L, C)
                local d = Instance.new("TextButton", H); d.Size = UDim2.new(1, 0, 0, 35); d.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                d.Text = "  " .. T .. ": None"; d.TextColor3 = Color3.fromRGB(200, 200, 200); d.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", d)
                local data = {Instance = d, ID = EID, Type = "Dropdown", CurrentValue = "None"}
                table.insert(WindowAPI.AllElements, data)
                local df = Instance.new("Frame", H); df.Size = UDim2.new(1, 0, 0, 0); df.Visible = false; df.ClipsDescendants = true; df.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                Instance.new("UIListLayout", df); d.MouseButton1Click:Connect(function() df.Visible = not df.Visible; df.Size = df.Visible and UDim2.new(1, 0, 0, #L * 30) or UDim2.new(1, 0, 0, 0) end)
                for _, v in pairs(L) do
                    local o = Instance.new("TextButton", df); o.Size = UDim2.new(1, 0, 0, 30); o.BackgroundTransparency = 1; o.Text = v; o.TextColor3 = Color3.fromRGB(180, 180, 180)
                    o.MouseButton1Click:Connect(function() data.CurrentValue = v; d.Text = "  " .. T .. ": " .. v; df.Visible = false; df.Size = UDim2.new(1, 0, 0, 0); if C then C(v) end end)
                end
                return {GetSelected = function() return data.CurrentValue end}
            end
            function Sub:CreateCodeBox()
                local Box = Instance.new("Frame", H); Box.Size = UDim2.new(1, 0, 0, 85); Box.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
                Instance.new("UICorner", Box); table.insert(WindowAPI.CodeBoxes, Box)
                local txt = Instance.new("TextLabel", Box); txt.Size = UDim2.new(1, -20, 1, -20); txt.Position = UDim2.new(0, 10, 0, 10)
                txt.BackgroundTransparency = 1; txt.TextColor3 = Color3.fromRGB(0, 255, 150); txt.Font = Enum.Font.Code; txt.TextSize = 14; txt.TextXAlignment = 0; txt.TextYAlignment = 0
                return {SetText = function(val) txt.Text = tostring(val) end}
            end
            return Sub
        end
        return El
    end
    return WindowAPI
end
return Library
