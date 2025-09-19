-- Scripted by materials not found
-- https://www.youtube.com/@materialsnotfound

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Void UI",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading..",
   LoadingSubtitle = "Scripted by materials not found.",
   ShowText = "Void UI", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Void UI", -- Create a custom folder for your hub/game
      FileName = "Void UI"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "GN2McWRFyE", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = false -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "User verification.",
      Subtitle = "Enter your license key.",
      Note = "You will only need to do this once.", -- Use this to tell the user how to get a key
      FileName = "Void License", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"GN2McWRFyE", "PfcYa4bMez"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")



   }
})

local Tab = Window:CreateTab("Admin", "shield")
local Button = Tab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Nameless Admin",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Fate's Admin",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
   end
})

local Tab = Window:CreateTab("Games", "gamepad-2")
local Button = Tab:CreateButton({
   Name = "The Strongest Battlegrounds",
   Callback = function()
   loadstring(game:HttpGet"https://raw.githubusercontent.com/tamarixr/tamhub/main/bettertamhub.lua")()
   end
})

local Button = Tab:CreateButton({
   Name = "Slap Tower",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/Slap-Tower-Script"))()
   end
})

local Button = Tab:CreateButton({
	Name = "Ink Game",
	Callback = function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/lebumbum/leyield/refs/heads/main/inkgame'))()
	Rayfield:Destroy()
	end

local Tab = Window:CreateTab("Commands", "unlink-2")
local Button = Tab:CreateButton({
   Name = "Coming Soon!",
   Callback = function()
   print("This tab is coming soon.")
   end
})
