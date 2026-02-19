-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- PLAYER
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- STATS BASE
humanoid.JumpPower = 75
humanoid.WalkSpeed = 14

-- DESATIVA ANIMATE PADRÃO
local animate = character:FindFirstChild("Animate")
if animate then
	animate.Disabled = true
end

-- ANIMATION IDS
local IDLE_ID = "rbxassetid://115485274167727"
local WALK_ID = "rbxassetid://113076603308515"
local RUN_ID  = "rbxassetid://87721497492370"
local JUMP_ANIM_ID = "rbxassetid://107050614591332"

-- SOUND IDS
local LOOP_SOUND_ID = "rbxassetid://130501290862644"
local JUMP_SOUND_ID = "rbxassetid://78316558643437"

-- CAMERA BASE
camera.FieldOfView = 70
TweenService:Create(camera, TweenInfo.new(2), {FieldOfView = 85}):Play()

-- MUSIC LOOP
local loopSound = Instance.new("Sound", camera)
loopSound.SoundId = LOOP_SOUND_ID
loopSound.Volume = 1.5
loopSound.Looped = true
loopSound:Play()

-- ANIMATOR
local animator = humanoid:WaitForChild("Animator")

local function loadAnim(id)
	local anim = Instance.new("Animation")
	anim.AnimationId = id
	return animator:LoadAnimation(anim)
end

local idleAnim = loadAnim(IDLE_ID)
local walkAnim = loadAnim(WALK_ID)
local runAnim  = loadAnim(RUN_ID)
local jumpAnim = loadAnim(JUMP_ANIM_ID)

runAnim.Priority = Enum.AnimationPriority.Movement
runAnim:AdjustSpeed(2)

idleAnim:Play()

-- CONTROLE DE ANIMAÇÃO
RunService.RenderStepped:Connect(function()
	if humanoid.MoveDirection.Magnitude == 0 then
		if not idleAnim.IsPlaying then
			walkAnim:Stop()
			runAnim:Stop()
			idleAnim:Play()
		end
	else
		if humanoid.WalkSpeed >= 40 then
			idleAnim:Stop()
			walkAnim:Stop()
			if not runAnim.IsPlaying then runAnim:Play() end
		else
			idleAnim:Stop()
			runAnim:Stop()
			if not walkAnim.IsPlaying then walkAnim:Play() end
		end
	end
end)

-- TOOL CRIADOR
local function createTool(name)
	local tool = Instance.new("Tool")
	tool.Name = name
	tool.RequiresHandle = false
	tool.Parent = player.Backpack
	return tool
end

-- RAGE MODE TOOL
local rageTool = createTool("RAGE MODE")
local raging = false

rageTool.Activated:Connect(function()
	raging = not raging

	if raging then
		humanoid.WalkSpeed = 50
		TweenService:Create(camera, TweenInfo.new(0.6), {FieldOfView = 120}):Play()
	else
		humanoid.WalkSpeed = 14
		TweenService:Create(camera, TweenInfo.new(0.6), {FieldOfView = 85}):Play()
	end
end)

-- JUMP TOOL
local jumpTool = createTool("JUMP")
local mouse = player:GetMouse()
local busy = false

jumpTool.Activated:Connect(function()
	if busy then return end
	local target = mouse.Target
	if not target then return end

	local targetChar = target:FindFirstAncestorOfClass("Model")
	if not targetChar then return end

	local targetHum = targetChar:FindFirstChild("Humanoid")
	local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
	if not targetHum or not targetRoot then return end

	busy = true

	-- salva posição original
	local originalCFrame = root.CFrame

	-- calcula posição na frente do player alvo
	local frontPos = targetRoot.CFrame * CFrame.new(0, 0, -2.5)

	-- teleportar
	root.CFrame = CFrame.new(frontPos.Position, targetRoot.Position)

	-- tocar animação
	jumpAnim:Play()

	-- som
	local s = Instance.new("Sound", camera)
	s.SoundId = JUMP_SOUND_ID
	s.Volume = 6
	s.Looped = false
	s:Play()
	Debris:AddItem(s, 3)

	-- espera 0.55s
	task.wait(0.55)

	-- voltar
	root.CFrame = originalCFrame

	busy = false
end)

-- RESET
humanoid.Died:Connect(function()
	if loopSound then loopSound:Destroy() end
end)
