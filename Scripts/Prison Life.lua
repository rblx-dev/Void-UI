if game.PlaceId == 155615604 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Attrixx/Scandia/main/KavoUiLib.lua"))()
    local Window = Library.CreateLib("Scandia Hub - Prison Life", "Ocean")
    local Main = Window:NewTab("Main")
    local Player = Window:NewTab("Player")

    -- Main
    local MainSection = Main:NewSection("Main")
    MainSection:NewDropdown("Give Gun", "Gives LocalPlayer a Gun", {"M9", "M4A1", "AK-47", "Remington 870"}, function(currentOption)

        local give = game:GetService("Workspace")["Prison_ITEMS"].giver[currentOption].ITEMPICKUP

        local Event = game:GetService("Workspace").Remote.ItemHandler
        Event:InvokeServer(give)

    end)

    MainSection:NewDropdown("Gun Mod", "Makes the gun OP", {"M9", "M4A1", "AK-47", "Remington 870"}, function(currentOption)
        local module = nil
        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(currentOption) then

            module = game:GetService("Players").LocalPlayer.Backpack[currentOption].GunStates
        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(currentOption) then

            module = require(game:GetService("Players").LocalPlayer.Character[currentOption].GunStates)
        end

        if module ~= nil then
            module["MaxAmmo"] = math.huge
            module["CurrentAmmo"] = math.huge
            module["StoredAmmo"] = math.huge
            module["FireRate"] = 0.0000001
            module["Spread"] = 0
            module["ReloadTime"] = 0
            module["Bullets"] = 10
            module["Range"] = math.huge
            module["Damage"] = math.huge
        end

    end)
    

    -- PLAYER

    local SectionPlayer = Player:NewSection("Player")

    SectionPlayer:NewSlider("WalkSpeed", "Changes Player WalkSpeed", 500, 16, function(v) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)

    SectionPlayer:NewSlider("JumpPower", "Changes Player JumpPower", 500, 50, function(v) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end)

    end
