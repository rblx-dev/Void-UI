--[[

 _____                                                 _____ 
( ___ )                                               ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   | __     __   ___    ___   ____      _   _   ___  |   | 
 |   | \ \   / /  / _ \  |_ _| |  _ \    | | | | |_ _| |   | 
 |   |  \ \ / /  | | | |  | |  | | | |   | | | |  | |  |   | 
 |   |   \ V /   | |_| |  | |  | |_| |   | |_| |  | |  |   | 
 |   |    \_/     \___/  |___| |____/     \___/  |___| |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                               (_____)


 _____                                                                                                                               _____ 
( ___ )                                                                                                                             ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   |                      _                   _           _                           _        __                               _  |   | 
 |   |  _ __ ___     __ _  | |_    ___   _ __  (_)   __ _  | |  ___     _ __     ___   | |_     / _|   ___    _   _   _ __     __| | |   | 
 |   | | '_ ` _ \   / _` | | __|  / _ \ | '__| | |  / _` | | | / __|   | '_ \   / _ \  | __|   | |_   / _ \  | | | | | '_ \   / _` | |   | 
 |   | | | | | | | | (_| | | |_  |  __/ | |    | | | (_| | | | \__ \   | | | | | (_) | | |_    |  _| | (_) | | |_| | | | | | | (_| | |   | 
 |   | |_| |_| |_|  \__,_|  \__|  \___| |_|    |_|  \__,_| |_| |___/   |_| |_|  \___/   \__|   |_|    \___/   \__,_| |_| |_|  \__,_| |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                                                                                                             (_____)

]]

print(identifyexecutor())
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Rayfield.lua'))()
local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Window = Rayfield:CreateWindow({
   Name = "Void UI (discord.gg/GN2McWRFyE)",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading UI..",
   LoadingSubtitle = "Scripted by MNF on YouTube.",
   ShowText = "UI", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "X", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = "Void UI", -- Create a custom folder for your hub/game
      FileName = "Void Configuration"
   },

    Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "GN2McWRFyE", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = false -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "discord.gg/GN2McWRFyE",
      Subtitle = "Discord.",
      Note = 'The key is "VOID", in all capitals.', -- Use this to tell the user how to get a key
      FileName = "Void License", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"VOID"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")



   }
})

Rayfield:Notify({
   Title = "Finished loading.",
   Content = "https://www.youtube.com/@materialsnotfound",
   Duration = 5.0,
   Image = "check",
})

local Tab = Window:CreateTab("Admin", "shield")
local Button = Tab:CreateButton({
   Name = "Infinite Yield by Edge, Moon and Toon",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Infinite%20Yield.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Nameless Admin by ltseverydayyou and Cosmella",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Nameless%20Admin.lua"))()
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
	Name = "99 Nights in the Forest",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/99%20Nights%20in%20the%20Forest.lua"))()
	Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
	Name = "Jujutsu Shenanigans",
	Callback = function()
	Rayfield:Notify({
   Title = "Warning",
   Content = "I recommend using an antivirus with this script.",
   Duration = 2.5,
   Image = "check",
   })
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Jujutsu%20Shenanigans.lua"))()
	Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
	Name = "Escape Tsunami For Brainrots!",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Escape%20Tsunami%20For%20Brainrots.lua"))()
	Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
	Name = "Poop a Big Poop",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Poop%20a%20Big%20Poop.lua"))()
	Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
	Name = "Blox Fruits",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Blox%20Fruits.lua"))()
	Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "3008",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/3008.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Murder Mystery 2",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Murder%20Mystery%202.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Jailbreak by Synx898",
   Callback = function()
   loadstring(game:HttpGet("https://api.nexar.to/scripts/v1/qyjhN8rbwq-qvDqFTMXd_hyn-P2kHzDo.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Sell Lemons by Iamduck2005",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Sell%20Lemons.luau"))()
   Rayfield:Destroy()
   end
})

local Tab = Window:CreateTab("Backdoors", "door-open")
local Button = Tab:CreateButton({
   Name = "LALOL Hub",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/LALOL%20Hub%20Backdoor.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Moon Executor by MoonVM",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The key has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("MoonVMKey-LCnuW60s5iSK4VqkR9")
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Moon%20Backdoor.lua"))() 
   end
})

local Tab = Window:CreateTab("Serverside", "server")
local Button = Tab:CreateButton({
	Name = "LucyAnna by Auxnos",
	Callback = function()
	Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
	setclipboard("require(13321304140)('Your Username')")
	end
})

local Button = Tab:CreateButton({
	Name = "Incendiary",
	Callback = function()
	Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(12591735195):INCENDIARY('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Fredbear 2.0 by Protofer_S",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(13761549843).pedobear('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "CR Meme Antideath",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(12599435703)('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Purple Guy by Memerman",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(14057425072)('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Minos Prime",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(13770496456)('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Demogorgon V2",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(90079465185110).load('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Morph GUI",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = 'Type in "VOID" and press confirm.',
    Duration = 5.0,
    Image = "check",
   })
   setclipboard("require(124675875890869).load('Your Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Secret Service Panel",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 2.5,
    Image = "check",
   })
   setclipboard("require(16920033857)('Your Username')")
   end
})

local Tab = Window:CreateTab("FE", "earth")
local Button = Tab:CreateButton({
   Name = "AnnaBypasser",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/AnnaBypasser.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Fast Animation",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Fast%20Animation.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Dex Explorer by Fusion",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Dex%20Explorer.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Demogorgon (R15)",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/FE%20Demogorgon.lua"))()
   end
})

local Button = Tab:CreateButton({
	Name = "UNC Test",
	Callback = function()
	print("Initialised UNC Test by materials not found.")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/UNC%20Test.lua"))()
	end
})

local Button = Tab:CreateButton({
	Name = "Ultimate Fling GUI by KILASIK",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Ultimate%20Fling%20GUI.lua"))()
	end
})

local Input = Tab:CreateInput({
	Name = "Lag (FPS Limiter)",
	CurrentValue = "",
	PlaceholderText = "Input",
	RemoveTextAfterFocusLost = false,
	Flag = "FPS",
	Callback = function(Text)
	setfpscap(Text)
	end
})

local Input = Tab:CreateInput({
	Name = "Speed",
	CurrentValue = "",
	PlaceholderText = "Input",
	RemoveTextAfterFocusLost = false,
	Flag = "Speed",
	Callback = function(Text)
	local Speed = tonumber(Text)
	if not Speed then return end
	Humanoid.WalkSpeed = Speed
	LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	end)
	end
})

local Button = Tab:CreateButton({
   Name = "Simplified Desync by ldplay1163",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Simplified%20Desync.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Server Finder Deluxe by maxproglitcher (great person)",
   Callback = function()
   Rayfield:Notify({
   Title = "Written by maxproglitcher.",
   Content = "This script was written by maxproglitcher, he's a great guy. Check out his GitHub - https://github.com/MaxproGlitcher/Server-Finder-Deluxe",
   Duration = 10.0,
   Image = "star",
   })
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Server%20Finder%20Deluxe.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Product Purchase Faker by esore",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Product%20******.lua"))()
   end
})

local Button = Tab:CreateButton({
	Name = "SimpleSpy V3 by 78n",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/SimpleSpy.lua"))()
	end
})
