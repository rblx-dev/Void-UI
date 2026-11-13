local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Attendre que les ressources soient prêtes (PC parfois plus lent)
local Resources = workspace:WaitForChild("Resources", 30)
if not Resources then
    warn("❌ Resources introuvable")
    return
end
local ScreenRE = Resources:WaitForChild("ScreenRE", 30)
if not ScreenRE then
    warn("❌ ScreenRE introuvable")
    return
end

-- Attendre que les remotes existent (PC souvent en retard)
local Events = RS:WaitForChild("Events", 30)
local DataFolder = Events and Events:WaitForChild("Data", 30)
local BuyShopGoodsRE = DataFolder and DataFolder:WaitForChild("BuyShopGoodsRE", 30)
local BuyLicenseRE = DataFolder and DataFolder:WaitForChild("BuyLicenseRE", 30)
local GoodsFolder = Events and Events:WaitForChild("Goods", 30)
local GamePassRE = GoodsFolder and GoodsFolder:WaitForChild("GamePassRE", 30)
local BuildingFolder = Events and Events:WaitForChild("Building", 30)
local PlacementRE = BuildingFolder and BuildingFolder:WaitForChild("PlacementRE", 30)

--================ GAME FUNCTIONS ================

local function buyItem(itemName, quant)
    if not BuyShopGoodsRE then return end
    pcall(function()
        BuyShopGoodsRE:FireServer({[itemName] = quant})
    end)
end

local function giveCash(amount)
    if not BuyLicenseRE then return end
    pcall(function()
        BuyLicenseRE:FireServer({
            HideId = "rbxassetid://134513576519333",
            Name = "License_1",
            Price = -amount,
            Action = "BuyLicense",
            PlayerLv = 100,
            ImgId = "rbxassetid://79881044317587"
        }, "BuyLicense")
    end)
end

local function toggleGP(name, target)
    if not GamePassRE then return end
    pcall(function()
        GamePassRE:FireServer(name, target)
    end)
end

local function sellBoxes(itemType)
    if not PlacementRE then return end
    local realType = itemType == "Sell Furniture Box" and "SellShelves" or "SellBox"
    for _, i in ipairs(workspace.Resources.Product:GetChildren()) do
        if realType == "SellBox" and (i:GetAttribute("ShelvesType") == "Shelves" or i:GetAttribute("Decorations")) then continue end
        if realType == "SellShelves" and i:GetAttribute("ShelvesType") == "Shelf" then continue end
        pcall(function()
            ScreenRE:FireServer("TakeBox", i)
            task.wait(0.05)
            PlacementRE:FireServer(realType, i)
        end)
        task.wait(0.05)
    end
end

local function sellHeld()
    if not PlacementRE then return end
    for _, i in ipairs(workspace.Resources.Carried:GetChildren()) do
        pcall(function()
            PlacementRE:FireServer("SellBox", i)
        end)
        task.wait(0.05)
    end
end

--================ STATES ================
local AutoStock = false
local AutoBuy = false
local buyDebounce = false
local loopTask = nil

--================ PRODUCT DETECTION ================
local function getAllProductNames()
    local products = {}
    for _, shelf in pairs(workspace.Resources.Building:GetChildren()) do
        if shelf:GetAttribute("BuildingType") == "Shelves" then
            local detectors = shelf:FindFirstChild("DetectorFolder")
            if detectors then
                for _, detector in pairs(detectors:GetChildren()) do
                    local name = detector:GetAttribute("ProductName")
                    if name then products[name] = true end
                end
            end
        end
    end
    return products
end

