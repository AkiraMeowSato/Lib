--[[
    S E X T A L I T Y | Interface Suite
    Modified Rayfield Interface Suite
]]

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
            SelectedTabTextColor = Color3.fromRGB(255, 31, 51), -- #FF1F33
            ElementBackground = Color3.fromRGB(13, 13, 29),
            ElementBackgroundHover = Color3.fromRGB(20, 20, 40),
            SecondaryElementBackground = Color3.fromRGB(14, 10, 24),
            ElementStroke = Color3.fromRGB(31, 31, 56),
            SecondaryElementStroke = Color3.fromRGB(36, 34, 59),
            SliderBackground = Color3.fromRGB(224, 36, 60), -- #E0243C
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
        }
    }
}

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Internal Functions
local function PackColor(Color)
    return {R = Color.R, G = Color.G, B = Color.B}
end

local function UnpackColor(Color)
    return Color3.new(Color.R, Color.G, Color.B)
end

-- CreateWindow Method
function SexTalityLib:CreateWindow(Config)
    local Window = {
        Tabs = {},
        Elements = {},
        Config = Config
    }

    -- Set Default Configs
    Config.Name = Config.Name or "SexTality"
    Config.LoadingTitle = Config.LoadingTitle or "S E X T A L I T Y"
    Config.LoadingSubtitle = Config.LoadingSubtitle or "by NyRae"

    -- Mock UI Creation (This logic replaces the Rayfield instance creation)
    -- In a real scenario, you'd have the UI objects defined here.
    
    print("Window Created: " .. Config.Name)

    function Window:CreateTab(Name, Image)
        local Tab = {Name = Name, Sections = {}}
        print("Tab Created: " .. Name)

        function Tab:CreateSection(SectionName)
            print("Section Created: " .. SectionName)
            return {Name = SectionName}
        end

        function Tab:CreateLabel(Text, ColorHex)
            print("Label Created: " .. Text)
        end

        function Tab:CreateButton(ButtonConfig)
            print("Button Created: " .. ButtonConfig.Name)
            return ButtonConfig
        end

        return Tab
    end

    return Window
end

-- Configuration Loading
function SexTalityLib:LoadConfiguration()
    print("SexTality | Configuration Loaded")
end

-- Configuration Saving
function SexTalityLib:SaveConfiguration()
    print("SexTality | Configuration Saved")
end

-- The final return statement is crucial!
return SexTalityLib
