local VoiceChatService = game:GetService("VoiceChatService")
local player = game:GetService("Players").LocalPlayer

local function tryJoinVoice()
    local success = pcall(function()
        VoiceChatService:JoinVoice()
    end)
    if not success then
        task.spawn(tryJoinVoice)
    end
end

tryJoinVoice()