--================ MAIN LOOP ================
local function startLoop()
    if loopTask then task.cancel(loopTask); loopTask = nil end

    loopTask = task.spawn(function()
        while true do
            task.wait(0.3)
            if not AutoStock and not AutoBuy then continue end

            local allProducts = getAllProductNames()

            local stockCount = {}
            for _, box in pairs(workspace.Resources.Product:GetChildren()) do
                local name = box.Name:gsub("Box$", "")
                stockCount[name] = (stockCount[name] or 0) + 1
            end

            for productName in pairs(allProducts) do
                local totalShelves = 0
                local emptyShelves = {}

                for _, shelf in pairs(workspace.Resources.Building:GetChildren()) do
                    if shelf:GetAttribute("BuildingType") == "Shelves" then
                        local detectors = shelf:FindFirstChild("DetectorFolder")
                        if detectors then
                            for _, detector in pairs(detectors:GetChildren()) do
                                if detector:GetAttribute("ProductName") == productName then
                                    local count = 0
                                    for _, item in pairs(detector:GetChildren()) do
                                        if item:IsA("BasePart") then count = count + 1 end
                                    end
                                    totalShelves = totalShelves + 1
                                    if count == 0 then
                                        table.insert(emptyShelves, {detector = detector, shelf = shelf})
                                    end
                                end
                            end
                        end
                    end
                end

                if AutoStock then
                    for _, entry in pairs(emptyShelves) do
                        local inStock = nil
                        for _, box in pairs(workspace.Resources.Product:GetChildren()) do
                            if box.Name == productName .. "Box" or box.Name == productName then
                                inStock = box
                                break
                            end
                        end
                        if inStock then
                            pcall(function()
                                ScreenRE:FireServer("PutProduct", inStock, entry.detector, entry.shelf)
                            end)
                            task.wait(0.1)
                        end
                    end
                end

                if AutoBuy and #emptyShelves >= totalShelves and (stockCount[productName] or 0) == 0 then
                    if not buyDebounce then
                        buyDebounce = true
                        buyItem(productName, math.max(1, totalShelves))
                        task.wait(0.6)
                        buyDebounce = false
                    end
                end
            end
        end
    end)
end

--================ GUI (PC + MOBILE) ================
-- Attendre PlayerGui (PC plus lent)
local PlayerGui = player:WaitForChild("PlayerGui", 30)
if not PlayerGui then
    warn("❌ PlayerGui introuvable")
    return
end

-- Supprimer l'ancien GUI si présent (utile si re-exec)
local oldGui = PlayerGui:FindFirstChild("SB_HUB")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "SB_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true              -- IMPORTANT PC : permet d'utiliser toute la zone
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = PlayerGui

-- Bouton flottant (compatible PC : bien visible + déplaçable)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 110, 0, 36)
openBtn.Position = UDim2.new(0, 20, 0.5, -18)
openBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
openBtn.Text = "SB HUB"
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 14
openBtn.Active = true
openBtn.Draggable = true
openBtn.AutoButtonColor = true
openBtn.Selectable = true              -- IMPORTANT PC : focus clavier possible
openBtn.ZIndex = 10
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = Color3.fromRGB(180,130,255)
openStroke.Thickness = 2

-- Fenêtre principale (adaptée PC : plus compacte, mieux centrée)
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 340)
main.Position = UDim2.new(0.5, -130, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
main.Active = true
main.Draggable = true
main.Visible = false
main.ZIndex = 5
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(120, 70, 220)
mainStroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 32)
title.BackgroundColor3 = Color3.fromRGB(40, 25, 65)
title.Text = "SB HUB  •  by abd_nish"
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(200, 160, 255)
title.ZIndex = 6
title.Parent = main
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -30, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.ZIndex = 7
closeBtn.Parent = main
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -8, 1, -40)
scroll.Position = UDim2.new(0, 4, 0, 36)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 5
scroll.ScrollBarImageColor3 = Color3.fromRGB(120, 70, 220)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ElasticBehavior = Enum.ElasticBehavior.Never  -- PC : scroll plus précis
scroll.ZIndex = 6
scroll.Parent = main

