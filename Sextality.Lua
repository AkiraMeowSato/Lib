--[[
	S E X T A L I T Y 
	Interface Suite
	
	Original by Sirius | Modified for SexTality
]]

if debugX then
	warn('Initialising SexTality')
end

local function getService(name)
	local service = game:GetService(name)
	return if cloneref then cloneref(service) else service
end

-- Loads and executes a function hosted on a remote URL. 
local function loadWithTimeout(url: string, timeout: number?): ...any
	assert(type(url) == "string", "Expected string, got " .. type(url))
	timeout = timeout or 5
	local requestCompleted = false
	local success, result = false, nil

	local requestThread = task.spawn(function()
		local fetchSuccess, fetchResult = pcall(game.HttpGet, game, url) 
		if not fetchSuccess or #fetchResult == 0 then
			if #fetchResult == 0 then
				fetchResult = "Empty response"
			end
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
			warn("Request for " .. url .. " timed out after " .. tostring(timeout) .. " seconds")
			task.cancel(requestThread)
			result = "Request timed out"
			requestCompleted = true
		end
	end)

	while not requestCompleted do
		task.wait()
	end

	if coroutine.status(timeoutThread) ~= "dead" then
		task.cancel(timeoutThread)
	end
	if not success then
		warn("Failed to process " .. tostring(url) .. ": " .. tostring(result))
	end
	return if success then result else nil
end

local requestsDisabled = true 
local InterfaceBuild = '3K3W'
local Release = "Build 1.68"
local SexTalityFolder = "SexTality"
local ConfigurationFolder = SexTalityFolder.."/Configurations"
local ConfigurationExtension = ".rfld"

local settingsTable = {
	General = {
		rayfieldOpen = {Type = 'bind', Value = 'K', Name = 'SexTality Keybind'},
	},
	System = {
		usageAnalytics = {Type = 'toggle', Value = true, Name = 'Anonymised Analytics'},
	}
}

local overriddenSettings: { [string]: any } = {} 
local function overrideSetting(category: string, name: string, value: any)
	overriddenSettings[category .. "." .. name] = value
end

local function getSetting(category: string, name: string): any
	if overriddenSettings[category .. "." .. name] ~= nil then
		return overriddenSettings[category .. "." .. name]
	elseif settingsTable[category][name] ~= nil then
		return settingsTable[category][name].Value
	end
end

if requestsDisabled then
	overrideSetting("System", "usageAnalytics", false)
end

local HttpService = getService('HttpService')
local RunService = getService('RunService')

local useStudio = RunService:IsStudio() or false
local settingsCreated = false
local settingsInitialized = false 
local cachedSettings

-- Main Library Table Renamed
local SexTalityLib = {
	Flags = {},
	Theme = {
		Default = {
			TextColor = Color3.fromRGB(206, 191, 209), -- #cebfd1
			Background = Color3.fromRGB(14, 10, 24), -- #0e0a18
			Topbar = Color3.fromRGB(14, 10, 24),
			Shadow = Color3.fromRGB(0, 0, 0),
			NotificationBackground = Color3.fromRGB(13, 13, 29),
			NotificationActionsBackground = Color3.fromRGB(36, 34, 59),
			TabBackground = Color3.fromRGB(13, 13, 29),
			TabStroke = Color3.fromRGB(31, 31, 56),
			TabBackgroundSelected = Color3.fromRGB(36, 34, 59),
			TabTextColor = Color3.fromRGB(68, 68, 85),
			SelectedTabTextColor = Color3.fromRGB(255, 31, 51),
			ElementBackground = Color3.fromRGB(13, 13, 29),
			ElementBackgroundHover = Color3.fromRGB(20, 20, 40),
			SecondaryElementBackground = Color3.fromRGB(14, 10, 24),
			ElementStroke = Color3.fromRGB(31, 31, 56),
			SecondaryElementStroke = Color3.fromRGB(36, 34, 59),
			SliderBackground = Color3.fromRGB(224, 36, 60),
			SliderProgress = Color3.fromRGB(255, 31, 51),
			SliderStroke = Color3.fromRGB(31, 31, 56),
			ToggleBackground = Color3.fromRGB(13, 13, 29),
			ToggleEnabled = Color3.fromRGB(224, 36, 60),
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
		},
        -- Other themes removed for brevity, but would follow the same pattern
	}
}

-- Services
local UserInputService = getService("UserInputService")
local TweenService = getService("TweenService")
local Players = getService("Players")
local CoreGui = getService("CoreGui")

-- Interface Management
local SexTalityUI = useStudio and script.Parent:FindFirstChild('SexTalityUI') or game:GetObjects("rbxassetid://10804731440")[1]
local buildAttempts = 0
local correctBuild = false
local sexTalityDestroyed = false 

-- Logic for SexTalityLib:Destroy() would go here later in the script...

return SexTalityLib
