local __NA_SPLIT_SOURCE_TAG = "Source.lua"
local __NA_SPLIT_CONFIG = {
	testing = false;
	sourceTag = __NA_SPLIT_SOURCE_TAG;
}

local __NARootResolver

--!nonstrict
-- © 2026 Nameless Admin. All rights reserved. Do not copy, paste, redistribute, or claim as your own.

local __NARootHost = (getgenv and getgenv()) or _G or {}
local __naPrev = type(__NARootHost) == "table" and rawget(__NARootHost, "_na_boot") or nil
if type(__naPrev) == "table" and rawget(__naPrev, "runtimeEnv") == __NARootHost and type(rawget(__naPrev, "hostEnv")) == "table" then
	__NARootHost = __naPrev.hostEnv
end
local __NARootPreviousNACaller = type(__NARootHost) == "table" and rawget(__NARootHost, "NACaller") or nil
local __NARootErrorState = type(__NARootHost) == "table" and rawget(__NARootHost, "__NAErrorLogState") or nil
if type(__NARootErrorState) ~= "table" then
	__NARootErrorState = { lastIndex = 0; rootCount = 0 }
	if type(__NARootHost) == "table" then
		pcall(rawset, __NARootHost, "__NAErrorLogState", __NARootErrorState)
	end
end

local function __NARootExecutorInfo()
	local name = "Unknown"
	local versionValue = "Unknown"
	if type(identifyexecutor) == "function" then
		local ok, a, b = pcall(identifyexecutor)
		if ok then
			if a ~= nil and tostring(a) ~= "" then name = tostring(a) end
			if b ~= nil and tostring(b) ~= "" then versionValue = tostring(b) end
		end
	end
	if name == "Unknown" and type(getexecutorname) == "function" then
		local ok, value = pcall(getexecutorname)
		if ok and value ~= nil and tostring(value) ~= "" then name = tostring(value) end
	end
	if versionValue == "Unknown" and type(getexecutorversion) == "function" then
		local ok, value = pcall(getexecutorversion)
		if ok and value ~= nil and tostring(value) ~= "" then versionValue = tostring(value) end
	end
	return name, versionValue
end

local function __NARootDebugInfo(fn)
	local source = "Unknown"
	local line = 0
	local name = "anonymous"
	if type(debug) == "table" and type(debug.info) == "function" and type(fn) == "function" then
		pcall(function()
			local s, l, n = debug.info(fn, "sln")
			if s ~= nil and tostring(s) ~= "" then source = tostring(s) end
			if tonumber(l) then line = tonumber(l) end
			if n ~= nil and tostring(n) ~= "" then name = tostring(n) end
		end)
	end
	return source, line, name
end

local function __NARootNextErrorPath()
	local root = "Nameless-Admin"
	local dir = root.."/ErrorLogs"
	local maxIndex = tonumber(__NARootErrorState.lastIndex) or 0
	if type(makefolder) == "function" then
		pcall(function()
			if type(isfolder) ~= "function" or not isfolder(root) then makefolder(root) end
		end)
		pcall(function()
			if type(isfolder) ~= "function" or not isfolder(dir) then makefolder(dir) end
		end)
	end
	if type(listfiles) == "function" then
		local ok, entries = pcall(listfiles, dir)
		if ok and type(entries) == "table" then
			for _, entry in entries do
				local normalized = tostring(entry):gsub("\\", "/")
				local index = tonumber(normalized:match("NA_Error#(%d+)%.txt$"))
				if index and index > maxIndex then maxIndex = index end
			end
		end
	end
	local nextIndex = maxIndex + 1
	local path = dir.."/NA_Error#"..tostring(nextIndex)..".txt"
	if type(isfile) == "function" then
		while isfile(path) do
			nextIndex += 1
			path = dir.."/NA_Error#"..tostring(nextIndex)..".txt"
		end
	end
	__NARootErrorState.lastIndex = nextIndex
	return path, nextIndex
end

