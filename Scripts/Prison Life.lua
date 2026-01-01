-- Instances:

local PrizzXComingSoon = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local ComingSoon = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local join = Instance.new("TextLabel")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local JoinDiscord = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local Close = Instance.new("TextButton")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")

--Properties:

PrizzXComingSoon.Name = "PrizzXComingSoon"
PrizzXComingSoon.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PrizzXComingSoon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = PrizzXComingSoon
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.52011776, 0, 0.365998715, 0)
MainFrame.Size = UDim2.new(0.380274773, 0, 0.280230969, 0)

Title.Name = "Title"
Title.Parent = MainFrame
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.5, 0, 0.0662983432, 0)
Title.Size = UDim2.new(1, 0, 0.145454556, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "PrizzX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UITextSizeConstraint.Parent = Title
UITextSizeConstraint.MaxTextSize = 24

ComingSoon.Name = "ComingSoon"
ComingSoon.Parent = MainFrame
ComingSoon.AnchorPoint = Vector2.new(0.5, 0.5)
ComingSoon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ComingSoon.BorderColor3 = Color3.fromRGB(0, 0, 0)
ComingSoon.BorderSizePixel = 0
ComingSoon.Position = UDim2.new(0.5, 0, 0.259668499, 0)
ComingSoon.Size = UDim2.new(1, 0, 0.145454556, 0)
ComingSoon.Font = Enum.Font.SourceSans
ComingSoon.Text = "Coming Soon!"
ComingSoon.TextColor3 = Color3.fromRGB(255, 255, 255)
ComingSoon.TextScaled = true
ComingSoon.TextSize = 14.000
ComingSoon.TextWrapped = true

UITextSizeConstraint_2.Parent = ComingSoon
UITextSizeConstraint_2.MaxTextSize = 24

join.Name = "join"
join.Parent = MainFrame
join.AnchorPoint = Vector2.new(0.5, 0.5)
join.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
join.BackgroundTransparency = 1.000
join.BorderColor3 = Color3.fromRGB(0, 0, 0)
join.BorderSizePixel = 0
join.Position = UDim2.new(0.498387098, 0, 0.497237563, 0)
join.Size = UDim2.new(0.803225815, 0, 0.303030342, 0)
join.Font = Enum.Font.SourceSans
join.Text = "Join the Discord for updates!"
join.TextColor3 = Color3.fromRGB(255, 255, 255)
join.TextScaled = true
join.TextSize = 14.000
join.TextWrapped = true

UITextSizeConstraint_3.Parent = join
UITextSizeConstraint_3.MaxTextSize = 25

JoinDiscord.Name = "JoinDiscord"
JoinDiscord.Parent = MainFrame
JoinDiscord.AnchorPoint = Vector2.new(0.5, 0.5)
JoinDiscord.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
JoinDiscord.BorderColor3 = Color3.fromRGB(0, 0, 0)
JoinDiscord.BorderSizePixel = 0
JoinDiscord.Position = UDim2.new(0.498387098, 0, 0.754143655, 0)
JoinDiscord.Size = UDim2.new(0.345161289, 0, 0.26060608, 0)
JoinDiscord.Font = Enum.Font.SourceSans
JoinDiscord.Text = "JOIN"
JoinDiscord.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinDiscord.TextScaled = true
JoinDiscord.TextSize = 14.000
JoinDiscord.TextWrapped = true

UICorner.Parent = JoinDiscord

UITextSizeConstraint_4.Parent = JoinDiscord
UITextSizeConstraint_4.MaxTextSize = 42

UIAspectRatioConstraint.Parent = JoinDiscord
UIAspectRatioConstraint.AspectRatio = 2.488

Close.Name = "Close"
Close.Parent = MainFrame
Close.AnchorPoint = Vector2.new(0.5, 0.5)
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.962903202, 0, 0.0573916361, 0)
Close.Size = UDim2.new(0.0741935447, 0, 0.157575771, 0)
Close.Font = Enum.Font.SourceSansBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true

UITextSizeConstraint_5.Parent = Close
UITextSizeConstraint_5.MaxTextSize = 25

UIAspectRatioConstraint_2.Parent = MainFrame
UIAspectRatioConstraint_2.AspectRatio = 1.879

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
httprequest =  missing("function", request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request))
everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
Services = setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		else
			error("Invalid Roblox Service: " .. tostring(name))
		end
	end
})
HttpService = Services.HttpService

function toClipboard(txt)
	if everyClipboard then
		everyClipboard(tostring(txt))
		JoinDiscord.Text = "COPIED"
	else
		JoinDiscord.Text("FAILED TO COPY")
	end
end

Close.MouseButton1Click:Connect(function()
	PrizzXComingSoon:Destroy()
end)

JoinDiscord.MouseButton1Click:Connect(function()
	print("JOINING DISCORD")
	if everyClipboard then
		toClipboard('https://discord.gg/v8StrgCuZz')
		JoinDiscord.Text = "COPIED"
	else
		join.Text = 'discord.gg/v8StrgCuZz'
	end
	if httprequest then
		httprequest({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = HttpService:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = HttpService:GenerateGUID(false),
				args = {code = 'v8StrgCuZz’)
			})
		})
	end
end)
