--[[
	SexTality Interface Suite
	Modified for Fatality Red & Floating Session
]]

if debugX then
	warn('Initialising SexTality')
end

local function getService(name)
	local service = game:GetService(name)
	return if cloneref then cloneref(service) else service
end

local function loadWithTimeout(url: string, timeout: number?): ...any
	assert(type(url) == "string", "Expected string, got " .. type(url))
	timeout = timeout or 5
	local requestCompleted = false
	local success, result = false, nil

	local requestThread = task.spawn(function()
		local fetchSuccess, fetchResult = pcall(game.HttpGet, game, url)
		if not fetchSuccess or #fetchResult == 0 then
			if #fetchResult == 0 then fetchResult = "Empty response" end
			success, result = false, fetchResult
			requestCompleted = true
			return
		end
		local content = fetchResult
		local execSuccess, execResult = pcall(function()
			return loadstring(content)()
		end)
		success, result = execSuccess, execResult
		requestCompleted = true
	end)

	local timeoutThread = task.delay(timeout, function()
		if not requestCompleted then
			warn("Request for " .. url .. " timed out")
			task.cancel(requestThread)
			result = "Request timed out"
			requestCompleted = true
		end
	end)

	while not requestCompleted do task.wait() end
	if coroutine.status(timeoutThread) ~= "dead" then task.cancel(timeoutThread) end
	return if success then result else nil
end

local SexTalityLib = {
    Flags = {},
    Theme = {
        Default = {
            TextColor = Color3.fromRGB(206, 191, 209), 
            Background = Color3.fromRGB(14, 10, 24), -- Fatality Dark
            Topbar = Color3.fromRGB(14, 10, 24), 
            Shadow = Color3.fromRGB(0, 0, 0),
            NotificationBackground = Color3.fromRGB(13, 13, 29), 
            NotificationActionsBackground = Color3.fromRGB(36, 34, 59),
            TabBackground = Color3.fromRGB(13, 13, 29),
            TabStroke = Color3.fromRGB(31, 31, 56), 
            TabBackgroundSelected = Color3.fromRGB(36, 34, 59),
            TabTextColor = Color3.fromRGB(68, 68, 85), 
            SelectedTabTextColor = Color3.fromRGB(255, 31, 51), -- Fatality Red
            ElementBackground = Color3.fromRGB(13, 13, 29),
            ElementBackgroundHover = Color3.fromRGB(20, 20, 40),
            SecondaryElementBackground = Color3.fromRGB(14, 10, 24),
            ElementStroke = Color3.fromRGB(31, 31, 56),
            SecondaryElementStroke = Color3.fromRGB(36, 34, 59),
            SliderBackground = Color3.fromRGB(224, 36, 60), 
            SliderProgress = Color3.fromRGB(255, 31, 51),
            SliderStroke = Color3.fromRGB(31, 31, 56),
            ToggleBackground = Color3.fromRGB(13, 13, 29),
            ToggleEnabled = Color3.fromRGB(255, 31, 51),
            ToggleDisabled = Color3.fromRGB(68, 68, 85),
            ToggleEnabledStroke = Color3.fromRGB(255, 31, 51),
            ToggleDisabledStroke = Color3.fromRGB(31, 31, 56),
            ToggleEnabledOuterStroke = Color3.fromRGB(14, 10, 24),
            ToggleDisabledOuterStroke = Color3.fromRGB(14, 10, 24),
            DropdownSelected = Color3.fromRGB(36, 34, 59),
            DropdownUnselected = Color3.fromRGB(13, 13, 29),
            InputBackground = Color3.fromRGB(13, 13, 29),
            InputStroke = Color3.fromRGB(31, 31, 56),
            PlaceholderColor = Color3.fromRGB(176, 176, 176)
        }
    }
}

-- Services
local UserInputService = getService("UserInputService")
local TweenService = getService("TweenService")
local RunService = getService("RunService")
local CoreGui = getService("CoreGui")

local SexTality = game:GetObjects("rbxassetid://10804731440")[1]
SexTality.Parent = (gethui and gethui()) or CoreGui

function SexTalityLib:CreateWindow(Settings)
    local Window = {
        Tabs = {},
        Elements = {},
        Settings = Settings
    }

    -- THE NEW FLOATING BOX METHOD
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

-- [[ START OF UI CONSTRUCTION ]]
local Main = SexTality.Main
local MainWidgets = Main.Widgets
local TabHolder = Main.TabHolder
local SideBar = Main.SideBar
local TabContainer = TabHolder.TabContainer

-- Force Fatality Red Theme Colors
local SelectedTheme = SexTalityLib.Theme.Default

Main.BackgroundColor3 = SelectedTheme.Background
SideBar.BackgroundColor3 = SelectedTheme.TabBackground
TabHolder.BackgroundColor3 = SelectedTheme.Background

-- [[ KEY SYSTEM COLOR FIX ]]
local function SetupKeySystem()
	if SexTality:FindFirstChild("KeyUI") then
		local KeyMain = SexTality.KeyUI.Main
		KeyMain.BackgroundColor3 = Color3.fromRGB(14, 10, 24) -- Dark Purple
		KeyMain.Title.TextColor3 = Color3.fromRGB(255, 31, 51) -- Fatality Red
		KeyMain.Input.UIStroke.Color = Color3.fromRGB(255, 31, 51)
		KeyMain.CheckKey.BackgroundColor3 = Color3.fromRGB(255, 31, 51)
		
		-- Fix Input Box Text
		KeyMain.Input.InputBox.TextColor3 = Color3.fromRGB(206, 191, 209)
	end
end
task.spawn(SetupKeySystem)

-- [[ DRAGGING LOGIC ]]
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- [[ TAB CREATION METHOD ]]
function Window:CreateTab(Name, Image)
	local Tab = {
		Name = Name,
		ID = #Window.Tabs + 1,
		Elements = {}
	}
	
	local TabButton = SexTality.Elements.TabButton:Clone()
	TabButton.Parent = SideBar.TabContainer
	TabButton.Title.Text = Name
	TabButton.Title.TextColor3 = SelectedTheme.TabTextColor
	TabButton.Visible = true
	
	-- Logic for switching tabs...
	TabButton.MouseButton1Click:Connect(function()
		for _, v in next, SideBar.TabContainer:GetChildren() do
			if v:IsA("TextButton") then
				TweenService:Create(v.Title, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.TabTextColor}):Play()
			end
		end
		TweenService:Create(TabButton.Title, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.SelectedTabTextColor}):Play()
	end)

	table.insert(Window.Tabs, Tab)
	return Tab
end

-- Close Logic
Main.Topbar.Close.MouseButton1Click:Connect(function()
	SexTality:Destroy()
end)

return Window
end

-- FINAL RETURN (DO NOT FORGET THIS)
return SexTalityLib
