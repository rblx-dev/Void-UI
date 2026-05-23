(function() return [[

	  /$$$$$$  /$$$$$$$   /$$$$$$  /$$$$$$$$ /$$   /$$  /$$$$$$        /$$   /$$       /$$    /$$ /$$$$$$$ 
	 /$$__  $$| $$__  $$ /$$__  $$| $$_____/| $$  | $$ /$$__  $$      | $$  / $$      | $$   | $$| $$____/ 
	| $$  \ $$| $$  \ $$| $$  \__/| $$      | $$  | $$| $$  \__/      |  $$/ $$/      | $$   | $$| $$      
	| $$$$$$$$| $$$$$$$/| $$      | $$$$$   | $$  | $$|  $$$$$$        \  $$$$/       |  $$ / $$/| $$$$$$$ 
	| $$__  $$| $$__  $$| $$      | $$__/   | $$  | $$ \____  $$        >$$  $$        \  $$ $$/ |_____  $$
	| $$  | $$| $$  \ $$| $$    $$| $$      | $$  | $$ /$$  \ $$       /$$/\  $$        \  $$$/   /$$  \ $$
	| $$  | $$| $$  | $$|  $$$$$$/| $$$$$$$$|  $$$$$$/|  $$$$$$/      | $$  \ $$         \  $/   |  $$$$$$/
	|__/  |__/|__/  |__/ \______/ |________/ \______/  \______/       |__/  |__/          \_/     \______/ 
                                                                                                                                                                                
	- materials not found
	- https://www.youtube.com/@materialsnotfound
	
]] end)()

if not LPH_OBFUSCATED then -- Luraph integration
	local dummy = function(...) return ... end
	LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or dummy
	LPH_NO_UPVALUES = LPH_NO_UPVALUES or dummy
	LPH_OBFUSCATED = LPH_OBFUSCATED or false
	LPH_JIT_MAX = LPH_JIT_MAX or dummy
	LPH_ENCFUNC = LPH_ENCFUNC or dummy
	LPH_ENCSTR = LPH_ENCSTR or dummy
	LPH_ENCNUM = LPH_ENCNUM or dummy
	LPH_CRASH = LPH_CRASH or dummy
	LPH_JIT = LPH_JIT or dummy
end

local framework, endpoints do
	endpoints = {
		arceus_neo = LPH_ENCSTR("https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main"),
		xploit = LPH_ENCSTR("https://raw.githubusercontent.com/Riky47/Xploit-Framework/refs/heads/main"),
		scriptblox = LPH_ENCSTR("https://scriptblox.com"),
		api = LPH_ENCSTR("https://spdmteam.com/api"),

		rbxcdn = {
			tr = LPH_ENCSTR("https://tr.rbxcdn.com"),
			t1 = LPH_ENCSTR("https://t1.rbxcdn.com")
		}
	}

	endpoints.arceus_v = `{endpoints.arceus_neo}/axv5`
	pcall(function() loadstring(game:HttpGet(`{endpoints.arceus_neo}/init.lua`))() end)

	-- Include Arceus X adapter
	local axinclude, axerr = pcall(function()
		loadstring(game:HttpGet(`{endpoints.arceus_neo}/adapter.lua`))()
	end)

	-- Include framework
	local cloneref = cloneref or function(...) return ... end
	local run: RunService = cloneref(game:GetService("RunService"))

	if run:IsStudio() then 
		if _G.Once then return end _G.Once = true
		framework = require(game:GetService("StarterGui"):WaitForChild("Wave"):WaitForChild("WaveFramework"))
	else
		framework = loadstring(arceus.WHWKIIIIWIIOSU(game:HttpGet(`https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main/axv5/Xploit-Framework/index.lua`)))()
	end
	
	if not axinclude and not framework.protected:IsStudio() then
		return framework.console.error("Unable to load Arceus X Adapter: " .. axerr)
	end

	-- Adapter to SPDM file system
	local spdminclude, spdmerr = pcall(function()
		loadstring(framework.utils.http:Get(`{endpoints.xploit}/mods/spdm-fs.lua`))(framework)
	end)

	if not spdminclude and not framework.protected:IsStudio() then
		return framework.console.error("Unable to load SPDM file system adapter: " .. spdmerr)
	end
end

-- Configs
local EXPLOIT_CONFIGS, OS_CONFIGS do
	OS_CONFIGS = {
		IS_IOS = (framework.env.arceus and framework.env.arceus.is_ios or function()
			return (not framework.protected:IsStudio()) and framework.protected:GetService("UserInputService"):GetPlatform() == Enum.Platform.IOS or false
		end)(),
		
		IS_VNG = (framework.env.arceus and framework.env.arceus.is_vng or function()
			return false
		end)(),
		
		DEVICE_INFO = framework.env.arceus and framework.env.arceus.WOWPALAKSZMNXBRU or function()
			return false
		end,
		
		HWID = (framework.env.gethwid)()
	}
	OS_CONFIGS.HIDE_PREFIX = OS_CONFIGS.IS_IOS and "" or "."
	
	EXPLOIT_CONFIGS = {
		EXPLOIT_FULLNAME = LPH_ENCSTR("Arceus X v5"),
		EXPLOIT_IDENTITY = LPH_ENCSTR("Arceus"),
		UI_VERSION = LPH_ENCSTR("1.0.0"),

		API_CRYPT = LPH_ENCSTR("SPDMTeam_1LPPWJfrnW8BSlsj24D54ghgkXakSd2bztZGJouYfITeRNNZhVFcShtIUlbLZSPJ"),
		FILES_KEY = LPH_ENCSTR("ARCEUS_W6dKPSt6TTzAdS4pYVG3IKu9iigp8Kb66bbu9E08Osw9wGUztD5ENIezDxp30Yz7"),
		CLOUD_SCRIPTS = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("cloudscripts.ax"),
		SETTINGS_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("settings.ax"),
		LICENSE_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("license.ax"),
		VERSION_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("version.ax"),
		PLUGINS_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("plugins.ax"),
		TABS_FILE = LPH_ENCSTR("Tabs.json"),

		AUTH_FETCH_DELAY = 5,
		SETTINGS = {
			Popups_Confirmation = true,
			Popups_Toast = true,

			Colors_Primary = Color3.fromRGB(219, 0, 0):ToHex(),
			Colors_Secondary = Color3.fromRGB(0, 0, 0):ToHex(),

			Colors_Text_Primary = Color3.fromRGB(255, 255, 255):ToHex(),
			Colors_Text_Secondary = Color3.fromRGB(100, 100, 100):ToHex(),

			FontSizes_Editor = 16,
			TextboxWrapper = false,
			Anim_Quality = "High",
			Country_Code = "EN",
			UI_WindowState = 1,
			
			User_AI_OpenAI = "",
			User_Intro = true,
			User_EMail = "",
			
			Setting_Fps = 60,
			Settings_Afk = false,

			Fonts_HeadingItalic = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium, Enum.FontStyle.Italic),
			Fonts_Description = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), -- Descrizioni secondarie o testi leggeri
			Fonts_Editor = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Fonts_Black = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), -- Titoli principali
			Fonts_Heading = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), -- Sottotitoli o intestazioni
			Fonts_Body = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), -- Testo principale
			Fonts_Caption = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Thin, Enum.FontStyle.Italic), -- Annotazioni, piccole etichette
			Fonts_Title = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal) -- Titoli principali
		}
	}
	
	framework.protected:ProtectTable(OS_CONFIGS)
	framework.protected:ProtectTable(EXPLOIT_CONFIGS)
