--[[
	SexTality Interface Suite (Fatality Edition)
	Modified for Red Theme & Floating User Session
]]

local SexTalityLib = {
    Flags = {},
    Theme = {
        Default = {
            TextColor = Color3.fromRGB(206, 191, 209),
            Background = Color3.fromRGB(14, 10, 24),
            Topbar = Color3.fromRGB(14, 10, 24),
            Shadow = Color3.fromRGB(0, 0, 0),
            NotificationBackground = Color3.fromRGB(13, 13, 29),
            TabBackground = Color3.fromRGB(13, 13, 29),
            TabTextColor = Color3.fromRGB(68, 68, 85),
            SelectedTabTextColor = Color3.fromRGB(255, 31, 51), -- Fatality Red
            ElementBackground = Color3.fromRGB(13, 13, 29),
            ElementStroke = Color3.fromRGB(31, 31, 56),
            ToggleEnabled = Color3.fromRGB(255, 31, 51),
            SliderProgress = Color3.fromRGB(255, 31, 51),
            InputStroke = Color3.fromRGB(31, 31, 56)
        }
    }
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local SexTality = game:GetObjects("rbxassetid://10804731440")[1]
SexTality.Name = "SexTality"
SexTality.Parent = (gethui and gethui()) or CoreGui

function SexTalityLib:CreateWindow(Settings)
    local Window = {Tabs = {}, Elements = {}, Settings = Settings}
    local Main = SexTality.Main
    
    -- 🔴 THE FLOATING BOX METHOD (Fixed Method Error)
    function Window:CreateFloatingSection(Name)
        local FloatingBox = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")
        local BoxTitle = Instance.new("TextLabel")
        local UserInfo = Instance.new("TextLabel")
        local CloseBtn = Instance.new("TextButton")

        FloatingBox.Name = "UserSessionBox"
        FloatingBox.Parent = SexTality
        FloatingBox.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
        FloatingBox.Position = UDim2.new(0.5, 275, 0.5, -100) 
        FloatingBox.Size = UDim2.new(0, 190, 0, 100)
        FloatingBox.ZIndex = 100
        FloatingBox.Active = true
        FloatingBox.Draggable = true 

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = FloatingBox

        UIStroke.Color = Color3.fromRGB(255, 31, 51)
        UIStroke.Thickness = 1.5
        UIStroke.Parent = FloatingBox

        BoxTitle.Parent = FloatingBox
        BoxTitle.BackgroundTransparency = 1
        BoxTitle.Position = UDim2.new(0, 10, 0, 5)
        BoxTitle.Size = UDim2.new(0, 150, 0, 20)
        BoxTitle.Font = Enum.Font.Ubuntu
        BoxTitle.Text = Name or "USER SESSION"
        BoxTitle.TextColor3 = Color3.fromRGB(255, 31, 51)
        BoxTitle.TextSize = 13
        BoxTitle.TextXAlignment = Enum.TextXAlignment.Left

        CloseBtn.Parent = FloatingBox
        CloseBtn.BackgroundTransparency = 1
        CloseBtn.Position = UDim2.new(1, -25, 0, 2)
        CloseBtn.Size = UDim2.new(0, 20, 0, 20)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 31, 51)
        CloseBtn.TextSize = 14
        CloseBtn.MouseButton1Click:Connect(function() FloatingBox:Destroy() end)

        UserInfo.Parent = FloatingBox
        UserInfo.BackgroundTransparency = 1
        UserInfo.Position = UDim2.new(0, 10, 0, 35)
        UserInfo.Size = UDim2.new(1, -20, 0, 60)
        UserInfo.Font = Enum.Font.Ubuntu
        UserInfo.Text = "Welcome, NyRae\nExpires: Lifetime\nStatus: Active"
        UserInfo.TextColor3 = Color3.fromRGB(206, 191, 209)
        UserInfo.TextSize = 12
        UserInfo.TextXAlignment = Enum.TextXAlignment.Left
        UserInfo.TextYAlignment = Enum.TextYAlignment.Top

        return FloatingBox
    end

    -- Apply Fatality Theme to Main UI
    Main.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
    Main.Topbar.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
    
    -- Key System Styling (Matches your drawn images)
    if SexTality:FindFirstChild("KeyUI") then
        local KeyMain = SexTality.KeyUI.Main
        KeyMain.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
        KeyMain.Title.TextColor3 = Color3.fromRGB(255, 31, 51)
        KeyMain.Input.UIStroke.Color = Color3.fromRGB(255, 31, 51)
        KeyMain.CheckKey.BackgroundColor3 = Color3.fromRGB(255, 31, 51)
    end

    -- Tab & Element Logic (Condensed)
    function Window:CreateTab(Name, Image)
        local Tab = {Name = Name, Elements = {}}
        local TabBtn = SexTality.Elements.TabButton:Clone()
        TabBtn.Parent = Main.SideBar.TabContainer
        TabBtn.Title.Text = Name
        TabBtn.Visible = true
        
        TabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(Main.SideBar.TabContainer:GetChildren()) do
                if v:IsA("TextButton") then v.Title.TextColor3 = Color3.fromRGB(68, 68, 85) end
            end
            TabBtn.Title.TextColor3 = Color3.fromRGB(255, 31, 51)
        end)
        
        return Tab
    end

    return Window
end

return SexTalityLib