--================ HELPERS UI ================
local function makeSection(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Position = UDim2.new(0, 4, 0, y)
    lbl.Size = UDim2.new(1, -8, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = "— " .. text .. " —"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextColor3 = Color3.fromRGB(180, 140, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
end

local function makeToggle(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(80, 55, 130)
    btn.Text = text .. " : OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.new(1,1,1)
    btn.AutoButtonColor = true
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(140, 100, 220)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " : ON" or " : OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(90, 160, 100) or Color3.fromRGB(80, 55, 130)
        callback(state)
    end)
end

local function makeButton(text, y, callback, color)
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.BackgroundColor3 = color or Color3.fromRGB(90, 70, 160)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.new(1,1,1)
    btn.AutoButtonColor = true
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

--================ BUILD UI ================
makeSection("Auto Farm", 4)
makeToggle("Auto Stock", 24, function(v) AutoStock = v; startLoop() end)
makeToggle("Auto Buy", 56, function(v) AutoBuy = v; startLoop() end)

makeSection("Money", 94)

local cashFrame = Instance.new("Frame")
cashFrame.Position = UDim2.new(0, 4, 0, 114)
cashFrame.Size = UDim2.new(1, -8, 0, 28)
cashFrame.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
cashFrame.Parent = scroll
Instance.new("UICorner", cashFrame).CornerRadius = UDim.new(0, 6)

local cashBox = Instance.new("TextBox")
cashBox.Size = UDim2.new(0.55, -5, 1, 0)
cashBox.Position = UDim2.new(0, 6, 0, 0)
cashBox.BackgroundTransparency = 1
cashBox.Text = "1000"
cashBox.PlaceholderText = "Amount"
cashBox.Font = Enum.Font.Gotham
cashBox.TextSize = 11
cashBox.TextColor3 = Color3.new(1,1,1)
cashBox.TextXAlignment = Enum.TextXAlignment.Left
cashBox.ClearTextOnFocus = false
cashBox.Parent = cashFrame

local cashBtn = Instance.new("TextButton")
cashBtn.Size = UDim2.new(0.45, -10, 1, 0)
cashBtn.Position = UDim2.new(0.55, 0, 0, 0)
cashBtn.BackgroundColor3 = Color3.fromRGB(90, 160, 100)
cashBtn.Text = "Give Cash"
cashBtn.Font = Enum.Font.GothamBold
cashBtn.TextSize = 11
cashBtn.TextColor3 = Color3.new(1,1,1)
cashBtn.AutoButtonColor = true
cashBtn.Parent = cashFrame
Instance.new("UICorner", cashBtn).CornerRadius = UDim.new(0, 6)
cashBtn.MouseButton1Click:Connect(function()
    local amount = tonumber(cashBox.Text)
    if amount then giveCash(amount) end
end)

makeSection("Sell", 150)
makeButton("Sell All Boxes", 170, function() sellBoxes("Sell Product Box") end)
makeButton("Sell Held Items", 202, function() sellHeld() end)

makeSection("Gamepass", 240)

local gpHolder = Instance.new("Frame")
gpHolder.Position = UDim2.new(0, 4, 0, 260)
gpHolder.Size = UDim2.new(1, -8, 0, 28)
gpHolder.BackgroundTransparency = 1
gpHolder.Parent = scroll

local gpNames = {"Cashier", "Porter", "Warehouseman"}
local gpLabels = {"Cashier", "Porter", "Warehouse"}
for i, realName in ipairs(gpNames) do
    local gpBtn = Instance.new("TextButton")
    gpBtn.Size = UDim2.new(0.33, -3, 1, 0)
    gpBtn.Position = UDim2.new((i-1) * 0.335, 0, 0, 0)
    gpBtn.BackgroundColor3 = Color3.fromRGB(80, 55, 130)
    gpBtn.Text = gpLabels[i]
    gpBtn.Font = Enum.Font.GothamBold
    gpBtn.TextSize = 10
    gpBtn.TextColor3 = Color3.new(1,1,1)
    gpBtn.AutoButtonColor = true
    gpBtn.Parent = gpHolder
    Instance.new("UICorner", gpBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", gpBtn).Color = Color3.fromRGB(140, 100, 220)

    local gpState = false
    gpBtn.MouseButton1Click:Connect(function()
        gpState = not gpState
        toggleGP(realName, gpState)
        gpBtn.BackgroundColor3 = gpState and Color3.fromRGB(90, 160, 100) or Color3.fromRGB(80, 55, 130)
    end)
end

makeSection("Info", 296)

local infoLabel = Instance.new("TextLabel")
infoLabel.Position = UDim2.new(0, 4, 0, 316)
infoLabel.Size = UDim2.new(1, -8, 0, 40)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "SB HUB v2.4 • by abd_nish\nDiscord: discord.gg/7TmuabkqZ8"
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 10
infoLabel.TextColor3 = Color3.fromRGB(180, 160, 220)
infoLabel.TextWrapped = true
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = scroll

--================ OPEN/CLOSE ================
openBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Raccourci clavier PC : "H" pour ouvrir/fermer
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.H then
        main.Visible = not main.Visible
    end
end)

print("✅ SB HUB v2.4 loaded | by abd_nish")
print("🖥️ Compatible PC + Mobile")
print("⌨️ Appuie sur H pour ouvrir/fermer le menu")
print("💬 Discord: https://discord.gg/7TmuabkqZ8")
