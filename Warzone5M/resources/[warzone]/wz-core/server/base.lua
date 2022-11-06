-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CORE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
CORECLIENT = Tunnel.getInterface("wz-core") -- "vRPC"

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CONNECTION ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE = {} -- "vRP"
tCORE = {}	-- "tvRP"
CORE.userIds = {}
CORE.userInfos = {}
CORE.userTables = {}
CORE.userSources = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ TUNNEL / PROXY ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Proxy.addInterface("wz-core",CORE)
Tunnel.bindInterface("wz-core",tCORE)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ MYSQL ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local mysqlDriver
local userSql = {}
local mysqlInit = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CACHE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local cacheQuery = {}
local cachePrepare = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETIDENTITIES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.getIdentities(source)
	local result = false
	local identifiers = GetPlayerIdentifiers(source)

	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end

	return result
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETPLAYERDISCORD ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.getPlayerDiscord(source)
	local result  = false
	local identifiers = GetPlayerIdentifiers(source)

	for _,v in pairs(identifiers) do
		if string.find(v,"discord") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end
	
	return result
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ REGISTERDBDRIVER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.registerDrivers(name,onInit,onPrepare,onQuery)
	if not userSql[name] then
		userSql[name] = { onInit,onPrepare,onQuery }
		mysqlDriver = userSql[name]
		mysqlInit = true

		for _,prepare in pairs(cachePrepare) do
			onPrepare(table.unpack(prepare,1,table.maxn(prepare)))
		end

		for _,query in pairs(cacheQuery) do
			query[2](onQuery(table.unpack(query[1],1,table.maxn(query[1]))))
		end

		cachePrepare = {}
		cacheQuery = {}
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PREPARE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.prepare(name,query)
	if mysqlInit then
		mysqlDriver[2](name,query)
	else
		table.insert(cachePrepare,{ name,query })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ QUERY ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.query(name,params,mode)
	if not mode then mode = "query" end

	if mysqlInit then
		return mysqlDriver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cacheQuery,{{ name,params or {},mode },r })
		return r:wait()
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ EXECUTE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.execute(name,params)
	return CORE.query(name,params,"execute")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CHECKBANNED ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.checkBanned(steam)
	local consult = CORE.query("accountsBanneds/getBanned",{ steam = steam })
	if consult[1] then
		local timeCheck = CORE.query("accountsBanneds/getTimeBanned",{ steam = steam })
		if timeCheck[1] ~= nil then
			CORE.execute("accountsBanneds/removeBanned",{ steam = steam })
			return false
		end

		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ INFOACCOUNT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.infoAccount(steam)
	local infoAccount = CORE.query("accountsMain/getInfos",{ steam = steam })
	return infoAccount[1] or false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERDATA ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.userData(user_id,key)
	local consult = CORE.query("accountsData/getUserdata",{ user_id = user_id, key = key })
	if consult[1] then
		return json.decode(consult[1]["dvalue"])
	else
		return {}
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERINVENTORY ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[function CORE.userInventory(user_id)
	local dataTable = CORE.getDatatable(user_id)
	if dataTable then
		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		return dataTable["inventory"]
	end

	return {}
end]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ UPDATESELECTSKIN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.updateSelectSkin(user_id,hash)
	local dataTable = CORE.getDatatable(user_id)
	if dataTable then
		dataTable["skin"] = hash
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETUSERID ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.getUserId(source)
	return CORE.userIds[parseInt(source)]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERLIST ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.userList()
	return CORE.userSources
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERPLAYERS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.userPlayers()
	return CORE.userIds
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETUSERSOURCE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.userSource(user_id)
	return CORE.userSources[parseInt(user_id)]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETDATATABLE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.getDatatable(user_id)
	return CORE.userTables[parseInt(user_id)] or false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERDROPPED ]]
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerDropped",function(reason)
	CORE.playerDropped(source,reason)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ KICK ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.kick(user_id,reason)
	local userSource = CORE.userSource(user_id)
	if userSource then
		CORE.playerDropped(userSource,"Kick/Afk")
		DropPlayer(userSource,reason)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERDROPPED ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.playerDropped(source,reason)
	local source = parseInt(source)
	local user_id = CORE.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Disconnect","**Source:** "..parseFormat(source).."\n**Passaporte:** "..parseFormat(user_id).."\n**Motivo:** "..reason.."\n**Horário:** "..os.date("%H:%M:%S"),3092790)

		--[[local dataTable = CORE.getDatatable(user_id)
		if dataTable then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			dataTable["armour"] = GetPedArmour(ped)
			dataTable["health"] = GetEntityHealth(ped)
			dataTable["position"] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]) }

			TriggerEvent("playerDisconnect",user_id,source)
			CORE.execute("accountsData/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(dataTable) })
			CORE.userSources[user_id] = nil
			CORE.userTables[user_id] = nil
			CORE.userInfos[user_id] = nil
			CORE.userIds[source] = nil
		end]]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERCONNECTING ]]
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("Queue:playerConnecting",function(source,identifiers,deferrals)
	local steam = CORE.getIdentities(source)
	local discord = CORE.getPlayerDiscord(source)
	if steam then
		local infoAccount = CORE.infoAccount(steam)
		if infoAccount then
			deferrals.done()
		else
			CORE.execute("accountsMain/newAccount",{ steam = steam, discord = discord })
			deferrals.done()
		end
	else
		deferrals.done("Conexão perdida com a Steam.")
	end

	TriggerEvent("Queue:removeQueue",identifiers)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CHARACTERCHOSEN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[function vRP.characterChosen(source,user_id,model,locate)
	vRP.userIds[source] = user_id
	vRP.userSources[user_id] = source
	local identity = vRP.userIdentity(user_id)
	vRP.userTables[user_id] = vRP.userData(user_id,"Datatable")

	if model ~= nil then
		vRP.userTables[user_id]["inventory"] = {}
		vRP.generateItem(user_id,"reais",1700,false)
		vRP.generateItem(user_id,"agua",3,false)
		vRP.generateItem(user_id,"chocolate",3,false)
		vRP.userTables[user_id]["skin"] = GetHashKey(model)
		vRP.generateItem(user_id,"identity-"..user_id,1,false)

		if locate == "Sul" then
			vRP.userTables[user_id]["position"] = { x = -28.08, y = -145.96, z = 56.99 }
		else
			vRP.userTables[user_id]["position"] = { x = 1935.59, y = 3721.93, z = 32.87 }
		end
	end

	local userBank = vRP.userBank(user_id,"Private")
	if userBank then
		vRP.userInfos[user_id]["bank"] = userBank["value"]
	end

	local infoAccount = vRP.infoAccount(identity["steam"])
	if infoAccount then
		vRP.userInfos[user_id]["premium"] = infoAccount["premium"]
		vRP.userInfos[user_id]["chars"] = infoAccount["chars"]

		TriggerEvent("discordLogs","Connect","**Passaporte:** "..user_id.." | "..identity["name"].." "..identity["name2"].."\n**IP:** "..GetPlayerEndpoint(source).."\n**Horário:** "..os.date("%H:%M:%S \n**DATA:** %d/%m/%Y"),3092790)

	end

	local Identities = vRP.getIdentities(source)
	if Identities ~= identity["steam"] then
		vRP.kick(user_id,"Expulso da cidade.")
	end

	TriggerEvent("playerConnect",user_id,source)
end]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADSERVER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetGameType("Battle Royale")
	SetMapName("Warzone 5M")
	--SetRoutingBucketEntityLockdownMode(0,"relaxed")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ADMIN:PRINT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("Print")
AddEventHandler("Print",function(message)
	local source = source
	local user_id = CORE.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Hackers","Passaporte **"..user_id.."** "..message..".",3092790)
	end
end)