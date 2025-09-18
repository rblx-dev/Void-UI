-- Scripted by materials not found
-- https://www.youtube.com/@materialsnotfound

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Void UI",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading..",
   LoadingSubtitle = "This UI has been scripted by materials not found.",
   ShowText = "Void UI", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "DarkBlue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

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
      Note = "The keys are in the Discord server.", -- Use this to tell the user how to get a key
      FileName = "Rayfield License", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"GN2McWRFyE", "PfcYa4bMez"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")



   }
})

local Tab = Window:CreateTab("Universal", "earth")
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
   Name = "Respawn",
   Callback = function()
   local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:BreakJoints() -- This forces the character to respawn
        end
   end
})