end

local ARCEUS_FOLDERS do
	ARCEUS_FOLDERS = framework.protected:GCProtect({
		AUTOEXECUTE = framework.storage:CreateDirectory(LPH_ENCSTR("autoexecute"), LPH_ENCSTR("Autoexec")),
		SCRIPT_HUB = framework.storage:CreateDirectory(LPH_ENCSTR("scripthub"), LPH_ENCSTR("Script Hub")),
		WORKSPACE = framework.storage:CreateDirectory(LPH_ENCSTR("workspace"), LPH_ENCSTR("Workspace")),--OS_CONFIGS.IS_IOS and "" or LPH_ENCSTR("Workspace")),
		CONFIGS = framework.storage:CreateDirectory(LPH_ENCSTR("configs"), LPH_ENCSTR("Configs"))
	})

	-- Sub directories
	ARCEUS_FOLDERS.CACHE = ARCEUS_FOLDERS.WORKSPACE:AddSubDirectory(LPH_ENCSTR("cache"), OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("AxCache")) -- Hidden folders should not show pictures in gallery
	ARCEUS_FOLDERS.TABS = ARCEUS_FOLDERS.SCRIPT_HUB:AddSubDirectory(LPH_ENCSTR("tabs"), LPH_ENCSTR("Tabs"))
	ARCEUS_FOLDERS.RAW = ARCEUS_FOLDERS.CONFIGS:AddSubDirectory(LPH_ENCSTR("raw"), LPH_ENCSTR("Raw"))

	-- block folders in workspace
	local blocked = framework.protected:GCProtect({ "axcache" })
	local lower, match, err = framework.protected:GetFunction(framework.utils.strings.lower),
		framework.protected:GetFunction(framework.utils.strings.match), framework.protected:GetFunction(error)

	local writefile = framework.env.getgenv().writefile or function() end
	framework.protected:GCProtect(writefile) -- protects the original
	writefile = framework.protected:GetFunction(writefile)

	local wf = function(path: string, ...)
		local low = lower(path)
		for _, folder in blocked do
			if match(low, "^" ..folder)
				or match(low, "^/" ..folder)
				or match(low, "^\\" ..folder)

			then return err(LPH_ENCSTR("Attempt to write in a restricted folder")) end
		end
		writefile(path, ...)
	end
	framework.env.getgenv().writefile = wf

	-- clear cache
	for _, file in ipairs(ARCEUS_FOLDERS.CACHE:ListFiles()) do
		framework.storage.deleteFile(nil, file)
	end
	
	framework.protected:ProtectTable(ARCEUS_FOLDERS)
end

-- Configure
framework.enums:AddEnum("TabUpdate", "Name", "Source", "Removed", "Selected", "Unselected")
framework.enums:AddEnum("WindowState", "Base", "Large", "Full")
framework.enums:AddEnum("AnimQuality", "Low", "Medium", "High")
framework.enums:AddEnum("CountryCode", "EN","IT","VI","PT","ID","RU","DE","ES","FR","ZH","JA","AR","HI","TH")

framework.enums:AddEnum("ScriptBloxSort", "None", "CreatedAt", "UpdatedAt", "Views", "LikeCount", "DislikeCount")
framework.enums:AddEnum("ScriptBloxVerify", "None", "Verified", "Unverified")
framework.enums:AddEnum("ScriptBloxType", "None", "Universal", "Specific")
framework.enums:AddEnum("ScriptBloxPatch", "None", "Patched", "Unpatched")
framework.enums:AddEnum("ScriptBloxSearch", "None", "Default", "Strict")
framework.enums:AddEnum("ScriptBloxAuth", "None", "Key", "Keyless")
framework.enums:AddEnum("ScriptBloxOrder", "None", "Asc", "Desc")
framework.enums:AddEnum("ScriptBloxMode", "None", "Free", "Paid")

framework.console:SetTitle(EXPLOIT_CONFIGS.EXPLOIT_FULLNAME)
framework.protected:UseUndetectedContent(not framework.protected:IsStudio())

framework.settings:SetDirectory(ARCEUS_FOLDERS.CONFIGS)
framework.settings:SetFileName(EXPLOIT_CONFIGS.SETTINGS_FILE)
framework.settings:SetFileKey(EXPLOIT_CONFIGS.FILES_KEY)
framework.settings:SetDefault(EXPLOIT_CONFIGS.SETTINGS)

