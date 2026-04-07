-- [[ Swift Hub X - PROFESSIONAL LIBRARY V4.7 (FULL RECOVERY) ]]
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(Settings)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SwiftHubX_V4.7"; ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170); MainFrame.Size = UDim2.new(0, 420, 0, 340)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    local Stroke = Instance.new("UIStroke", MainFrame); Stroke.Thickness = 3.5; Stroke.Color = Color3.fromRGB(255, 255, 255)

    -- [[ โลโก้ตรงกลาง ]]
    local Logo = Instance.new("ImageLabel", MainFrame)
    Logo.Size = UDim2.new(0, 40, 0, 40); Logo.Position = UDim2.new(0.5, -20, 0, -5)
    Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Logo.Image = "rbxassetid://13144837580"
    Instance.new("UICorner", Logo).CornerRadius = UDim.new(1, 0)
    local LStroke = Instance.new("UIStroke", Logo); LStroke.Thickness = 2; LStroke.Color = Color3.fromRGB(255, 255, 255)

    -- [[ ไอคอนลูกตา (โปร่งใส/ทึบ) ]]
    local EyeBtn = Instance.new("ImageButton", MainFrame)
    EyeBtn.Size = UDim2.new(0, 25, 0, 25); EyeBtn.Position = UDim2.new(1, -35, 0, 10)
    EyeBtn.BackgroundTransparency = 1; EyeBtn.Image = "rbxassetid://6031763426" -- Eye Icon
    local toggled = false
    EyeBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        MainFrame.BackgroundTransparency = toggled and 0.5 or 0
        for _, v in pairs(MainFrame:GetDescendants()) do
            if v:IsA("Frame") and v ~= MainFrame then v.BackgroundTransparency = toggled and 0.5 or 0
            elseif v:IsA("ScrollingFrame") then v.BackgroundTransparency = 1 end
        end
    end)

    local ToggleBtn = Instance.new("TextButton", ScreenGui)
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55); ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); ToggleBtn.Text = "S"; ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 24; Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local BStroke = Instance.new("UIStroke", ToggleBtn); BStroke.Thickness = 2.5; BStroke.Color = Color3.fromRGB(255, 255, 255)
    
    local dragging, dragInput, dragStart, startPos
    local function applyDrag(frame)
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
    end
    applyDrag(MainFrame); applyDrag(ToggleBtn)
    ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Text = "   " .. (Settings.Title or "Swift Hub X"); TitleLabel.Size = UDim2.new(1, -40, 0, 40); TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextSize = 16; TitleLabel.TextXAlignment = 0; TitleLabel.BackgroundTransparency = 1

    local WindowAPI = {AllTabs = {}, AllElements = {}, CodeBoxes = {}}
    local RainbowConnection = nil

    function WindowAPI:Notify(Msg)
        local f = Instance.new("Frame", ScreenGui); f.Size = UDim2.new(0, 220, 0, 45); f.Position = UDim2.new(1, 20, 1, -60); f.BackgroundColor3 = MainFrame.BackgroundColor3
        Instance.new("UICorner", f); Instance.new("UIStroke", f).Color = Color3.fromRGB(255,255,255)
        local t = Instance.new("TextLabel", f); t.Text = Msg; t.Size = UDim2.new(1,0,1,0); t.TextColor3 = Color3.fromRGB(255,255,255); t.BackgroundTransparency = 1; t.Font = Enum.Font.GothamSemibold
        f:TweenPosition(UDim2.new(1, -240, 1, -60), "Out", "Quart", 0.5, true)
        task.delay(3, function() f:TweenPosition(UDim2.new(1, 20, 1, -60), "In", "Quart", 0.5, true); task.wait(0.5); f:Destroy() end)
    end

    function WindowAPI:SetColor(C) if RainbowConnection then RainbowConnection:Disconnect(); RainbowConnection = nil end; MainFrame.BackgroundColor3 = C; ToggleBtn.BackgroundColor3 = C; Logo.BackgroundColor3 = C end
    function WindowAPI:SetRainbow() if RainbowConnection then RainbowConnection:Disconnect() end; RainbowConnection = RunService.RenderStepped:Connect(function() local C = Color3.fromHSV(tick() % 5 / 5, 0.8, 1); MainFrame.BackgroundColor3 = C; ToggleBtn.BackgroundColor3 = C; Logo.BackgroundColor3 = C end) end

    function WindowAPI:ChangeLanguage(LT)
        for _, v in pairs(self.AllTabs) do if LT[v.ID] then v.Instance.Text = LT[v.ID] end end
        for _, v in pairs(self.AllElements) do 
            if LT[v.ID] then 
                if v.Type == "Dropdown" then v.Instance.Text = "  " .. LT[v.ID] .. ": " .. (v.CurrentValue or "None")
                elseif v.Type == "TextBox" then v.Instance.PlaceholderText = LT[v.ID]
                else v.Instance.Text = LT[v.ID] end
            end 
        end
    end

    local TabBorder = Instance.new("Frame", MainFrame); TabBorder.Size = UDim2.new(0, 115, 1, -85); TabBorder.Position = UDim2.new(0, 10, 0, 50); TabBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12); Instance.new("UICorner", TabBorder); Instance.new("UIStroke", TabBorder).Color = Color3.fromRGB(255, 255, 255)
    local MenuBorder = Instance.new("Frame", MainFrame); MenuBorder.Position = UDim2.new(0, 132, 0, 50); MenuBorder.Size = UDim2.new(1, -142, 1, -85); MenuBorder.BackgroundColor3 = Color3.fromRGB(12, 12, 12); Instance.new("UICorner", MenuBorder); Instance.new("UIStroke", MenuBorder).Color = Color3.fromRGB(255, 255, 255)
    local TabContainer = Instance.new("ScrollingFrame", TabBorder); TabContainer.Size = UDim2.new(1, -10, 1, -10); TabContainer.Position = UDim2.new(0, 5, 0, 5); TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0; Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)
    local ContentHolder = Instance.new("Frame", MenuBorder); ContentHolder.Position = UDim2.new(0, 8, 0, 8); ContentHolder.Size = UDim2.new(1, -16, 1, -16); ContentHolder.BackgroundTransparency = 1

    local IsFirst = true
    function WindowAPI:CreateTab(Name, ID)
        local ID = ID or Name
        local B = Instance.new("TextButton", TabContainer); B.Size = UDim2.new(1, 0, 0, 32); B.BackgroundColor3 = Color3.fromRGB(22, 22, 22); B.Text = Name; B.TextColor3 = Color3.fromRGB(150, 150, 150); B.Font = Enum.Font.Gotham; Instance.new("UICorner", B)
        table.insert(WindowAPI.AllTabs, {Instance = B, ID = ID})
        local P = Instance.new("ScrollingFrame", ContentHolder); P.Size = UDim2.new(1, 0, 1, 0); P.BackgroundTransparency = 1; P.Visible = false; P.ScrollBarThickness = 0; Instance.new("UIListLayout", P).Padding = UDim.new(0, 10)
        if IsFirst then P.Visible = true; B.TextColor3 = Color3.fromRGB(255, 255, 255); IsFirst = false end
        B.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentHolder:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, btn in pairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end end
            P.Visible = true; B.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        local El = {}
        function El:CreateSection()
            local H = Instance.new("Frame", P); H.Size = UDim2.new(1, 0, 0, 0); H.AutomaticSize = Enum.AutomaticSize.Y; H.BackgroundTransparency = 1; Instance.new("UIListLayout", H).Padding = UDim.new(0, 6)
            local Sub = {}
            function Sub:CreateButton(T, EID, C)
                local btn = Instance.new("TextButton", H); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.Text = T; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", btn)
                btn.MouseButton1Click:Connect(function() if C then C() end end); table.insert(WindowAPI.AllElements, {Instance = btn, ID = EID, Type = "Button"})
            end
            function Sub:CreateTextBox(PH, EID, C)
                local box = Instance.new("TextBox", H); box.Size = UDim2.new(1, 0, 0, 35); box.BackgroundColor3 = Color3.fromRGB(20, 20, 20); box.PlaceholderText = PH; box.Text = ""; box.TextColor3 = Color3.fromRGB(255, 255, 255); box.Font = Enum.Font.Gotham; box.PlaceholderColor3 = Color3.fromRGB(100, 100, 100); Instance.new("UICorner", box)
                box.FocusLost:Connect(function() if C then C(box.Text) end end); table.insert(WindowAPI.AllElements, {Instance = box, ID = EID, Type = "TextBox"})
            end
            function Sub:CreateDropdown(T, EID, L, C)
                local d = Instance.new("TextButton", H); d.Size = UDim2.new(1, 0, 0, 35); d.BackgroundColor3 = Color3.fromRGB(22, 22, 22); d.Text = "  " .. T .. ": None"; d.TextColor3 = Color3.fromRGB(200, 200, 200); d.TextXAlignment = 0; Instance.new("UICorner", d)
                local data = {Instance = d, ID = EID, Type = "Dropdown", CurrentValue = "None"}; table.insert(WindowAPI.AllElements, data)
                local df = Instance.new("Frame", H); df.Size = UDim2.new(1, 0, 0, 0); df.Visible = false; df.ClipsDescendants = true; df.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UIListLayout", df)
                local function UpdateList(NewL)
                    for _, child in pairs(df:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
                    for _, v in pairs(NewL) do
                        local o = Instance.new("TextButton", df); o.Size = UDim2.new(1, 0, 0, 30); o.BackgroundTransparency = 1; o.Text = v; o.TextColor3 = Color3.fromRGB(180, 180, 180)
                        o.MouseButton1Click:Connect(function() data.CurrentValue = v; d.Text = "  " .. T .. ": " .. v; df.Visible = false; df.Size = UDim2.new(1, 0, 0, 0); if C then C(v) end end)
                    end
                end
                UpdateList(L)
                d.MouseButton1Click:Connect(function() df.Visible = not df.Visible; df.Size = df.Visible and UDim2.new(1, 0, 0, math.min(#df:GetChildren() * 30, 120)) or UDim2.new(1, 0, 0, 0) end)
                return {Refresh = function(self, NewL) UpdateList(NewL) end}
            end
            function Sub:CreateCodeBox()
                local Box = Instance.new("Frame", H); Box.Size = UDim2.new(1, 0, 0, 0); Box.AutomaticSize = Enum.AutomaticSize.Y; Box.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Instance.new("UICorner", Box); local BS = Instance.new("UIStroke", Box); BS.Thickness = 2.5
                RunService.RenderStepped:Connect(function() BS.Color = Color3.fromHSV(tick() % 4 / 4, 1, 1) end)
                table.insert(WindowAPI.CodeBoxes, Box)
                local txt = Instance.new("TextLabel", Box); txt.Size = UDim2.new(1, -20, 0, 0); txt.AutomaticSize = Enum.AutomaticSize.Y; txt.Position = UDim2.new(0, 10, 0, 10); txt.BackgroundTransparency = 1; txt.TextColor3 = Color3.fromRGB(0, 255, 150); txt.Font = Enum.Font.Code; txt.TextSize = 13; txt.TextXAlignment = 0; txt.TextYAlignment = 0; txt.RichText = true; txt.TextWrapped = true; txt.Text = "⏳ Loading Data..."
                return {SetText = function(self, val) txt.Text = tostring(val) end}
            end
            return Sub
        end
        return El
    end
    return WindowAPI
end
return Library