local function __NARootReportError(rawError, tracebackText, context, fn, options)
	options = type(options) == "table" and options or {}
	__NARootErrorState.rootCount = (tonumber(__NARootErrorState.rootCount) or 0) + 1
	local logPath, fileIndex = __NARootNextErrorPath()
	local execName, execVersion = __NARootExecutorInfo()
	local fnSource, fnLine, fnName = __NARootDebugInfo(fn)
	local clientVersion = "Unknown"
	if type(version) == "function" then
		local ok, value = pcall(version)
		if ok and value ~= nil and tostring(value) ~= "" then clientVersion = tostring(value) end
	end
	local timestamp = tostring(os.time and os.time() or "Unknown")
	if type(os.date) == "function" then
		local ok, value = pcall(os.date, "!%Y-%m-%dT%H:%M:%SZ")
		if ok and value then timestamp = tostring(value) end
	end
	local placeName = "Unknown"
	local placeId = "Unknown"
	local gameId = "Unknown"
	local jobId = "Unknown"
	pcall(function()
		placeName = tostring(game.Name or "Unknown")
		placeId = tostring(game.PlaceId or "Unknown")
		gameId = tostring(game.GameId or "Unknown")
		jobId = tostring(game.JobId or "Unknown")
	end)
	local platform = "Unknown"
	pcall(function()
		local uis = __NARootResolver and __NARootResolver.cs("UserInputService", __NARootResolver.cr)
		if uis and type(uis.GetPlatform) == "function" then
			platform = tostring(uis:GetPlatform())
		end
	end)
	local errorId = "NAE-ROOT-"..string.format("%06d", tonumber(fileIndex) or tonumber(__NARootErrorState.rootCount) or 1)
	local lines = {
		"[Nameless Admin Root Error Report]";
		"Error ID: "..errorId;
		"Error File: NA_Error#"..tostring(fileIndex or "Unknown")..".txt";
		"Time (UTC): "..timestamp;
		"Context: "..tostring(context or options.context or "Nameless Admin Main Runtime");
		"Severity: "..string.upper(tostring(options.severity or "fatal"));
		"";
		"Runtime";
		"Executor: "..execName;
		"Executor Version: "..execVersion;
		"Roblox Client: "..clientVersion;
		"Platform: "..platform;
		"NA Source: "..__NA_SPLIT_SOURCE_TAG;
		"Coverage: Root NACaller";
		"";
		"Session";
		"Place: "..placeName;
		"PlaceId: "..placeId;
		"GameId: "..gameId;
		"JobId: "..jobId;
		"";
		"Callback";
		"Function: "..fnName;
		"Defined At: "..fnSource..":"..tostring(fnLine);
		"";
		"Error";
		tostring(rawError or "Unknown error");
		"";
		"Traceback";
		tostring(tracebackText or rawError or "Unavailable");
	}
	if type(options.details) == "table" then
		lines[#lines + 1] = ""
		lines[#lines + 1] = "Additional Context"
		for key, value in options.details do
			lines[#lines + 1] = tostring(key)..": "..tostring(value)
		end
	end
	local report = table.concat(lines, "\n")
	local writer = type(writefile) == "function" and writefile or (type(appendfile) == "function" and appendfile or nil)
	local saved = false
	if options.log ~= false and type(writer) == "function" then
		pcall(function()
			writer(logPath, report.."\n")
			saved = true
		end)
	end
	if options.warn ~= false and type(warn) == "function" then
		pcall(warn, report..(saved and ("\nSaved: "..logPath) or ""))
	end
	return report, saved and logPath or nil, errorId
end

local function __NARootNACaller(fnOrOptions, ...)
	local options = {}
	local fn
	local args
	if type(fnOrOptions) == "table" and type(select(1, ...)) == "function" then
		for key, value in fnOrOptions do options[key] = value end
		fn = select(1, ...)
		args = table.pack(select(2, ...))
	else
		fn = fnOrOptions
		args = table.pack(...)
	end
	if type(fn) ~= "function" then
		local message = "NACaller expected a function, got "..type(fn)
		__NARootReportError(message, message, options.context or "NACaller bootstrap", nil, options)
		return false, message
	end
	local rawError
	local results = table.pack(xpcall(function()
		return fn(table.unpack(args, 1, args.n))
	end, function(message)
		rawError = tostring(message or "Unknown error")
		if type(debug) == "table" and type(debug.traceback) == "function" then
			local ok, trace = pcall(debug.traceback, rawError, 2)
			if ok and type(trace) == "string" and trace ~= "" then return trace end
		end
		return rawError
	end))
	if not results[1] then
		local trace = tostring(results[2] or rawError or "Unknown error")
		__NARootReportError(rawError or trace, trace, options.context or "Nameless Admin Main Runtime", fn, options)
		if options.rethrow == true then error(trace, 0) end
	end
	return table.unpack(results, 1, results.n)
end

local __NA_SPLIT_LOAD_TOKEN = {}
local __NA_GLOBAL_STATE_KEY = "__NamelessAdminRuntimeState"
local __NA_SPLIT_SESSION = tostring(game.PlaceId).."_"..tostring(game.JobId)
local function __NA_SPLIT_ROOT()
	local reg
	local get = rawget(__NARootHost, "getreg") or getreg
	if type(get) == "function" then
		pcall(function() reg = get() end)
	end
	local dbg = rawget(__NARootHost, "debug") or debug
	if type(reg) ~= "table" and type(dbg) == "table" and type(dbg.getregistry) == "function" then
		pcall(function() reg = dbg.getregistry() end)
	end
	if type(reg) ~= "table" then reg = __NARootHost end
	local root = rawget(reg, "__nameless_admin_private")
	local state = type(root) == "table" and rawget(root, __NA_GLOBAL_STATE_KEY)
	if type(root) ~= "table" or (type(state) == "table" and state.session ~= nil and state.session ~= __NA_SPLIT_SESSION) then
		root = {}
		rawset(reg, "__nameless_admin_private", root)
	end
	return root, reg
end
local __NA_GLOBAL_ENV, __NA_SPLIT_REG = __NA_SPLIT_ROOT()
local __NA_GLOBAL_PREVIOUS_STATE = type(__NA_GLOBAL_ENV) == "table" and rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) or nil
local function __NA_SPLIT_ACTIVE(state)
	if type(state) ~= "table" then return false end
	if state.loaded == true and state.session == nil then return true end
	if state.session ~= __NA_SPLIT_SESSION then return false end
	if state.loaded == true then
		return true
	end
	if state.loading == true then
		if type(state.thread) == "thread" then
			local ok, status = pcall(coroutine.status, state.thread)
			if ok then return status ~= "dead" end
		end
		local updated = tonumber(state.updated or state.started)
		return not updated or os.clock() - updated < 180
	end
	return false
end

if __NA_SPLIT_ACTIVE(__NA_GLOBAL_PREVIOUS_STATE) then
	return
end

local function __NA_SPLIT_RESOLVER()
	local function valid(sr)
		return type(sr) == "table" and type(sr.cs) == "function" and type(sr.gs) == "function"
			and type(sr.cv) == "function" and type(sr.cm) == "function"
	end
	local function accept(sr, source)
		if not valid(sr) then return nil end
		__NARootResolver = sr
		__NA_SPLIT_CONFIG.serviceResolver = sr
		__NA_SPLIT_CONFIG.resolverSource = source
		rawset(__NA_GLOBAL_ENV, "serviceResolver", sr)
		return sr
	end
	if valid(__NARootResolver) then return __NARootResolver end
	local cached = rawget(__NA_GLOBAL_ENV, "serviceResolver")
	if valid(cached) then return accept(cached) end
	local url = "https://gitlab.com/ltseverydayyou/ltseverydayyou.gitlab.io/-/raw/main/ServiceResolver.luau"
	local loader = rawget(__NARootHost, "loadstring") or loadstring or load
	local setter = rawget(__NARootHost, "setfenv") or setfenv
	if type(loader) ~= "function" or type(setter) ~= "function" then
		error("ServiceResolver private loader unavailable", 0)
	end
	local lastErr
	local function compile(source)
		if type(source) ~= "string" or source == "" then return nil end
		local ok, chunk = pcall(loader, source, "@ServiceResolver.luau")
		if not ok or type(chunk) ~= "function" then lastErr = chunk; return nil end
		local base = type(getfenv) == "function" and getfenv(1) or __NARootHost
		local env = setmetatable({ game = game }, { __index = function(_, key)
			local value = __NARootHost[key]
			if value ~= nil then return value end
			return base[key]
		end })
		env._G, env.shared = env, {}
		env.getgenv = function() return env end
		local bound, err = pcall(setter, chunk, env)
		if not bound then lastErr = err; return nil end
		local ran, sr = pcall(chunk)
		if ran and valid(sr) then return accept(sr, source) end
		lastErr = ran and "ServiceResolver returned an invalid API" or sr
		return nil
	end
	if type(readfile) == "function" then
		for _, root in { "NA-split-gitlab/common/", "Nameless-Admin/NA-split-gitlab/common/", "Nameless Admin/NA-split-gitlab/common/" } do
			for _, suffix in { "", ".backup" } do
				local ok, data = pcall(readfile, root..".modules/serviceResolver.cache"..suffix)
				local prefix = url.."\n"
				if ok and type(data) == "string" and data:sub(1, #prefix) == prefix then
					local sr = compile(data:sub(#prefix + 1))
					if sr then return sr end
				end
			end
		end
	end
	local req = rawget(__NARootHost, "request") or rawget(__NARootHost, "http_request") or request or http_request
		or (type(syn) == "table" and syn.request)
	if type(req) == "function" then
		local ok, res = pcall(req, { Url = url; Method = "GET"; Timeout = 5; })
		local status = type(res) == "table" and tonumber(res.StatusCode or res.statusCode or res.Status)
		local source = type(res) == "table" and (res.Body or res.body) or (type(res) == "string" and res)
		if ok and (not status or (status >= 200 and status < 400)) then
			local sr = compile(source)
			if sr then return sr end
		end
		if not ok then lastErr = res end
	end
	local ok, source = pcall(function() return game:HttpGet(url) end)
	if ok then
		local sr = compile(source)
		if sr then return sr end
	else lastErr = source end
	error("ServiceResolver unavailable: "..tostring(lastErr or "no valid cached or downloaded source"), 0)
end

local function __NA_SPLIT_WAIT_READY()
	local ok, sr = pcall(__NA_SPLIT_RESOLVER)
	if not ok then return false, tostring(sr) end
	local deadline = os.clock() + 90
	local function waitFor(check, stage)
		while true do
			local ok, ready = pcall(check)
			if ok and ready then return true end
			if os.clock() >= deadline then return false, stage.." readiness timed out" end
			if type(task) ~= "table" or type(task.wait) ~= "function" then
				return false, "task.wait unavailable while waiting for "..stage
			end
			task.wait(0.03)
		end
	end
	local players = sr.cs("Players", sr.cr)
	local world = sr.cs("Workspace", sr.cr)
	local ready, err = waitFor(function() return players.LocalPlayer end, "LocalPlayer")
	if not ready then return false, err end
	ready, err = waitFor(function() return players.LocalPlayer:FindFirstChildOfClass("PlayerGui") end, "PlayerGui")
	if not ready then return false, err end
	ready, err = waitFor(function() return world.CurrentCamera end, "CurrentCamera")
	if not ready then return false, err end
	return true
end

local __NA_SPLIT_READY, __NA_SPLIT_READY_ERR = __NA_SPLIT_WAIT_READY()
if not __NA_SPLIT_READY then
	__NARootReportError(__NA_SPLIT_READY_ERR, __NA_SPLIT_READY_ERR, "Nameless Admin Autoexecute Readiness", nil, { severity = "error" })
	return
end

__NA_SPLIT_SESSION = tostring(game.PlaceId).."_"..tostring(game.JobId)
__NA_GLOBAL_ENV, __NA_SPLIT_REG = __NA_SPLIT_ROOT()
__NA_GLOBAL_PREVIOUS_STATE = type(__NA_GLOBAL_ENV) == "table" and rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) or nil
if __NA_SPLIT_ACTIVE(__NA_GLOBAL_PREVIOUS_STATE) then
	return
end

local __NA_SPLIT_HOST_STATE = rawget(__NARootHost, __NA_GLOBAL_STATE_KEY)
if type(__NA_SPLIT_HOST_STATE) == "table" and __NA_SPLIT_HOST_STATE.session ~= nil and __NA_SPLIT_HOST_STATE.session ~= __NA_SPLIT_SESSION then
	rawset(__NARootHost, __NA_GLOBAL_STATE_KEY, nil)
	rawset(__NARootHost, "__NA_SPLIT_LOADING", nil)
	rawset(__NARootHost, "NA_LOADED", nil)
	rawset(__NARootHost, "ltseverydayyou_NA", nil)
end

local __NA_SPLIT_STALE = type(__NA_GLOBAL_PREVIOUS_STATE) == "table"
if __NA_SPLIT_STALE and type(warn) == "function" then
	pcall(warn, "[Nameless Admin] Recovering abandoned startup ("..tostring(__NA_GLOBAL_PREVIOUS_STATE.stage or "unknown")..").")
end
if __NA_SPLIT_STALE and type(__NARootHost) == "table" then
	rawset(__NARootHost, "__NA_SPLIT_LOADING", nil)
	if __NA_GLOBAL_PREVIOUS_STATE.loaded ~= true then
		rawset(__NARootHost, "NA_LOADED", nil)
		rawset(__NARootHost, "ltseverydayyou_NA", nil)
	end
end

local __NA_GLOBAL_STATE = {
	loading = true;
	loaded = false;
	source = __NA_SPLIT_SOURCE_TAG;
	token = __NA_SPLIT_LOAD_TOKEN;
	session = __NA_SPLIT_SESSION;
	started = os.clock();
	thread = coroutine.running();
	stage = "bootstrap";
}
__NA_GLOBAL_STATE.updated = __NA_GLOBAL_STATE.started
if type(__NA_GLOBAL_ENV) == "table" then
	rawset(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY, __NA_GLOBAL_STATE)
	if rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) ~= __NA_GLOBAL_STATE then
		return
	end
end

local function __NA_SPLIT_OWNS()
	return rawget(__NA_SPLIT_REG, "__nameless_admin_private") == __NA_GLOBAL_ENV
		and rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) == __NA_GLOBAL_STATE
		and tostring(game.PlaceId).."_"..tostring(game.JobId) == __NA_SPLIT_SESSION
end

local function __NA_SPLIT_SET_STAGE(stage)
	__NA_GLOBAL_STATE.stage = stage
	__NA_GLOBAL_STATE.updated = os.clock()
end

if type(__NARootHost) == "table" and not __NA_SPLIT_ACTIVE(__NA_GLOBAL_PREVIOUS_STATE) then
	if rawget(__NARootHost, "__NA_SPLIT_LOADING") ~= nil and __NA_GLOBAL_PREVIOUS_STATE == nil then
		rawset(__NARootHost, "__NA_SPLIT_LOADING", nil)
		rawset(__NARootHost, "NA_LOADED", nil)
		rawset(__NARootHost, "ltseverydayyou_NA", nil)
	end
end
local __NA_SPLIT_HOST_LOADING = type(__NARootHost) == "table" and rawget(__NARootHost, "__NA_SPLIT_LOADING") or nil
local __NA_SPLIT_HOST_LOADED = type(__NARootHost) == "table" and (rawget(__NARootHost, "ltseverydayyou_NA") or rawget(__NARootHost, "NA_LOADED"))
if __NA_SPLIT_HOST_LOADING or __NA_SPLIT_HOST_LOADED then
	if type(__NA_GLOBAL_ENV) == "table" and rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) == __NA_GLOBAL_STATE then
		rawset(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY, nil)
	end
	return
end
if type(__NARootHost) == "table" then
	rawset(__NARootHost, __NA_GLOBAL_STATE_KEY, __NA_GLOBAL_STATE)
	rawset(__NARootHost, "__NA_SPLIT_LOADING", __NA_SPLIT_LOAD_TOKEN)
	if rawget(__NARootHost, "__NA_SPLIT_LOADING") ~= __NA_SPLIT_LOAD_TOKEN then
		return
	end
end
local function __NA_SPLIT_CLEAR_LOADING()
	if type(__NARootHost) == "table" and rawget(__NARootHost, "__NA_SPLIT_LOADING") == __NA_SPLIT_LOAD_TOKEN then
		rawset(__NARootHost, "__NA_SPLIT_LOADING", nil)
	end
end

local function __NA_SPLIT_CLEAR_OLD_LOCK()
	if type(isfolder) ~= "function" or type(delfolder) ~= "function" then return end
	local key = __NA_SPLIT_SESSION:gsub("[^%w_%-]", "_")
	local path = "Nameless-Admin/.na-split-runtime/lock-"..key
	local ok, exists = pcall(isfolder, path)
	if ok and exists then
		local removed = pcall(delfolder, path)
		if removed and type(warn) == "function" then
			pcall(warn, "[Nameless Admin] Removed abandoned legacy startup lock: "..path)
		end
	end
end
__NA_SPLIT_CLEAR_OLD_LOCK()
if type(__NARootHost) == "table" then
	pcall(rawset, __NARootHost, "NACaller", __NARootNACaller)
end

local function __NA_SPLIT_RELEASE(success)
	if type(__NA_GLOBAL_ENV) == "table" and rawget(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY) == __NA_GLOBAL_STATE then
		if success then
			__NA_GLOBAL_STATE.loading = false
			__NA_GLOBAL_STATE.loaded = true
			__NA_GLOBAL_STATE.thread = nil
			__NA_GLOBAL_STATE.token = nil
			__NA_SPLIT_SET_STAGE("ready")
		else
			rawset(__NA_GLOBAL_ENV, __NA_GLOBAL_STATE_KEY, nil)
		end
	end
	if not success and rawget(__NARootHost, __NA_GLOBAL_STATE_KEY) == __NA_GLOBAL_STATE then
		rawset(__NARootHost, __NA_GLOBAL_STATE_KEY, nil)
		rawset(__NARootHost, "NA_LOADED", nil)
		rawset(__NARootHost, "ltseverydayyou_NA", nil)
	end
	__NA_SPLIT_CLEAR_LOADING()
end

__NA_SPLIT_SET_STAGE("manifest")
local __NA_SPLIT_REMOTE_ROOT = rawget(__NARootHost, "__NA_SPLIT_BASE_URL")
if type(__NA_SPLIT_REMOTE_ROOT) ~= "string" or __NA_SPLIT_REMOTE_ROOT == "" then
	__NA_SPLIT_REMOTE_ROOT = "https://gitlab.com/ltseverydayyou/Nameless-Admin/-/raw/main/NA-split/common/"
end
if __NA_SPLIT_REMOTE_ROOT:sub(-1) ~= "/" then
	__NA_SPLIT_REMOTE_ROOT ..= "/"
end

local __NA_SPLIT_LIMITED = type(hookfunction) ~= "function" or type(getconnections) ~= "function"

local __NA_SPLIT_LOCAL_ROOTS = {
	"NA-split-gitlab/common/";
	"Nameless-Admin/NA-split-gitlab/common/";
	"Nameless Admin/NA-split-gitlab/common/";
}

local __NA_SPLIT_REMOTE_QUERY = ""

local function __NA_SPLIT_READ_LOCAL(root, name)
	if type(readfile) ~= "function" then
		return nil
	end
	local ok, data = pcall(readfile, root..name)
	return ok and type(data) == "string" and data ~= "" and data or nil
end

local function __NA_SPLIT_READ_REMOTE(name, fresh, base)
	local url = (base or __NA_SPLIT_REMOTE_ROOT)..name..__NA_SPLIT_REMOTE_QUERY
	if fresh then
		url ..= (url:find("?", 1, true) and "&" or "?").."na_retry="..tostring(os.time()).."_"..tostring(math.floor(os.clock() * 1000000))
	end
	local requestFn = rawget(__NARootHost, "request")
		or rawget(__NARootHost, "http_request")
		or (type(syn) == "table" and syn.request)
	if type(requestFn) == "function" then
		local ok, response = pcall(requestFn, {
			Method = "GET";
			Url = url;
			Headers = fresh and { ["Cache-Control"] = "no-cache"; } or nil;
		})
		local status = type(response) == "table" and tonumber(response.StatusCode or response.statusCode or response.Status) or nil
		local body = type(response) == "table" and (response.Body or response.body) or nil
		if ok and type(body) == "string" and body ~= "" and (not status or status < 400) then
			return body
		end
	end
	if type(game) ~= "userdata" and type(game) ~= "table" then
		return nil
	end
	local ok, data = pcall(function()
		return game:HttpGet(url)
	end)
	return ok and type(data) == "string" and data ~= "" and data or nil
end

local function __NA_SPLIT_LOAD_MANIFEST(source, name)
	if type(source) ~= "string" then
		return nil
	end
	local loader = rawget(__NARootHost, "loadstring") or loadstring or load
	if type(loader) ~= "function" then
		return nil
	end
	local okCompile, chunk = pcall(loader, source, "@"..name)
	if not okCompile or type(chunk) ~= "function" then
		return nil
	end
	local okRun, manifest = pcall(chunk)
	local count = type(manifest) == "table" and tonumber(manifest.count)
	if okRun and count and count >= 1 and count <= 256 and count % 1 == 0 then
		manifest.count = count
		return manifest
	end
	return nil
end

local function __NA_SPLIT_YIELD()
	if type(task) == "table" and type(task.wait) == "function" then
		task.wait()
	end
end

local function __NA_SPLIT_PART_FINGERPRINT(meta, partName)
	local parts = type(meta) == "table" and meta.parts or nil
	local value = type(parts) == "table" and parts[partName] or nil
	if type(value) == "string" and #value == 40 and value:match("^%x+$") then
		return value
	end
	return nil
end

local function __NA_SPLIT_PART_VALID(source, meta, name)
	if type(source) ~= "string" or source == "" then return false end
	local checks = type(meta) == "table" and meta.integrity or nil
	if checks == nil then return true end
	local check = type(checks) == "table" and checks[name] or nil
	if type(check) ~= "table" or #source ~= check[1] or type(check[2]) ~= "number" then return false end
	local a, b = 1, 0
	local nextYield = os.clock() + 0.004
	for start = 1, #source, 4096 do
		for index = start, math.min(start + 4095, #source) do
			a += string.byte(source, index)
			b += a
		end
		a %= 65521
		b %= 65521
		if start + 4095 < #source and os.clock() >= nextYield then
			__NA_SPLIT_YIELD()
			nextYield = os.clock() + 0.004
		end
	end
	return b * 65536 + a == check[2]
end

local function __NA_SPLIT_LOCAL_PART(root, meta, name)
	local fingerprint = __NA_SPLIT_PART_FINGERPRINT(meta, name)
	if fingerprint then
		local path = root..".parts/"..fingerprint..".lua"
		local exists = true
		if type(isfile) == "function" then
			local ok, value = pcall(isfile, path)
			exists = ok and value
		end
		if exists then
			local source = __NA_SPLIT_READ_LOCAL(root..".parts/", fingerprint..".lua")
			if __NA_SPLIT_PART_VALID(source, meta, name) then return source end
		end
	end
	local source = __NA_SPLIT_READ_LOCAL(root, name)
	return __NA_SPLIT_PART_VALID(source, meta, name) and source or nil
end

local __NA_SPLIT_LOCAL_ROOT = nil
local __NA_SPLIT_LOCAL_META = nil
local __NA_SPLIT_FALLBACK_ROOT = nil
local __NA_SPLIT_FALLBACK_META = nil
for _, root in __NA_SPLIT_LOCAL_ROOTS do
	local manifest = __NA_SPLIT_LOAD_MANIFEST(__NA_SPLIT_READ_LOCAL(root, "manifest.lua"), root.."manifest.lua")
	if manifest then
		local complete = true
		if type(isfile) == "function" then
			for index = 1, manifest.count do
				local name = string.format("part-%03d.lua", index)
				local fingerprint = __NA_SPLIT_PART_FINGERPRINT(manifest, name)
				local ok, exists = false, false
				if fingerprint then ok, exists = pcall(isfile, root..".parts/"..fingerprint..".lua") end
				if not (ok and exists) then ok, exists = pcall(isfile, root..name) end
				if not (ok and exists) then complete = false; break end
			end
		end
		if complete then
			__NA_SPLIT_LOCAL_ROOT = root
			__NA_SPLIT_LOCAL_META = manifest
			break
		elseif not __NA_SPLIT_FALLBACK_ROOT then
			__NA_SPLIT_FALLBACK_ROOT = root
			__NA_SPLIT_FALLBACK_META = manifest
		end
	end
end
if not __NA_SPLIT_LOCAL_ROOT then
	__NA_SPLIT_LOCAL_ROOT = __NA_SPLIT_FALLBACK_ROOT
	__NA_SPLIT_LOCAL_META = __NA_SPLIT_FALLBACK_META
end

local __NA_SPLIT_REMOTE_MANIFEST_SOURCE = __NA_SPLIT_READ_REMOTE("manifest.lua?na_manifest="..tostring(os.time()))
local __NA_SPLIT_REMOTE_META = __NA_SPLIT_LOAD_MANIFEST(__NA_SPLIT_REMOTE_MANIFEST_SOURCE, "NA-split/common/manifest.lua")
if __NA_SPLIT_REMOTE_META and type(__NA_SPLIT_REMOTE_META.version) == "string" and __NA_SPLIT_REMOTE_META.version ~= "" then
	__NA_SPLIT_REMOTE_QUERY = "?na_build="..__NA_SPLIT_REMOTE_META.version
end
local __NA_SPLIT_REMOTE_CHANGED = __NA_SPLIT_REMOTE_META ~= nil
	and (__NA_SPLIT_LOCAL_META == nil or __NA_SPLIT_REMOTE_META.version ~= __NA_SPLIT_LOCAL_META.version)
local __NA_SPLIT_COUNT = math.max(0, math.floor(tonumber(
	(__NA_SPLIT_REMOTE_META and __NA_SPLIT_REMOTE_META.count)
		or (__NA_SPLIT_LOCAL_META and __NA_SPLIT_LOCAL_META.count)
		or 30
) or 0))
local __NA_SPLIT_CACHE_ROOT = __NA_SPLIT_LOCAL_ROOT or __NA_SPLIT_LOCAL_ROOTS[1]
local __NA_SPLIT_PENDING_CACHE = {}
local __NA_SPLIT_CACHE_OK = type(writefile) == "function"
local __NA_SPLIT_CACHE_READY = false
local __NA_SPLIT_CACHE_MANIFEST = __NA_SPLIT_REMOTE_META ~= nil and (
	__NA_SPLIT_LOCAL_META == nil
	or __NA_SPLIT_REMOTE_CHANGED
	or type(__NA_SPLIT_LOCAL_META.parts) ~= "table"
	or __NA_SPLIT_LOCAL_META.loader_version ~= __NA_SPLIT_REMOTE_META.loader_version
)

local function __NA_SPLIT_READ_PART(partName)
	if not __NA_SPLIT_REMOTE_META then
		local source = __NA_SPLIT_LOCAL_ROOT and __NA_SPLIT_LOCAL_PART(__NA_SPLIT_LOCAL_ROOT, __NA_SPLIT_LOCAL_META, partName)
		if source then return source end
		error("Nameless Admin chunk unavailable or invalid: "..partName, 0)
	end

	local remoteFingerprint = __NA_SPLIT_PART_FINGERPRINT(__NA_SPLIT_REMOTE_META, partName)
	local localFingerprint = __NA_SPLIT_PART_FINGERPRINT(__NA_SPLIT_LOCAL_META, partName)
	if __NA_SPLIT_LOCAL_ROOT and ((remoteFingerprint and remoteFingerprint == localFingerprint)
		or (not __NA_SPLIT_REMOTE_CHANGED and not localFingerprint)) then
		local source = __NA_SPLIT_LOCAL_PART(__NA_SPLIT_LOCAL_ROOT, __NA_SPLIT_REMOTE_META, partName)
		if source then return source end
	end

	for attempt = 1, 2 do
		local source = __NA_SPLIT_READ_REMOTE(partName, attempt == 2)
		if __NA_SPLIT_PART_VALID(source, __NA_SPLIT_REMOTE_META, partName) then
			__NA_SPLIT_PENDING_CACHE[partName] = source
			return source
		end
	end
	error("Nameless Admin chunk unavailable or invalid: "..partName, 0)
end

local function __NA_SPLIT_CACHE_PART(partName)
	local source = __NA_SPLIT_PENDING_CACHE[partName]
	__NA_SPLIT_PENDING_CACHE[partName] = nil
	if not source then return end
	__NA_SPLIT_CACHE_MANIFEST = true
	local fingerprint = __NA_SPLIT_PART_FINGERPRINT(__NA_SPLIT_REMOTE_META, partName)
	if not __NA_SPLIT_CACHE_OK or not fingerprint then
		__NA_SPLIT_CACHE_OK = false
		return
	end
	if not __NA_SPLIT_CACHE_READY then
		if type(makefolder) == "function" then
			local current = ""
			for segment in (__NA_SPLIT_CACHE_ROOT..".parts"):gmatch("[^/]+") do
				current = current == "" and segment or current.."/"..segment
				pcall(makefolder, current)
			end
		end
		__NA_SPLIT_CACHE_READY = true
	end
	if not pcall(writefile, __NA_SPLIT_CACHE_ROOT..".parts/"..fingerprint..".lua", source) then
		__NA_SPLIT_CACHE_OK = false
	end
end

local function __NA_SPLIT_CACHE_REMOTE()
	if not __NA_SPLIT_CACHE_OK or not __NA_SPLIT_CACHE_MANIFEST or not __NA_SPLIT_REMOTE_MANIFEST_SOURCE then return end
	if not pcall(writefile, __NA_SPLIT_CACHE_ROOT.."manifest.lua", __NA_SPLIT_REMOTE_MANIFEST_SOURCE) then return end
	if type(listfiles) ~= "function" or type(delfile) ~= "function" then return end
	local ok, files = pcall(listfiles, __NA_SPLIT_CACHE_ROOT..".parts")
	if not ok or type(files) ~= "table" then return end
	local keep = {}
	for _, value in __NA_SPLIT_REMOTE_META.parts or {} do keep[value] = true end
	for _, path in files do
		local name = tostring(path):gsub("\\", "/"):match("/([%x]+)%.lua$")
		if name and #name == 40 and not keep[name] then pcall(delfile, path) end
		__NA_SPLIT_YIELD()
	end
end

local function __NA_SPLIT_LOAD_PART(source, chunkName, environment)
	local loader = rawget(__NARootHost, "loadstring") or loadstring or load
	if type(loader) ~= "function" then
		error("Nameless Admin requires loadstring/load", 0)
	end
	local okCompile, chunk, compileError = pcall(loader, source, "@"..chunkName)
	if not okCompile or type(chunk) ~= "function" then
		error(tostring(compileError or chunk or "chunk compilation failed"), 0)
	end
	local setter = rawget(__NARootHost, "setfenv") or setfenv
	if type(setter) ~= "function" then
		error("Nameless Admin requires setfenv for split chunks", 0)
	end
	local okEnv, envError = pcall(setter, chunk, environment)
	if not okEnv then
		error(tostring(envError), 0)
	end
	return chunk
end

local function __NA_SPLIT_FORMAT_ERROR(value)
	local text = tostring(value)
	if type(debug) == "table" and type(debug.traceback) == "function" then
		local ok, trace = pcall(debug.traceback, text, 2)
		if ok and type(trace) == "string" and trace ~= "" then
			return trace
		end
	end
	return text
end

local function __NA_SPLIT_CACHE_LOADER(meta)
	if type(meta) ~= "table" or type(meta.loader_version) ~= "string" then return end
	if type(writefile) ~= "function" then
		return
	end

	local host = (type(getgenv) == "function" and getgenv()) or _G or {}
	local state = type(host) == "table" and rawget(host, "__NamelessAdminRuntimeState") or nil
	local sourceTag = __NA_SPLIT_SOURCE_TAG
	if sourceTag ~= "Source.lua" and sourceTag ~= "NA testing.lua" then
		return
	end

	local roots = {
		"NA-split-gitlab/";
		"Nameless-Admin/NA-split-gitlab/";
		"Nameless Admin/NA-split-gitlab/";
	}
	local root = roots[1]
	if type(isfile) == "function" then
		for _, candidate in roots do
			local ok, exists = pcall(isfile, candidate.."common/manifest.lua")
			if ok and exists then
				root = candidate
				break
			end
		end
	end

	local cachePath = root..sourceTag
	local versionPath = root.."."..sourceTag:gsub("[^%w]+", "_")..".version"
	if type(readfile) == "function" then
		local okVersion, cachedVersion = pcall(readfile, versionPath)
		local okLoader, exists = false, false
		if type(isfile) == "function" then okLoader, exists = pcall(isfile, cachePath) end
		if okVersion and cachedVersion == meta.loader_version and okLoader and exists then
			return
		end
	end

	local remoteName = sourceTag:gsub(" ", "%%20")
	local loaderRoot = __NA_SPLIT_REMOTE_ROOT:gsub("NA%-split/[^/]+/$", "")
	if loaderRoot == __NA_SPLIT_REMOTE_ROOT then return end
	local url = loaderRoot..remoteName.."?na_loader="..meta.loader_version
	local requestFn = type(host) == "table" and (rawget(host, "request") or rawget(host, "http_request")) or nil
	local synTable = type(host) == "table" and rawget(host, "syn") or nil
	if type(requestFn) ~= "function" and type(synTable) == "table" then
		requestFn = synTable.request
	end

	local source
	if type(requestFn) == "function" then
		local ok, response = pcall(requestFn, { Method = "GET"; Url = url; })
		local status = type(response) == "table" and tonumber(response.StatusCode or response.statusCode or response.Status) or nil
		local body = type(response) == "table" and (response.Body or response.body) or nil
		if ok and type(body) == "string" and body ~= "" and (not status or status < 400) then
			source = body
		end
	end

	if not source and (type(game) == "userdata" or type(game) == "table") then
		local ok, body = pcall(function()
			return game:HttpGet(url)
		end)
		if ok and type(body) == "string" and body ~= "" then
			source = body
		end
	end
	if not source then
		return
	end

	local loader = type(host) == "table" and rawget(host, "loadstring") or nil
	loader = loader or loadstring or load
	if type(loader) ~= "function" then
		return
	end
	local okCompile, chunk = pcall(loader, source, "@"..sourceTag)
	if not okCompile or type(chunk) ~= "function" then
		return
	end

	if type(makefolder) == "function" then
		local parent = root:gsub("/$", "")
		local current = ""
		for segment in parent:gmatch("[^/]+") do
			current = current == "" and segment or current.."/"..segment
			pcall(makefolder, current)
		end
	end
	if pcall(writefile, cachePath, source) then
		pcall(writefile, versionPath, meta.loader_version)
	end
end


local function __NA_SPLIT_CLEAR_LEGACY()
	if type(isfolder) ~= "function" or type(delfolder) ~= "function" then return 0 end
	local function clean(root, path, depth)
		if depth > 16 then return end
		local ok, exists = pcall(isfolder, path)
		if not ok or not exists then return end
		if type(listfiles) == "function" then
			local listed, items = pcall(listfiles, path)
			if listed and type(items) == "table" then
				for _, entry in items do
					local name = tostring(entry):gsub("\\", "/"):gsub("^%./", ""):gsub("/+$", "")
					if name:sub(1, #root + 1) == root.."/"
						and not name:find("/../", 1, true) and name:sub(-3) ~= "/.." then
						local valid, isDir = pcall(isfolder, name)
						if valid and isDir then
							clean(root, name, depth + 1)
						elseif type(delfile) == "function" then
							pcall(delfile, name)
						end
					end
				end
			end
		end
		pcall(delfolder, path)
	end
	local removed = 0
	for _, root in { "NA-split", "Nameless-Admin/NA-split", "Nameless Admin/NA-split" } do
		local ok, exists = pcall(isfolder, root)
		if ok and exists then
			clean(root, root, 0)
			local checked, remains = pcall(isfolder, root)
			if checked and not remains then removed += 1 end
		end
	end
	return removed
end

local function __NA_SPLIT_MODULE_PATH(key)
	if type(key) ~= "string" or not key:match("^[%w_-]+$") then return nil end
	return __NA_SPLIT_CACHE_ROOT..".modules/"..key..".cache"
end

local function __NA_SPLIT_MODULE_SOURCE(data, url)
	if type(data) ~= "string" or type(url) ~= "string" or url == "" or url:find("[\r\n]") then return nil end
	local prefix = url.."\n"
	if data:sub(1, #prefix) ~= prefix then return nil end
	local source = data:sub(#prefix + 1)
	if source == "" then return nil end
	local loader = rawget(__NARootHost, "loadstring") or loadstring or load
	if type(loader) ~= "function" then return nil end
	local ok, chunk = pcall(loader, source, "@"..url)
	return ok and type(chunk) == "function" and source or nil
end

local function __NA_SPLIT_READ_MODULE(key, url)
	local path = __NA_SPLIT_MODULE_PATH(key)
	if not path or type(readfile) ~= "function" then return nil end
	local paths = {path, path..".backup"}
	for _, name in paths do
		local ok, data = pcall(readfile, name)
		local source = ok and __NA_SPLIT_MODULE_SOURCE(data, url)
		if source then return source end
	end
	return nil
end

local function __NA_SPLIT_SAVE_MODULE(key, url, source)
	local path = __NA_SPLIT_MODULE_PATH(key)
	if not path or type(readfile) ~= "function" or type(writefile) ~= "function" or type(source) ~= "string" then return false end
	if type(url) ~= "string" or url == "" or url:find("[\r\n]") then return false end
	local data = url.."\n"..source
	if not __NA_SPLIT_MODULE_SOURCE(data, url) then return false end
	local okOld, old = pcall(readfile, path)
	if okOld and old == data then return true end
	if type(makefolder) == "function" then
		local current = ""
		for segment in (__NA_SPLIT_CACHE_ROOT..".modules"):gmatch("[^/]+") do
			current = current == "" and segment or current.."/"..segment
			pcall(makefolder, current)
		end
	end
	if okOld and __NA_SPLIT_MODULE_SOURCE(old, url) then
		if not pcall(writefile, path..".backup", old) then return false end
		local okBackup, backup = pcall(readfile, path..".backup")
		if not okBackup or backup ~= old then return false end
	end
	if not pcall(writefile, path, data) then return false end
	local okRead, written = pcall(readfile, path)
	return okRead and written == data
end

local __NA_SPLIT_ENV
local __NA_LAZY_FILES = {}
local __NA_LAZY_ORDER = {}
local __NA_MODULE_REFRESH = {}

local __NA_SPLIT_DEFER

local function __NA_SPLIT_REMEMBER(name, source)
	if __NA_LAZY_FILES[name] then return end
	__NA_LAZY_FILES[name] = source
	__NA_LAZY_ORDER[#__NA_LAZY_ORDER + 1] = name
	while #__NA_LAZY_ORDER > 4 do
		__NA_LAZY_FILES[table.remove(__NA_LAZY_ORDER, 1)] = nil
	end
end

local function __NA_SPLIT_LAZY_SOURCE(name)
	if __NA_LAZY_FILES[name] then return __NA_LAZY_FILES[name] end
	local source = __NA_SPLIT_PENDING_CACHE[name]
	if not source then
		local meta = __NA_SPLIT_REMOTE_META or __NA_SPLIT_LOCAL_META
		if type(meta) ~= "table" then error("Missing common source manifest", 0) end
		source = __NA_SPLIT_READ_PART(name)
	end
	__NA_SPLIT_REMEMBER(name, source)
	return source
end

local function __NA_SPLIT_READ_DEFER()
	local meta = __NA_SPLIT_REMOTE_META or __NA_SPLIT_LOCAL_META
	if not __NA_SPLIT_LIMITED or not __NA_SPLIT_PART_FINGERPRINT(meta, "deferred.lua") then return end
	local ok, source = pcall(__NA_SPLIT_READ_PART, "deferred.lua")
	if not ok then return end
	local valid, chunk = pcall(__NA_SPLIT_LOAD_PART, source, "NA-split/common/deferred.lua", {})
	if not valid then return end
	local ran, data = pcall(chunk)
	if ran and type(data) == "table" then
		__NA_SPLIT_DEFER = data
		__NA_SPLIT_CACHE_PART("deferred.lua")
	end
end

local function __NA_SPLIT_PREPARE(source, name)
	local rows = __NA_SPLIT_DEFER and __NA_SPLIT_DEFER[name]
	if type(rows) ~= "table" or #rows == 0 then return source end
	local out, pos = {}, 1
	for _, row in rows do
		if type(row) ~= "table" then return source end
		local first, last, cut, line, prefix = table.unpack(row, 1, 5)
		if type(first) ~= "number" or type(last) ~= "number" or type(cut) ~= "number"
			or type(line) ~= "number" or type(prefix) ~= "string" or first < pos or last < first or last > #source
			or first % 1 ~= 0 or last % 1 ~= 0 or cut % 1 ~= 0 or line % 1 ~= 0
			or (cut ~= 0 and (cut < first or cut > last)) then return source end
		out[#out + 1] = source:sub(pos, first - 1)
		local label = "NA-split/common/"..name..":"..tostring(line)
		out[#out + 1] = prefix.."__NA_SPLIT_LAZY("..string.format("%q, %d, %d, %d, %q", name, first, last, cut, label)..")"
		pos = last + 1
	end
	out[#out + 1] = source:sub(pos)
	__NA_SPLIT_REMEMBER(name, source)
	return table.concat(out)
end

local function __NA_SPLIT_LAZY(name, first, last, cut, label)
	local fn, busy
	return function(...)
		while busy and coroutine.status(busy) ~= "dead" do task.wait() end
		if not fn then
			busy = coroutine.running()
			local ok, result = pcall(function()
				local source = __NA_SPLIT_LAZY_SOURCE(name)
				local body = cut > 0 and "function"..source:sub(cut, last) or source:sub(first, last)
				local env = __NA_SPLIT_ENV
				local boot = type(env) == "table" and rawget(env, "_na_boot")
				env = type(boot) == "table" and boot.runtimeEnv or env
				local chunk = __NA_SPLIT_LOAD_PART("return "..body, label, env)
				local value = chunk()
				if type(value) ~= "function" then error("Invalid deferred function: "..label, 0) end
				return value
			end)
			busy = nil
			if not ok then error(result, 0) end
			fn = result
		end
		return fn(...)
	end
end

local function __NA_SPLIT_QUEUE_REFRESH(key, url, fetch)
	if type(fetch) == "function" then
		__NA_MODULE_REFRESH[key] = {url = url, fetch = fetch}
	end
end

local function __NA_SPLIT_REFRESH_MODULES()
	if not __NA_SPLIT_LIMITED or not __NA_SPLIT_REMOTE_META or type(task.spawn) ~= "function" then return end
	task.spawn(function()
		for key, record in __NA_MODULE_REFRESH do
			if not __NA_SPLIT_OWNS() then break end
			local ok, source = pcall(record.fetch)
			if ok and type(source) == "string" and __NA_SPLIT_OWNS() then
				pcall(__NA_SPLIT_SAVE_MODULE, key, record.url, source)
			end
			__NA_MODULE_REFRESH[key] = nil
			task.wait()
		end
		table.clear(__NA_MODULE_REFRESH)
	end)
end

local function __NA_SPLIT_RUN()
	__NA_SPLIT_READ_DEFER()
	__NA_SPLIT_CONFIG.state = __NA_GLOBAL_STATE
	__NA_SPLIT_CONFIG.privateRoot = __NA_GLOBAL_ENV
	__NA_SPLIT_CONFIG.privateRegistry = __NA_SPLIT_REG
	__NA_SPLIT_CONFIG.cacheRoot = __NA_SPLIT_CACHE_ROOT
	__NA_SPLIT_CONFIG.offline = __NA_SPLIT_REMOTE_META == nil
	__NA_SPLIT_CONFIG.fastStart = __NA_SPLIT_LIMITED
	__NA_SPLIT_CONFIG.moduleRefresh = __NA_SPLIT_QUEUE_REFRESH
	__NA_SPLIT_CONFIG.moduleRead = __NA_SPLIT_READ_MODULE
	__NA_SPLIT_CONFIG.moduleWrite = __NA_SPLIT_SAVE_MODULE
	local environment = setmetatable({
		__NA_SPLIT_CONFIG = __NA_SPLIT_CONFIG;
		__NA_SPLIT_LAZY = __NA_SPLIT_LAZY;
		NACaller = __NARootNACaller;
		__NARootHost = __NARootHost;
		__NARootPreviousNACaller = __NARootPreviousNACaller;
		__NARootErrorState = __NARootErrorState;
		__NARootExecutorInfo = __NARootExecutorInfo;
		__NARootDebugInfo = __NARootDebugInfo;
		__NARootNextErrorPath = __NARootNextErrorPath;
		__NARootReportError = __NARootReportError;
		__NARootNACaller = __NARootNACaller;
	}, {
		__index = function(target, key)
			local boot = rawget(target, "_na_boot")
			local runtime = type(boot) == "table" and boot.runtimeEnv
			if type(runtime) == "table" then
				local value = rawget(runtime, key)
				if value ~= nil then
					return value
				end
			end
			return __NARootHost[key]
		end;
		__newindex = function(target, key, value)
			local boot = rawget(target, "_na_boot")
			local runtime = type(boot) == "table" and boot.runtimeEnv
			if type(runtime) == "table" and key ~= "_na_boot" and key ~= "_na_env" and key ~= "_na_shared" then
				rawset(runtime, key, value)
			else
				rawset(target, key, value)
			end
		end;
	})
	__NA_SPLIT_ENV = environment
	for index = 1, __NA_SPLIT_COUNT do
		if not __NA_SPLIT_OWNS() then
			error("Nameless Admin loading was cancelled", 0)
		end
		local partName = string.format("part-%03d.lua", index)
		__NA_GLOBAL_STATE.details.stage = partName
		__NA_GLOBAL_STATE.details.fingerprint = __NA_SPLIT_PART_FINGERPRINT(__NA_SPLIT_REMOTE_META or __NA_SPLIT_LOCAL_META, partName)
		__NA_SPLIT_SET_STAGE(partName)
		local source = __NA_SPLIT_READ_PART(partName)
		if not __NA_SPLIT_OWNS() then error("Nameless Admin loading was cancelled", 0) end
		local chunk = __NA_SPLIT_LOAD_PART(__NA_SPLIT_PREPARE(source, partName), "NA-split/common/"..partName, environment)
		local okRun, runError = xpcall(chunk, __NA_SPLIT_FORMAT_ERROR)
		chunk = nil
		source = nil
		if not okRun then
			error(__NA_SPLIT_FORMAT_ERROR(runError), 0)
		end
		if index == 1 then
			if runError == "__NA_SPLIT_DUPLICATE" then
				__NA_SPLIT_CONFIG.duplicate = true
				__NA_SPLIT_ENV = nil
				return
			end
			local boot = rawget(environment, "_na_boot")
			if type(boot) ~= "table" or type(boot.runtimeEnv) ~= "table" then
				error("Nameless Admin split bootstrap did not initialize", 0)
			end
			local migrated = {}
			for key, value in environment do
				if key ~= "__NA_SPLIT_CONFIG" and key ~= "NACaller" and key ~= "_na_boot" and key ~= "_na_env" and key ~= "_na_shared" then
					migrated[key] = value
				end
			end
			for key, value in migrated do
				rawset(boot.runtimeEnv, key, value)
				rawset(environment, key, nil)
			end
			environment = boot.runtimeEnv
			__NA_SPLIT_ENV = environment
		end
		__NA_SPLIT_CACHE_PART(partName)
		__NA_SPLIT_YIELD()
	end
	if not __NA_SPLIT_OWNS() then
		error("Nameless Admin loading was cancelled", 0)
	end
	__NA_SPLIT_SET_STAGE("cache")
	__NA_GLOBAL_STATE.details.stage = "cache"
	__NA_SPLIT_CACHE_REMOTE()
	pcall(__NA_SPLIT_CACHE_LOADER, __NA_SPLIT_REMOTE_META or __NA_SPLIT_LOCAL_META)
	local saved = __NA_SPLIT_LOAD_MANIFEST(__NA_SPLIT_READ_LOCAL(__NA_SPLIT_CACHE_ROOT, "manifest.lua"), __NA_SPLIT_CACHE_ROOT.."manifest.lua")
	local expected = __NA_SPLIT_REMOTE_META or __NA_SPLIT_LOCAL_META
	if __NA_SPLIT_CACHE_OK and saved and expected and saved.version == expected.version then
		pcall(__NA_SPLIT_CLEAR_LEGACY)
	end
end

local function __NA_SPLIT_ABORT()
	if not __NA_SPLIT_OWNS() then return end
	local environment = __NA_SPLIT_ENV
	if type(environment) ~= "table" then return end
	local boot = rawget(environment, "_na_boot")
	if type(boot) == "table" and type(boot.splitConfig) == "table" and boot.splitConfig.state ~= __NA_GLOBAL_STATE then return end
	local runtime = type(boot) == "table" and boot.runtimeEnv or environment
	local manage = rawget(runtime, "NAmanage")
	local unload = type(manage) == "table" and rawget(manage, "Unload")
	if type(unload) == "function" then
		local ok, done = pcall(unload, { silent = true })
		if ok and done ~= false then return end
	end
	if type(manage) == "table" and type(manage._runtimeState) == "table" then
		manage._runtimeState.unloading = true
		manage._runtimeState.runToken = nil
	end
	local seen = {}
	local current = coroutine.running()
	local function cancel(thread)
		if type(manage) == "table" and type(manage.CancelRuntimeTask) == "function" then
			pcall(manage.CancelRuntimeTask, thread)
		elseif type(task) == "table" then
			pcall(task.cancel, thread)
		end
	end
	local function clean(value)
		if type(value) ~= "table" or seen[value] then return end
		if type(boot) == "table" and (value == boot or value == boot.hostEnv
			or value == boot.privateRegistry or value == boot.privateRoot or value == runtime) then return end
		seen[value] = true
		if rawget(value, "Connected") ~= nil and type(rawget(value, "Disconnect")) == "function" then
			pcall(rawget(value, "Disconnect"), value)
		end
		for key, child in next, value do
			if typeof(child) == "RBXScriptConnection" then
				pcall(function() child:Disconnect() end)
			elseif type(child) == "thread" and child ~= current and coroutine.status(child) ~= "dead" and type(task) == "table" then
				cancel(child)
			elseif type(child) == "table" then
				clean(child)
			end
			if type(key) == "thread" and key ~= current and coroutine.status(key) ~= "dead" and type(task) == "table" then cancel(key) end
		end
	end
	for _, name in { "NAmanage", "NAStuff", "NAjobs", "NAgui", "NAUIMANAGER", "NAindex", "NAAssetsLoading" } do clean(rawget(runtime, name)) end
	local stuff = rawget(runtime, "NAStuff")
	if type(stuff) == "table" and typeof(stuff.NASCREENGUI) == "Instance" then
		pcall(function() stuff.NASCREENGUI:Destroy() end)
	end
	local assets = rawget(runtime, "NAAssetsLoading")
	if type(assets) == "table" and typeof(assets.ui) == "Instance" then
		pcall(function() assets.ui:Destroy() end)
	end
	if type(boot) == "table" and type(boot.privateRoot) == "table" then
		local root = boot.privateRoot
		local owned = rawget(runtime, "_na_env")
		local ownsRoot = type(owned) == "table" and root.testing == owned
		local protector = rawget(runtime, "__NAUIProtector")
		if type(protector) ~= "table" and ownsRoot then protector = root.uiProtector end
		if type(protector) == "table" and (ownsRoot or root.uiProtector ~= protector) then
			if type(protector.destroy) == "function" then pcall(protector.destroy) end
			if root.uiProtector == protector then root.uiProtector = nil end
		end
		if ownsRoot then
			root.testing = nil
			root.naRuns = nil
		end
	end
end

__NA_GLOBAL_STATE.details = {
	stage = "manifest";
	session = tostring(game.PlaceId).."_"..tostring(game.JobId);
	build = (__NA_SPLIT_REMOTE_META and __NA_SPLIT_REMOTE_META.version) or (__NA_SPLIT_LOCAL_META and __NA_SPLIT_LOCAL_META.version) or "unknown";
}

local __NARootResult = table.pack(__NARootNACaller({
	context = "Nameless Admin Main Runtime";
	details = __NA_GLOBAL_STATE.details;
	severity = "fatal";
	warn = true;
	log = true;
}, __NA_SPLIT_RUN))

if not __NARootResult[1] then pcall(__NA_SPLIT_ABORT) end

if (not __NARootResult[1] or __NA_SPLIT_CONFIG.duplicate) and type(__NARootHost) == "table"
	and rawget(__NARootHost, "NACaller") == __NARootNACaller then
	pcall(function()
		if __NARootPreviousNACaller ~= nil then
			rawset(__NARootHost, "NACaller", __NARootPreviousNACaller)
		else
			rawset(__NARootHost, "NACaller", nil)
		end
	end)
end

if __NARootResult[1] then
	__NA_SPLIT_RELEASE(not __NA_SPLIT_CONFIG.duplicate)
	if not __NA_SPLIT_CONFIG.duplicate then __NA_SPLIT_REFRESH_MODULES() end
	return table.unpack(__NARootResult, 2, __NARootResult.n)
end

__NA_SPLIT_RELEASE(false)
