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

-- All the variables I could think of

local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local Env = getgenv()
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ExperienceService = game:GetService("ExperienceService")
local Executor = identifyexecutor
local StarterGui = game:GetService("StarterGui")
local Info = game:getinfo()
local StreamingEnabled = game:GetService("Workspace").StreamingEnabled
local FilteringEnabled = game:GetService("Workspace").FilteringEnabled
local Lighting = game:GetService("Lighting")

-- The actual script begins here

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
   Name = "Void UI (discord.gg/sztWpgX7qp)",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Void UI",
   LoadingSubTitle = "by @MNF_YouTube",
   ShowText = "UI", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "X", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Void UI"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "sztWpgX7qp", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = false -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})

Rayfield:Notify({
   Title = "Void UI - Loaded",
   Content = "Scripted by @MNF_YouTube",
   Duration = 10.0,
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
   Name = "Nameless Admin by Itseverydayyou",
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
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/The%20Strongest%20Battlegrounds.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Slap Tower",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Slap%20Tower.lua"))()
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
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/99%20nights%20in%20the%20Forest.lua"))()
	Rayfield:Destroy()
	end
})

local Button = Tab:CreateButton({
	Name = "Jujutsu Shenanigans",
	Callback = function()
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
	Name = "Blox Fruits by AhmadV99",
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
   loadstring(game:HttpGet("https://api.nexar.to/scripts/v1/qyjhn8rbwq-qvDqFTMXd_hyn-P2kHzDo.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Sell Lemons by vaehz",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Sell%20Lemons.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "Search For The Needle",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Search%20For%20The%20Needle.lua"))()
   Rayfield:Destroy()
   end
})

local Button = Tab:CreateButton({
   Name = "+1 Money Per Click by @MNF_YouTube",
   Callback = function()
      while true do
         local Event = game:GetService("ReplicatedStorage").Remotes.ClickToEarn
         Event:FireServer()
         task.wait(0.1)
         end
   end
})

local Button = Tab:CreateButton({
   Name = "Throw Food For Animals by @MNF_YouTube",
   Callback = function()
      StarterGui:SetCore("SendNotification", {
         Title = "Started",
         Text = "Walk to the throw area, your avatar should go invisible.",
         Duration = 5
     })
     while true do
     local Event = game:GetService("ReplicatedStorage").Remotes.Throw_Start
     Event:InvokeServer()
     task.wait(0.1)
     local Event = game:GetService("ReplicatedStorage").Remotes.Throw_Resolve
     Event:InvokeServer(
         0.99999999999999999
     )
     end
   end
})
   
local Tab = Window:CreateTab("Backdoor Scanner", "door-open")

local Button = Tab:CreateButton({
   Name = "LALOL Hub",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/LALOL%20Hub%20Backdoor.lua"))()
   end
})

local Tab = Window:CreateTab("Serverside", "server")

local Button = Tab:CreateButton({
	Name = "LucyAnna by Auxnos",
	Callback = function()
	Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
	setclipboard("require(13321304140)('Username')")
	end
})

local Button = Tab:CreateButton({
	Name = "Incendiary",
	Callback = function()
	Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(12591735195):INCENDIARY('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Fredbear 2.0 by Protofer_S",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(13761549843).pedobear('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "CR Meme Antideath",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(12599435703)('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Purple Guy by Memerman",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(14057425072)('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Minos Prime",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(13770496456)('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Demogorgon",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard('require(88346668038204).load("Username")')
   end
})

local Button = Tab:CreateButton({
   Name = "Morph GUI",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = 'Type in "VOID" and press confirm.',
    Duration = 5.0,
    
   })
   setclipboard("require(124675875890869).load('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Secret Service Panel",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard("require(16920033857)('Username')")
   end
})

local Button = Tab:CreateButton({
   Name = "Goner",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,

   })
   setclipboard('require(4513235536).G("Username")')
   end
})

local Button = Tab:CreateButton({
   Name = "Server Admin",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard('require(4665394711).load("Username")')
   end
})

local Button = Tab:CreateButton({
   Name = "Withered Bon",
   Callback = function()
   Rayfield:Notify({
    Title = "Copied to clipboard.",
    Content = "The script has been copied to your clipboard.",
    Duration = 5,
    
   })
   setclipboard('require(124214879453599):Bon("Username")')
   end
})

local Tab = Window:CreateTab("FE", "earth")

local Button = Tab:CreateButton({
   Name = "Fast Animation",
   Callback = function()
   while wait() do
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Fast%20Animation.lua"))()
   end
   end
})

local Button = Tab:CreateButton({
   Name = "Dex Explorer by Fusion",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Dex%20Explorer.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Cobalt by upio",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Cobalt.lua"))()
   end
})

local Button = Tab:CreateButton({
	Name = "SimpleSpy V3 by 78n",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/SimpleSpy.lua"))()
	end
})

local Button = Tab:CreateButton({
   Name = "Brainrot Police by vaehz",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Brainrot%20Police.lua"))()
   end
})

local Button = Tab:CreateButton({
	Name = "Myriad Test by Standard2",
	Callback = function()
   loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Myriad.lua"))()
	end
})

local Button = Tab:CreateButton({
   Name = "sUNC Test by senS",
   Callback = function()
      getgenv().sUNCDebug = {
         ["printcheckpoints"] = false,
         ["delaybetweentests"] = 0,
         ["printtesttimetaken"] = false,
     }
     
     loadstring(game:HttpGet("https://script.sunc.io/"))()
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
   PlaceholderText = "60",
	Callback = function(Text)
	setfpscap(Text)
	end
})

local Input = Tab:CreateInput({
	Name = "Speed",
   CurrentValue = "",
   PlaceholderText = "16",
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
   Name = "Server Finder Deluxe",
   Callback = function()
   Rayfield:Notify({
   Title = "Written by maxproglitcher.",
   Content = "This script was written by maxproglitcher, he's a great guy. Check out his GitHub - https://github.com/MaxproGlitcher/Server-Finder-Deluxe",
   Duration = 5,
   })
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Server%20Finder%20Deluxe.lua"))()
   end
})

local Button = Tab:CreateButton({
   Name = "Product Faker V2 by vaehz",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rblx-dev/Void-UI/main/Scripts/Product%20Faker%20V2.lua"))()
   end
})

local Input = Tab:CreateInput({
    Name = "Teleport To",
    CurrentValue = "",
    PlaceholderText = "Player",
    RemoveTextAfterFocusLost = true,
    Flag = "Teleport",
    Callback = function(Text)
      if Text == "" then return end
   
      local target
      for _, player in ipairs(Players:GetPlayers()) do
         if player.Name:lower():sub(1, #Text) == Text:lower() then
            target = player
            break
         end
      end
   
      local myCharacter = LocalPlayer.Character
      local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
   
      if target then
         local targetCharacter = target.Character
         local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
   
         if targetRoot and myRoot then
            myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
         end
      end
   end
})