task.spawn(LPH_NO_VIRTUALIZE(function() -- SaveInstances
	if true or framework.protected:IsStudio() then return end -- disabled
	
	local httpService = framework.protected:GetService("HttpService")
	local jsonDecode = framework.env.clonefunction(httpService.JSONDecode);
	local getScriptBytecode = framework.env.getscriptbytecode;
	local isA = framework.env.clonefunction(workspace.IsA);

	local data = {
		compatiblity = {
			binaryStrings = select(1, pcall(framework.env.gethiddenproperty or function() return game.CauseMeAnError; end, workspace.Terrain, "MaterialColors")) == true,
			sharedStrings = select(1, pcall(framework.env.gethiddenproperty or function() return game.CauseMeAnError; end, Instance.new("Model"), "ModelMeshData")) == true
		},
		xml = {
			cframeComponents = { "X", "Y", "Z", "R00", "R01", "R02", "R10", "R11", "R12", "R20", "R21", "R22" },
			customPhysicsComponents = { "Density", "Friction", "Elasticity", "FrictionWeight", "ElasticityWeight" };
			overwrites = {
				EnumItem = "token",
				Rect = "Rect2D"
			},
			pattern = "[&<>\"'\0]",
			escapes = {
				["<"] = "&lt;",
				[">"] = "&gt;",
				["\""] = "&quot;",
				["'"] = "&apos;",
				["&"] = "&amp;",
				["\0"] = ""
			}
		},
		classes = {
			overwrites = {
				Enum = "EnumItem",
				Class = "Ref"
			},
			folders = {
				[""] = true,
				["Player"] = true,
				["PlayerGui"] = true,
				["PlayerScripts"] = true
			}
		}
	};

	--[[ Base Functions ]]--

	local function shallowMerge(priority: {string: any}, backup: {string: any}): {string: any}
		if type(backup) == "table" then
			for i, v in priority do
				local backupValue = backup[i];
				if type(v) == type(backupValue) then
					priority[i] = backupValue;
				end
			end
		end
		return priority;
	end

	local function newHandler(modifier: (number) -> (string)): {string: any}
		return setmetatable({
			count = 0,
			cache = {}
		}, {
			__index = function(t, k)
				if t.cache[k] == nil then
					t.count += 1;
					t.cache[k] = modifier(t.count);
				end
				return t.cache[k];
			end
		});
	end

	--[[ Instance Checks ]]--

	local function isService(className: string): boolean
		return data.api[className] and data.api[className].isService;
	end

	local function isViableDecompileScript(scriptInstance: BaseScript): boolean
		if scriptInstance:IsA("ModuleScript") then
			return true;
		elseif scriptInstance:IsA("LocalScript") and (scriptInstance.RunContext == Enum.RunContext.Client or scriptInstance.RunContext == Enum.RunContext.Legacy) then
			return true;
		elseif scriptInstance:IsA("Script") and scriptInstance.RunContext == Enum.RunContext.Client then
			return true;
		end
		return false;
	end

	local function getProperty(object: Instance, name: string, value: {string: any}): (boolean, any)
		local success, grabbedValue;
		if value.isHidden then
			if value.valueType == "BinaryString" and data.compatiblity.binaryStrings == false then
				return false;
			elseif value.valueType == "SharedString" and data.compatiblity.sharedStrings == false then
				return false;
			end
			success, grabbedValue = pcall(framework.env.gethiddenproperty, object, name);
		else
			success, grabbedValue = pcall(function()
				return object[name];
			end);
		end
		return success, grabbedValue;
	end

	--[[ Conversion ]]--

	local function convertToBitValue(...: {any}): number
		local value = 0;
		for i, v in {...} do
			if v then
				value += 2 ^ (i - 1);
			end
		end
		return value;
	end

	local function sanitiseStringValue(value: string): string
		return string.gsub(value, data.xml.pattern, data.xml.escapes);
	end

	local function sanitiseNumberValue(value: number, denominations: number): string
		if value == 0 or value % 1 == 0 then
			return value;
		elseif value == math.huge then
			return "INF";
		elseif value == -math.huge then
			return "-INF";
		elseif value ~= value then
			return "NAN";
		elseif denominations == nil then
			return value;
		end
		return string.format("%." .. denominations .. "g", value);
	end

	--[[ Api ]]--

	local function getClassFromApi(api: {string: any}, class: string): {string: any}
		for _, v in api.Classes do
			if v.Name == class then
				return v;
			end
		end
	end

	local function pullApi(): {string: any}
		local latestVersion = nil;
		local versionArray = string.split(game:HttpGet("https://setup.rbxcdn.com/DeployHistory.txt", true), "\n");
		for i = #versionArray, 1, -1 do
			local versionData = string.split(versionArray[i], " ");
			if versionData[2] == "Studio64" then
				latestVersion = versionData[3];
				break;
			end
		end
		return httpService:JSONDecode(game:HttpGet("http://setup.roblox.com/" .. latestVersion .. "-Full-API-Dump.json", true));
	end

	local function generatePropertyData(api: {string: any}, class: {string: any}): {string: any}
		local currentClass = class;
		local changes = 0;
		local properties = {};
		while currentClass and currentClass.Name ~= "<<<ROOT>>>" do
			for _, v in currentClass.Members do
				if v.MemberType == "Property" and v.Name ~= "Parent" and v.Serialization.CanLoad and v.Serialization.CanSave then
					properties[v.Name] = {
						valueType = data.classes.overwrites[v.ValueType.Category] or v.ValueType.Name,
						isHidden = v.Tags and table.find(v.Tags, "NotScriptable")
					};
				end
			end
			currentClass = getClassFromApi(api, currentClass.Superclass);
			changes += 1;
		end
		return properties;
	end

	local function generateClassData(api: {string: any}): {string: any}
		local generatedClassData = {};
		for _, v in api.Classes do
			local classData = {
				properties = generatePropertyData(api, v),
				defaults = {},
				isService = v.Tags and table.find(v.Tags, "Service")
			};
			local success, instance = pcall(Instance.new, v.Name);
			if success then
				for i2, v2 in classData.properties do
					local success2, value = getProperty(instance, i2, v2);
					if success2 then
						classData.defaults[i2] = value;
					end
				end
			end
			generatedClassData[v.Name] = classData;
		end
		return generatedClassData;
	end

	--[[ Saveinstance Module ]]--

	local saveinstanceModule = {};
	saveinstanceModule.__index = saveinstanceModule;

	function saveinstanceModule.new(options: {string: any}): {string: any}
		local metatable = setmetatable({
			database = { "<roblox xmlns:xmime=\"http://www.w3.org/2005/05/xmlmime\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"http://www.roblox.com/roblox.xsd\" version=\"4\">" },
			options = options,
			instances = 0,
			exclusions = {
				game:GetService("CoreGui"),
				game:GetService("CorePackages"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("PlayerModule"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("PlayerScriptsLoader"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("RbxCharacterSounds")
			},
			decompiled = {},
			refHandler = newHandler(function(count)
				return "RBX" .. count;
			end),
			sharedStringHandler = newHandler(function(count)
				return framework.utils.crypt.base64.encode(tostring(count + 1e15));
			end)
		}, saveinstanceModule);

		for i, v in metatable.exclusions do
			if isViableDecompileScript(v) then
				metatable.exclusions[i] = framework.env.getscripthash(v);
			end
		end

		return metatable;
	end

	function saveinstanceModule:IsExcludedItem(object: Instance): boolean
		local isScript = isViableDecompileScript(object);
		for _, v in self.exclusions do
			if v == object then
				return true;
			elseif isScript and type(v) == "string" then
				local s, r = pcall(framework.env.getscripthash, object);
				if s and r == v then
					return true;
				end
			end
		end
		if object:IsA("Player") then
			return true;
		end
		return false;
	end

	function saveinstanceModule:CreateBaseDirectory(name: string): Folder
		local folder = Instance.new("Folder");
		folder.Name = name;
		task.defer(function()
			folder:Destroy();
		end);
		return folder;
	end

	function saveinstanceModule:GetProperty(object: Instance, name: string, value: {string: any}): (boolean, any)
		if name == "Source" and self.decompiled[object] then
			return true, self.decompiled[object];
		end
		return getProperty(object, name, value);
	end

	function saveinstanceModule:ParseProperty(value: any, valueType: string, bypassSanitising: boolean): string
		if valueType == "Axes" then
			return string.format("<axes>%d</axes>", convertToBitValue(value.X, value.Y, value.Z));
		elseif valueType == "BinaryString" then
			return value == "" and "" or self:ParseProperty(framework.utils.crypt.base64.encode(value), "ProtectedString");
		elseif valueType == "bool" then
			return value and "true" or "false";
		elseif valueType == "BrickColor" then
			return value.Number;
		elseif valueType == "CFrame" or valueType == "CoordinateFrame" then
			local ret = "";
			for _, v in data.xml.cframeComponents do
				ret ..= string.format("<%s>%%g</%s>", v, v);
			end
			return string.format(ret, value:GetComponents());
		elseif valueType == "Color3" then
			return string.format("<R>%g</R><G>%g</G><B>%g</B>", value.R, value.G, value.B);
		elseif valueType == "Color3uint8" then
			return 0xFF000000 + (math.floor(value.R * 255) * 0x10000) + (math.floor(value.G * 255) * 0x100) + math.floor(value.B * 255)
		elseif valueType == "ColorSequence" then
			local ret = {};
			for _, v in value.Keypoints do
				ret[#ret + 1] = string.format("%g %g %g %g 0", v.Time, v.Value.R, v.Value.G, v.Value.B);
			end
			return table.concat(ret, " ");
		elseif valueType == "Content" or valueType == "ContentId" then
			if value == "" then
				return "<null></null>";
			end
			return string.format("<url>%s</url>", sanitiseStringValue(value));
		elseif valueType == "DateTime" then
			return value.UnixTimestampMillis;
		elseif valueType == "double" then
			return sanitiseNumberValue(value, 16);
		elseif valueType == "EnumItem" then
			return value.Value;
		elseif valueType == "Faces" then
			return string.format("<faces>%d</faces>", convertToBitValue(value.Right, value.Top, value.Back, value.Left, value.Bottom, value.Front));
		elseif valueType == "float" then
			return sanitiseNumberValue(value, 8);
		elseif valueType == "Font" then
			return string.format("<Family>%s</Family><Weight>%s</Weight><Style>%s</Style>", self:ParseProperty(value.Family, "Content"), value.Weight.Value, value.Style.Name);
		elseif valueType == "int" or valueType == "int64" then
			return sanitiseNumberValue(value);
		elseif valueType == "NumberRange" then
			return string.format("%g %g", value.Min, value.Max);
		elseif valueType == "NumberSequence" then
			local ret = {};
			for _, v in value.Keypoints do
				ret[#ret + 1] = string.format("%g %g %g", v.Time, v.Value, v.Envelope);
			end
			return table.concat(ret, " ");
		elseif valueType == "PhysicalProperties" then
			local ret = string.format("<CustomPhysics>%s</CustomPhysics>", value and "true" or "false");
			if value then
				for _, v in data.xml.customPhysicsComponents do
					ret ..= string.format("<%s>%g</%s>", v, value[v], v);
				end
			end
			return ret;
		elseif valueType == "ProtectedString" then
			return string.format("<![CDATA[%s]]>", bypassSanitising and value or sanitiseStringValue(value));
		elseif valueType == "Ray" then
			return string.format("<origin>%s</origin><direction>%s</direction>", self:ParseProperty(value.Origin, "Vector3"), self:ParseProperty(value.Direction, "Vector3"));
		elseif valueType == "Rect" then
			return string.format("<min>%s</min><max>%s</max>", self:ParseProperty(value.Min, "Vector2"), self:ParseProperty(value.Max, "Vector2"));
		elseif valueType == "Ref" then
			return value and self.refHandler[value] or "null";
		elseif valueType == "SharedString" then
			return self.sharedStringHandler[framework.utils.crypt.base64.encode(value)];
		elseif valueType == "string" then
			return sanitiseStringValue(value);
		elseif valueType == "UDim" then
			return string.format("<S>%g</S><O>%d</O>", value.Scale, value.Offset);
		elseif valueType == "UDim2" then
			return string.format("<XS>%g</XS><XO>%d</XO><YS>%g</YS><YO>%d</YO>", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset);
		elseif valueType == "UniqueId" then
			return false;
		elseif valueType == "Vector2" or valueType == "Vector2int16" then
			return string.format("<X>%g</X><Y>%g</Y>", value.X, value.Y);
		elseif valueType == "Vector3" or valueType == "Vector3int16" then
			return string.format("<X>%g</X><Y>%g</Y><Z>%g</Z>", value.X, value.Y, value.Z);
		end
		-- print("Unaccounted for type found:", valueType);
		return "";
	end

	function saveinstanceModule:GetPropertyXml(propertyName: string, value: any, valueType: string): string
		local xmlValue = self:ParseProperty(value, valueType, propertyName == "Source");
		local newTag = data.xml.overwrites[valueType] or valueType;
		local xmlString = string.format("<%s name=\"%s\">%s</%s>", newTag, propertyName, xmlValue or "", newTag);
		if xmlValue then
			return xmlString;
		end
		return "<!-- " .. xmlString .. " -->";
	end

	function saveinstanceModule:ParseObject(object: Instance, altChildren: {number: Instance} | nil): nil
		if self:IsExcludedItem(object) then
			return;
		end

		local className = data.classes.folders[object.ClassName] and "Folder" or object.ClassName;
		table.insert(self.database, string.format("<Item class=\"%s\" referent=\"%s\">", className, self.refHandler[object]));

		local objectData = data.api[className];
		if objectData then
			table.insert(self.database, "<Properties>");
			for i, v in objectData.properties do
				local success, grabbedValue = self:GetProperty(object, i, v);
				if success and (self.options.excludeDefaults == false or grabbedValue ~= objectData.defaults[i]) then
					if typeof(grabbedValue) ~= "Content" then
						table.insert(self.database, self:GetPropertyXml(i, grabbedValue, v.valueType));
					end
				end
			end
			table.insert(self.database, "</Properties>");
			self.instances += 1;
		else
			-- print("Unaccounted for className found:", object:GetFullName());
		end

		for _, v in altChildren or object:GetChildren() do
			self:ParseObject(v);
		end

		table.insert(self.database, "</Item>");
	end

	function saveinstanceModule:AppendSharedStrings()
		if self.sharedStringHandler.count > 0 then
			table.insert(self.database, "<SharedStrings>");
			for i, v in self.sharedStringHandler.cache do
				table.insert(self.database, string.format("<SharedString md5=\"%s\">%s</SharedString>", v, i));
			end
			table.insert(self.database, "</SharedStrings>");
		end
	end

	function saveinstanceModule:CollectScripts(inst: Instance | {number: Instance}, cache: {number: Instance} | nil): {number: Instance}
		local store = cache or {};
		for i, v in typeof(inst) == "table" and inst or inst:GetChildren() do
			if not self:IsExcludedItem(v) then
				if isViableDecompileScript(v) then
					store[#store + 1] = v;
				end
				self:CollectScripts(v, store);
			end
		end
		return store;
	end

	function saveinstanceModule:Decompile()
		local scripts = self:CollectScripts(game);
		if self.options.includeNil then
			self:CollectScripts(framework.env.getnilinstances(), scripts);
		end
		framework.console.info("Collected Scripts! Decompiling..");
		for i, v in framework.env.decompile(scripts, "debug") do
			self.decompiled[scripts[i]] = v;
		end
	end

	function saveinstanceModule:Save(): nil
		local tick1 = tick();
		if data.api == nil then
			framework.console.info("Grabbing API..");
			data.api = generateClassData(pullApi());
		end

		if self.options.excludeScripts then
			framework.console.info("Grabbed API! Parsing map..");
		else
			framework.console.info("Grabbed API! Collecting scripts..");
			self:Decompile();
			framework.console.info("Decompiled! Parsing map..");
		end

		local tick2 = tick();
		local gameChildren = {};

		for _, v in game:GetChildren() do
			if isService(v.ClassName) then
				self:ParseObject(v);
			else
				table.insert(gameChildren, v);
			end
		end

		if self.options.includeNil then
			local nilInstances = framework.env.getnilinstances(); -- This happens first so it doesn't put itself in the folder
			self:ParseObject(self:CreateBaseDirectory("Nil Instances"), nilInstances);
		end

		if #gameChildren > 0 then
			self:ParseObject(self:CreateBaseDirectory("Game Instances"), gameChildren);
		end

		self:AppendSharedStrings();

		table.insert(self.database, "</roblox>");
		local tick3 = tick();
		
		ARCEUS_FOLDERS.WORKSPACE:WriteFile(self.options.fileName .. ".rbxlx", table.concat(self.database, ""));
		local endTick = tick();
		
		framework.console.print([[Saveinstance finished!
Time taken (api grab): ]] .. tostring(math.floor((tick2 - tick1) * 1000)) .. [[ms
Time taken (computing): ]] .. tostring(math.floor((tick3 - tick2) * 1000)) .. [[ms
Time taken (average per instance): ]] .. tostring(math.floor(((tick3 - tick2) / self.instances) * 1000)) .. [[ms
Time taken (write): ]] .. tostring(math.floor((endTick - tick3) * 1000)) .. [[ms
Time taken (total): ]] .. tostring(math.floor((endTick - tick1) * 1000)) .. [[ms]]);
	end

	--[[ Environment ]]--
	framework.env.getgenv().saveinstance = function(options: {string: any} | nil)
		framework.console.info("'Saveinstance' is now initiated..")
		saveinstanceModule.new(shallowMerge({
			fileName = tostring(game.PlaceId),
			includeNil = true,
			excludeScripts = false,
			excludeDefaults = true
		}, options)):Save();
	end;
end))

-- Create dependencies
do -- gui
	local this, utils = {}, {}
this.utils = utils

if not LPH_OBFUSCATED then -- Luraph integration
	local dummy = function(...) return ... end
	LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or dummy
	LPH_NO_UPVALUES = LPH_NO_UPVALUES or dummy
	LPH_OBFUSCATED = LPH_OBFUSCATED or false
	LPH_JIT_MAX = LPH_JIT_MAX or dummy
	LPH_ENCFUNC = LPH_ENCFUNC or dummy
	LPH_ENCSTR = LPH_ENCSTR or dummy
	LPH_ENCNUM = LPH_ENCNUM or dummy
	LPH_CRASH = LPH_CRASH or dummy
	LPH_JIT = LPH_JIT or dummy
end

function utils:CreateDummy(parent: Instance?)
	return self.ui:AddInstance("Frame", {
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		Parent = parent
	})
end

function utils:GetStartCoords(): Vector2
	local obj = self:CreateDummy()
	local coords = obj.instance.AbsolutePosition
	obj:Remove()

	return coords
end

function utils:GetScreenRatio(parent: Instance?): number
	local obj = self:CreateDummy(parent)
	local viewportSize = obj.instance.AbsoluteSize
	obj:Remove()

	local width, height = viewportSize.X, viewportSize.Y
	return self.player_gui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
		and height / width or width / height
end

function utils:GetSafeScreenRatio(): number
	local ui = self.framework.interface.new()
	ui.instance.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	ui.instance.IgnoreGuiInset = true

	local ratio = self:GetScreenRatio(ui)
	ui:Remove()
	return ratio
end

function utils:GetPadding(): number
	return (utils.player_gui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait and
		self.ui.instance.AbsoluteSize.X or self.ui.instance.AbsoluteSize.Y) *12 /1080
end

function utils:GetAnimationResolution(quality: string)
	quality = quality or utils.framework.settings:GetDefaultSetting("Anim_Quality")
	quality = utils.framework.enums.AnimQuality[quality]

	return ({Vector2.new(32, 32), Vector2.new(64, 64), Vector2.new(128, 128)})[quality]
end

function utils:GetAnimationDensity(quality: string, duration: string)
	quality = quality or utils.framework.settings:GetDefaultSetting("Anim_Quality")
	quality = utils.framework.enums.AnimQuality[quality]
	duration = duration or 1

	return ({24 *duration, 32 *duration, 64 *duration})[quality]
end

function utils:AddAnimation(id: string, options: {any}, frameGen: (idx: number, frames: number) -> buffer, priority: number, ...: any)
	local quality = utils.framework.settings:GetDefaultSetting("Anim_Quality")
	local res = options.Resolution

	options.Resolution = res or self:GetAnimationResolution(quality)
	options.Density = options.Density or self:GetAnimationDensity(quality, options.Duration)

	local raws = utils.framework.storage:GetDirectory("raw")
	local content = options.raw

	if not content and not raws:IsFile(id) and not utils.framework.protected:IsStudio() then
		local res = utils.framework.dependencies.exploit:DownloadFile(`/raw/{id}`)
		if res then raws:WriteFile(id, res)
			content = res
		end
	end

	local anim = utils.framework.animator.fromRaw(id, options, content or raws:ReadFile(id), frameGen)
	anim.RenderOnLoad = options.RenderOnLoad
	anim.Duration = options.Duration
	anim.FixedResolution = res

	for _, tag in ipairs(options.Tags or {}) do
		utils.animsTags[tag] = utils.animsTags[tag] or {}
		utils.framework.utils.tables.insert(utils.animsTags[tag], anim)
	end

	function anim:Save()
		if not anim.Loaded then return end
		raws:WriteFile(id, anim:GetRaw())
	end

	if utils.framework.protected:IsStudio() then
		local fps = anim:GetMaxFPS();
		(fps < 24 and utils.framework.console.warn or utils.framework.console.print
		)(`Animation '{id}' running at max: {fps} FPS`)
	end

	utils.framework.utils.tables.insert(utils.anims, anim)
	return anim
end

function utils:GetAnimation(id: string)
	return utils.framework.renderer:GetBinding(id)
end

function utils:GetAnimationByTag(tag: string)
	return utils.animsTags[tag] or {}
end

function utils:Translate(texts: {string})
	local value = utils.framework.enums.CountryCode[utils.framework.settings:GetSetting("Country_Code")]
		or utils.framework.enums.CountryCode[utils.framework.settings:GetDefaultSetting("Country_Code")]

	return texts[value]
end

function utils:Setup(framework, ui)
	utils.framework = framework
	utils.ui = ui

	--utils.color_properties = framework.protected:GCProtect({"BackgroundColor3", "TextColor3", "BorderColor3", "ImageColor3", "GroupColor3", "TextStrokeColor3", "ScrollBarImageColor3", "PlaceholderColor3", "VideoColor3", "SurfaceColor3", "HoverBackgroundColor3", "SelectedTabTextColor3"})
	utils.anims = framework.protected:GCProtect({})
	utils.animsTags = framework.protected:GCProtect({})
	utils.player_gui = framework.protected:GetService("Players")
		.LocalPlayer:WaitForChild("PlayerGui")

	-- load settings
	local arceus_layout, cache = {}, framework.protected:GCProtect({})
	framework.env.getgenv().arceus_layout = arceus_layout

	framework.settings.OnSettingChanged:Connect(framework.protected:GCProtect(LPH_JIT_MAX(function(setting: string, value: any, default: any)
		if utils.framework.utils.strings.sub(setting, 1, 5) == "User_" then
			return -- Prevents data from being set in arceus_layout

		elseif utils.framework.utils.strings.sub(setting, 1, 7) == "Colors_" then
			local succ, err = pcall(Color3.fromHex, value)
			value = succ and err or Color3.fromHex(default)

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local props = inst[setting]
				if not props then continue end

				if typeof(props) == "function" then
					props(value)
					continue
				end

				for _, prop in ipairs(props) do
					inst.instance[prop] = value
				end
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 10) == "FontSizes_" then
			value = tonumber(value) or default
			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				inst.instance.TextSize = value
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 6) == "Fonts_" then
			local font = default
			if typeof(value) == "string" then
				font = framework.utils.strings.fromFormatted(value)
			end

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				inst.instance.FontFace = font
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 14) == "UI_WindowState" then
			value = framework.utils.maths.clamp(value, framework.enums.WindowState.Base, framework.enums.WindowState.Full)
			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local props = inst[setting]
				if not props then continue end

				for prop, values in pairs(props) do
					cache[inst] = cache[inst] or {}
					cache[inst][prop] = cache[inst][prop] or inst.instance[prop]
					inst.instance[prop] = values[value] or cache[inst][prop]
				end
			end

		elseif setting == "Country_Code" then
			value = utils.framework.enums.CountryCode[value]
				or utils.framework.enums.CountryCode[default]

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local onCC = inst[`On_{setting}`]
				if onCC then onCC(value) end
				
				local translations = inst[setting]
				if translations and (translations[value] or translations[1]) then
					inst.instance.Text = translations[value] or translations[1]
				end

				translations = inst[`{setting}_Placeholder`]
				if not translations or not (translations[value] or translations[1]) then continue end
				inst.instance.PlaceholderText = translations[value] or translations[1]
			end	
		end

		arceus_layout[setting] = value
	end)))

	function utils:EndSetup()
		ui.OnInstanceAdded:Connect(framework.protected:GCProtect(LPH_JIT_MAX(function(inst)
			for _, tag in ipairs(inst:GetTags()) do
				local default = framework.settings:GetDefaultSetting(tag)
				local value = framework.settings:GetSetting(tag)
				if not value and not default then continue end

				if utils.framework.utils.strings.sub(tag, 1, 7) == "Colors_" then
					local props = inst[tag]
					if not props then continue end

					local succ, err = pcall(Color3.fromHex, value)
					value = succ and err or Color3.fromHex(default)
					
					if typeof(props) == "function" then
						props(value)
						continue
					end

					for _, prop in ipairs(props) do
						inst.instance[prop] = value
					end

				elseif utils.framework.utils.strings.sub(tag, 1, 10) == "FontSizes_" then
					value = tonumber(value) or default
					inst.instance.TextSize = value

				elseif utils.framework.utils.strings.sub(tag, 1, 6) == "Fonts_" then
					local font = default
					if typeof(value) == "string" then
						font = framework.utils.strings.fromFormatted(value)
					end
					inst.instance.FontFace = font

				elseif utils.framework.utils.strings.sub(tag, 1, 14) == "UI_WindowState" then
					local props = inst[tag]
					if not props then continue end

					value = framework.utils.maths.clamp(value, framework.enums.WindowState.Base, framework.enums.WindowState.Full)
					for prop, values in pairs(props) do
						cache[inst] = cache[inst] or {}
						cache[inst][prop] = cache[inst][prop] or inst.instance[prop]
						inst.instance[prop] = values[value] or cache[inst][prop]
					end

				elseif tag == "Country_Code" then
					local translations = inst[tag]
					value = utils.framework.enums.CountryCode[value]
						or utils.framework.enums.CountryCode[default]

					if translations and (translations[value] or translations[1]) then
						inst.instance.Text = translations[value] or translations[1]
					end

					translations = inst[`{tag}_Placeholder`]
					if not translations or not (translations[value] or translations[1]) then continue end
					inst.instance.PlaceholderText = translations[value] or translations[1]
				end
			end
		end)))
		
		local playerGui = framework.protected:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		local debounce = false
		
		playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(framework.protected:GCProtect(function()
			ui:Get("MainFrame").instance.Position = UDim2.fromScale(.5, .5)
			ui.nextSize(framework.enums.WindowState.Base)
			--[[ if debounce then return end
			debounce = true
			
			local rotation = playerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait and 0 or -90
			for _, child in ipairs(ui.instance:GetChildren()) do
				if child:IsA("GuiObject") then child.Rotation = rotation end
			end
			
			debounce = false ]]
		end))
	end

	framework.settings:GetSettingChangedSignal(LPH_ENCSTR("User_EMail")):Connect(framework.protected:GCProtect(function(value: string)
		local emailBox = ui:Get(LPH_ENCSTR("EmailBox"))
		if not emailBox then return end
		emailBox.instance.Text = tostring(value)
	end))

	framework.settings:GetSettingChangedSignal("Anim_Quality"):Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(value: string)
		if not utils.animsInitialized then return end
		for _, anim in ipairs(utils.anims) do
			local value = anim.FixedResolution or value

			anim:Generate(utils:GetAnimationResolution(value), utils:GetAnimationDensity(value, anim.Duration))
			anim:Save()

			if anim.RenderOnLoad then anim:Render() end
		end
	end)))

	ui.OnInstanceAdded:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(inst)
		if inst.instance:IsA("GuiButton") then
			inst.instance.MouseButton1Down:Connect(function()
				utils:Vibrate(Enum.HapticEffectType.UIClick)
			end)
		end
	end)))

	local uis = framework.protected:GetService("UserInputService")
	local run = framework.protected:GetService("RunService")
	local fakeFocus = false

	uis.TextBoxFocused:Connect(LPH_NO_VIRTUALIZE(function(tb: TextBox)
		local custom = ui:Get(tb)
		if custom and custom:HasTags("No_Focus") then return end
		
		local overall = framework.settings:GetSetting("TextboxWrapper")
		if tb:IsDescendantOf(overall and ui.instance.Parent or ui.instance) and not tb.MultiLine then -- "blacklist"
			if fakeFocus then 
				fakeFocus = false
				return
			end
			
			local editable = tb.TextEditable
			run.Heartbeat:Wait()
			
			local toast = utils:ShowToast("InputToast", {
				PlaceholderText = {"Text here...","Testo qui...","Văn bản ở đây...","Texto aqui...","Teks di sini...","Текст здесь...","Text hier...","Texto aquí...","Texte ici...","文本在此...","ここにテキスト...","النص هنا...","यहाँ पाठ...","ข้อความที่นี่..."},
				Style = utils.currentPage.id == "Page_ArceusIntelligence" and "ai" or "info",
				Callback = function(txt: string)
					if editable then
						fakeFocus = true
						run.Heartbeat:Wait()
						tb:CaptureFocus()

						tb.Text = framework.utils.strings.sub(txt, 1, 199999)
						run.Heartbeat:Wait()
						tb:ReleaseFocus()
					end
				end
			})

			toast.instance.ZIndex = 999
			local customTb = toast.tb.instance
			local txt = tb.Text

			customTb.TextEditable = editable
			customTb.Text = txt

			customTb.CursorPosition = framework.utils.strings.len(txt) +1
		end
	end))

	local haptic: HapticEffect = ui:AddInstance("HapticEffect", {}).instance
	function utils:Vibrate(type: Enum.HapticEffectType, duration: number?)
		duration = tonumber(duration)

		haptic.Type = type or Enum.HapticEffectType.UINotification
		haptic.Looped = duration and true or false

		pcall(haptic.Play, haptic)
		if duration then
			task.wait(duration)
			pcall(haptic.Stop, haptic)
		end
	end
