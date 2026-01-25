-- Scripted by materials not found
-- https://www.youtube.com/@materialsnotfound

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Void UI (discord.gg/GN2McWRFyE)",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading UI..",
   LoadingSubtitle = "Scripted by materials not found.",
   ShowText = "Void UI", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "X", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Void UI", -- Create a custom folder for your hub/game
      FileName = "Void Configuration"
   },

    Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "GN2McWRFyE", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "discord.gg/GN2McWRFyE",
      Subtitle = "Enter your license key.",
      Note = "The keys can be found in the Discord server.", -- Use this to tell the user how to get a key
      FileName = "what are you doing here, bro", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"VOID"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")



   }
})

Rayfield:Notify({
   Title = "Injected.",
   Content = "https://www.youtube.com/@materialsnotfound",
   Duration = 5.0,
   Image = "check",
})

local Tab = Window:CreateTab("Admin", "shield")
local Button = Tab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Nameless Admin",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "QuirkyCMD",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/QuirkyCMD.lua"))()
   Rayfield:Destroy()
   end
})

local Tab = Window:CreateTab("Games", "gamepad-2")
local Button = Tab:CreateButton({
   Name = "The Strongest Battlegrounds",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/tamarixr/tamhub/main/bettertamhub.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Slap Tower",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/Slap-Tower-Script"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
	Name = "Ink Game",
	Callback = function()
	loadstring(game:HttpGet("raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Ink%20Game.lua"))()
   Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
   Name = "Evade",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Evade.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Prison Life",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Prison%20Life.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Natural Disaster Survival",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Natural%20Disaster%20Survival.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "DOORS",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/DOORS.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Dead Rails",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Dead%20Rails.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "RIVALS",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/RIVALS.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Arsenal",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Arsenal.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Combat Warriors",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Combat%20Warriors.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
	Name = "99 Nights in the Forest",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/99%20Nights%20in%20the%20Forest.lua"))()
	Rayfield:Destroy()
	end
})

local Tab = Window:CreateTab("Commands", "unlink-2")
local Button = Tab:CreateButton({
   Name = "AnnaBypasser",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/AnnaBypasser.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Ultimate Trolling GUI",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/UTG%20V6.lua"))()
   end
})

local Tab = Window:CreateTab("Universal", "earth")
local Button = Tab:CreateButton({
   Name = "Null Fire",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Null%20Fire.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Paste Ware",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Paste%20Ware.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Fast Animation",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Fast%20Animation.lua"))()
   end
})

local Input = Tab:CreateInput({
   Name = "Framerate Limit",
   CurrentValue = "",
   PlaceholderText = "60",
   RemoveTextAfterFocusLost = false,
   Flag = "Framerate",
   Callback = function(Text)
   setfpscap(Text)
   end
})
