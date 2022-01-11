local ps = game:GetService("Players")
function StringToPlayer(p)
	for i,v in pairs(ps:GetPlayers()) do
		if v.Name:lower() == p:lower() then
			return v
		end
	end
	return nil
end
local http = game:GetService("HttpService")
local whitelisted = http:JSONDecode(http:JSONEncode(http:GetAsync("https://raw.githubusercontent.com/Sniperkaos/malignantlySSData/main/whitelist.lua")))

local precodedFunctions = http:GetAsync("https://raw.githubusercontent.com/Sniperkaos/malignantlySSData/main/functions.lua")
local updateData = http:JSONDecode(http:GetAsync("https://raw.githubusercontent.com/Sniperkaos/malignantlySSData/main/updatelog.json"))
coroutine.wrap(function()
	while wait(60) do
		updateData = http:JSONDecode(http:GetAsync("https://raw.githubusercontent.com/Sniperkaos/malignantlySSData/main/updatelog.json"))
	end
end)()
local functions = loadstring(precodedFunctions)()
print(functions)
function IsInputPrecodeFunction(i)
	for i2,v in pairs(functions) do
		if i2:lower() == i:lower() then
			return v
		end
	end
	return nil
end
local c_funcs = {
	["errorlog"] = function()
		workspace:FindFirstChild("MalignantlySSSound")
	end,
}
if game:GetService("Workspace"):FindFirstChild("MalignantlySS") then else
	local s,f = pcall(function()
		local MalignantlySS
		local MalignantlySSInternal
		local MalignantlySSSound
		if not workspace:FindFirstChild("MalignantlySS") then
			MalignantlySS = Instance.new("RemoteEvent")
			MalignantlySS.Name = "MalignantlySS"
			MalignantlySS.Parent = workspace
		end
		if not workspace:FindFirstChild("MalignantlySSInternal") then
			MalignantlySSInternal = Instance.new("RemoteFunction")
			MalignantlySSInternal.Name = "MalignantlySSInternal"
			MalignantlySSInternal.Parent = workspace
		end
		if not workspace:FindFirstChild("MalignantlySSSound") then
			MalignantlySSSound = Instance.new("Sound")
			MalignantlySSSound.Name = "MalignantlySSSound"
			MalignantlySSSound.Looped = true
			MalignantlySSSound.Parent = workspace
		end
		MalignantlySSInternal.OnServerInvoke = function(p,typ)
			if typ == "GetUpdateData" then
				return updateData
			elseif typ == "GetFunctions" then
				return loadstring(precodedFunctions)()
			end
		end
		local function join(t)
			local a = ""
			for i,v in pairs(t) do
				a = a .. v
			end
			return a
		end
		MalignantlySS.OnServerEvent:Connect(function(p,input,level)
			local str = string.match(input:lower(),"kick") or string.match(input:lower(),"loadstring") or string.match(input:lower(),"game:shutdown()") or string.match(input:lower(),"divinejudgement") or string.match(input:lower(),"playsound") or string.match(join(input:split(" ")),"whiletruedoend") or string.match(input:lower(),"")
			if level == 1 and str ~= nil then
				game.ReplicatedStorage.ClientEvents.TakeChat:FireClient(p,"[MalignantlySS] Your level is insufficient to use [" .. str .. "] in a script.")
				return
			end
			if typeof(input) == "string" then
				if IsInputPrecodeFunction(string.split(input, " ")[1]) ~= nil then
					local nstring = string.split(input," ")
					nstring[1] = nil
					functions[string.split(input," ")[1]](nstring)
				end
				input = string.gsub(input,"game.Players.LocalPlayer","game.Players." .. p.Name)
				if string.split(input," ")[1] == "GiveSS" and string.split(input," ")[2] and IsInputPrecodeFunction(string.split(input, " ")[1]) == nil then
					local pl = StringToPlayer(string.split(input," ")[2])
					if pl then
						for i,v in pairs(script:GetChildren()) do
							if v.Name ~= "c" and v.Name ~= "MalignantlySS" then
								local alx = v:Clone()
								alx.Parent = pl.PlayerGui
								if alx:IsA("LocalScript") then
									alx.Disabled = false
								end
							end
						end
					end
				elseif string.split(input," ")[1] == "DivineJudgement" and string.split(input," ")[2] and IsInputPrecodeFunction(string.split(input, " ")[1]) == nil then
						local pl = StringToPlayer(string.split(input," ")[2])
					if pl then
						require(script.Move)(pl)
					end
				elseif string.split(input," ")[1] == "PlaySound" and IsInputPrecodeFunction(string.split(input, " ")[1]) == nil then
					MalignantlySSSound.TimePosition = 0
					MalignantlySSSound.SoundId = string.split(input," ")[2]
					MalignantlySSSound.Playing = true
				else
					local s,f = pcall(function()
						coroutine.wrap(function()
							loadstring(input)()
						end)()
					end)
					if f then
						game.ReplicatedStorage.ClientEvents.TakeChat:FireClient(p,"[MalignantlySS] ERROR: " .. tostring(f))
					end
				end
			elseif typeof(input) == "function" then
				local s,f = pcall(function()
					input()
				end)
				if f then
					game.ReplicatedStorage.ClientEvents.TakeChat:FireClient(p,"[MalignantlySS] ERROR: " .. tostring(f))
				end
			end
		end)
	end)
	if f then
		game.ReplicatedStorage.ClientEvents.TakeChat:FireAllClients("[MalignantlySS] ERROR: " .. tostring(f))
	end
end
function StringToTable(str)
	local tbl = {}
	for i,v in pairs(string.split(str,",")) do
		local s = v
		s = string.gsub(v,"\n","")
		tbl[s] = true
	end
	return tbl
end
whitelisted = StringToTable(whitelisted)
print(whitelisted)
for i,v in pairs(whitelisted) do
	print(v)
end
for a,player in pairs(game:GetService("Players"):GetPlayers()) do
	if whitelisted[player.Name:lower()] == 1 then
		for i,v in pairs(script:GetChildren()) do
			if v.Name ~= "c" and v.Name ~= "MalignantlySS" and v.Name ~= "Move" and v.Name ~= "Parts" and v.Name == "Level1" then
				local alx = v:Clone()
				alx.Parent = player.PlayerGui
				if alx:IsA("LocalScript") then
					alx.Disabled = false
				end
			end
		end
	elseif whitelisted[player.Name:lower()] == 2 then
		for i,v in pairs(script:GetChildren()) do
			if v.Name ~= "c" and v.Name ~= "MalignantlySS" and v.Name ~= "Move" and v.Name ~= "Parts" and v.Name == "Level2" then
				local alx = v:Clone()
				alx.Parent = player.PlayerGui
				if alx:IsA("LocalScript") then
					alx.Disabled = false
				end
				game:GetService("LogService").MessageOut:Connect(function(m,t)
					game.ReplicatedStorage.ClientEvents.TakeChat:FireClient(player,"[MalignantlySS] [ServerErrorSpy]: " .. tostring(t) .. "! " .. tostring(m))
				end)
			end
		end
	end
end