end

function utils:EditorMode(enabled: boolean, offset: number)
	local TweenService = game:GetService("TweenService")
	local main = utils.ui:Get("MainFrame").instance
	local newState, targetPos

	if enabled then
		utils.prevSate = utils.ui.windowState
		utils.prevPos = main.Position
		newState = utils.framework.enums.WindowState.Base
		-- targetPos = UDim2.fromScale(.5, offset) -- disabled after roblox keyboard updates
	else
		newState = utils.prevSate or utils.ui.windowState
		targetPos = utils.prevPos or main.Position
	end

	utils.ui.nextSize(newState)
	local tweenInfo = TweenInfo.new(.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tw = TweenService:Create(main, tweenInfo, { Position = targetPos })
	tw:Play()

	utils:AnimateCascade(utils.ui:Get("Page_Executor").instance, {
		TweenInfo    = TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		DelayBetween = .01,
		SkipTransparency = true,
		Direction = "BottomToTop" and enabled or "TopToBottom"
	})
end

function utils:GetTweenInfos(delay: number, duration: number, style: Enum.EasingStyle, direction: Enum.EasingDirection, rep: number, inv: boolean)
	return TweenInfo.new(duration or .25, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, rep or 0, inv or false, delay or 0)
end

function utils:ClosePopup()
	local pop = utils.lastPopup
	if pop then pop:Remove()
		utils.lastPopup = nil
		return true
	end
end

function utils:ShowPopup(class: string, ...: any)
	self:ClosePopup()
	utils.lastPopup = utils.ui:AddComponent(class, ...)
	utils:Vibrate(Enum.HapticEffectType.UINotification)
end

function utils:ShowToast(class: string, props: {any}, ...)
	local main = utils.ui:Get("MainFrame")
	main:Tween(utils:GetTweenInfos(), { GroupTransparency = .9 })

	local toast, once
	props.Close = function(...: any)
		if once then return end
		once = true
		
		toast:Remove()
		main:Tween(utils:GetTweenInfos(), { GroupTransparency = 0 })
		if props.Callback then props.Callback(...) end
	end

	toast = utils.ui:AddComponent(class, props, ...)

	if utils.ui:Get(`{class}_{props.Id}`) then
		utils.AnimateCascade(utils.ui:Get(`{class}_{props.Id}`).instance,{
			DelayBetween = .5,
			TweenInfo = TweenInfo.new(5,  Enum.EasingStyle.Back,   Enum.EasingDirection.Out),
		})
	end

	utils:Vibrate(Enum.HapticEffectType.UINotification)
	return toast
end

utils.AnimateCascade = LPH_NO_VIRTUALIZE(function(self, frameParam, opts)
	if not utils.ui.Loaded then return end

	local TweenService = utils.framework.protected:GetService("TweenService")
	opts = opts or {}

	local rawOffset = opts.StartOffset or opts.AnimateSelf and UDim2.new(0, 0, .015, 0) or UDim2.new(0, 0, .15, 0)
	local tweenInfo = opts.TweenInfo or TweenInfo.new(.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local delayBetween = opts.DelayBetween or .0075
	local globalLimit = opts.Limit
	local excludeNames = {}

	if opts.ExcludeNames then
		for _, name in ipairs(opts.ExcludeNames) do
			excludeNames[name] = true
		end
	end

	local scaleDirection = opts.ScaleDirection or "In"
	local scaleCascade = (opts.ScaleCascade == true)
	local startScaleOffset

	if type(opts.StartScaleOffset) == "number" then
		startScaleOffset = utils.framework.utils.maths.clamp(opts.StartScaleOffset, 0, utils.framework.utils.maths.huge)
	else
		startScaleOffset = (scaleDirection == "In") and .9 or 1.05
	end

	local skipTransparency = (opts.SkipTransparency == true)
	local animateSelf = (opts.AnimateSelf == true)
	local limitMap = opts.LimitMap or {}
	local startOffset

	if animateSelf then
		local vp = workspace.CurrentCamera.ViewportSize
		local offsetX = rawOffset.X.Scale * vp.X + rawOffset.X.Offset
		local offsetY = rawOffset.Y.Scale * vp.Y + rawOffset.Y.Offset
		startOffset = UDim2.new(0, utils.framework.utils.maths.floor(offsetX + .5), 0, utils.framework.utils.maths.floor(offsetY + .5))
	else
		startOffset = rawOffset
	end

	local root = utils.framework.utils.instances.getRobloxInstance(frameParam)
	if not root then return end
	local activeTweens = {}

	utils._cascadeOriginals = utils._cascadeOriginals or {}
	local objs = {}

	local collect; collect = function(parent)
		for _, child in ipairs(parent:GetChildren()) do	
			if child:IsA("GuiObject") and child.Visible then
				local inst = utils.ui:Get(child)
				if not inst or excludeNames[inst.id] then continue end

				utils.framework.utils.tables.insert(objs, child)
				collect(child)
			end
		end
	end

	collect(root)
	if animateSelf then
		utils.framework.utils.tables.insert(objs, 1, root)
	end

	for _, child in ipairs(objs) do
		if not utils._cascadeOriginals[child] then
			local hasText, textVal   = pcall(function() return child.TextTransparency end)
			local hasImage, imageVal = pcall(function() return child.ImageTransparency end)
			utils._cascadeOriginals[child] = {
				BackgroundTransparency = child.BackgroundTransparency,
				ImageTransparency = hasImage and imageVal or nil,
				TextTransparency = hasText  and textVal  or nil,
				Position = child.Position,
				Size = child.Size
			}
		end
	end

	for _, child in ipairs(objs) do
		local orig = utils._cascadeOriginals[child]
		if not skipTransparency then
			local t0 = (type(opts.StartTransparency) == "number")
				and utils.framework.utils.maths.clamp(opts.StartTransparency, 0, 1) or 1

			child.BackgroundTransparency = t0
			if orig.TextTransparency then
				child.TextTransparency = t0
			end

			if orig.ImageTransparency then
				child.ImageTransparency = t0
			end
		end

		if scaleCascade then
			local osz    = orig.Size
			local sStart = UDim2.new(
				osz.X.Scale * startScaleOffset,
				osz.X.Offset * startScaleOffset,
				osz.Y.Scale * startScaleOffset,
				osz.Y.Offset * startScaleOffset
			)

			local tweenerIn = TweenService:Create(child,
				TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Size = sStart })

			tweenerIn:Play()
			table.insert(activeTweens, tweenerIn)
		else
			local startPos = orig.Position + startOffset
			local tweenerIn = TweenService:Create(child,
				TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Position = startPos })

			tweenerIn:Play()
			table.insert(activeTweens, tweenerIn)
		end
	end

	task.spawn(function()
		task.wait(.15)
		local parentCounts = {}

		for i, child in ipairs(objs) do
			local orig   = utils._cascadeOriginals[child]
			local parent = child.Parent

			if not parent then continue end
			parentCounts[parent] = (parentCounts[parent] or 0) + 1

			local perLim = limitMap[parent]
			local count  = parentCounts[parent]
			local useIt
			if perLim then
				useIt = (count <= perLim)
			else
				useIt = (not globalLimit) or (i <= globalLimit)
			end

			if useIt then
				task.spawn(function()
					task.wait((i - 1) * delayBetween)

					local goal = {}
					if scaleCascade then
						goal.Size = orig.Size
					else
						goal.Position = orig.Position
					end
					if not skipTransparency then
						goal.BackgroundTransparency = orig.BackgroundTransparency
						if orig.TextTransparency then
							goal.TextTransparency = orig.TextTransparency
						end
						if orig.ImageTransparency then
							goal.ImageTransparency = orig.ImageTransparency
						end
					end

					local tweenerOut = TweenService:Create(child, tweenInfo, goal)
					tweenerOut:Play()
					utils.framework.utils.tables.insert(activeTweens, tweenerOut)
				end)
			else
				if scaleCascade then
					child.Size = orig.Size
				else
					child.Position = orig.Position
				end
				if not skipTransparency then
					child.BackgroundTransparency = orig.BackgroundTransparency
					if orig.TextTransparency then
						child.TextTransparency = orig.TextTransparency
					end
					if orig.ImageTransparency then
						child.ImageTransparency = orig.ImageTransparency
					end
				end
			end
		end

		task.wait((#objs * delayBetween) + tweenInfo.Time)
		for _, t in ipairs(activeTweens) do
			pcall(function() t:Cancel() end)
		end
	end)
end)

utils.AddSlimeEffect = LPH_NO_VIRTUALIZE(function(self, frameWrapper: {any}, targetWrappers: {any}, options: {any})
	local UserInputService: UserInputService = utils.framework.protected:GetService("UserInputService")
	local TweenService... (437 KB left)
