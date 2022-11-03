-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERSPAWN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerConnect",function(user_id,source)
	local dataTable = CORE.getDatatable(user_id)
	if dataTable then
		if dataTable["position"] then
			if dataTable["position"]["x"] == nil or dataTable["position"]["y"] == nil or dataTable["position"]["z"] == nil then
				dataTable["position"] = { x = -25.85, y = -147.48, z = 56.95 } -- SETAR POSIÇÃO DO LOBBY
			end
		else
			dataTable["position"] = { x = -25.85, y = -147.48, z = 56.95 }  -- SETAR POSIÇÃO DO LOBBY
		end

		CORE.teleport(source,dataTable["position"]["x"],dataTable["position"]["y"],dataTable["position"]["z"])

		if dataTable["skin"] == nil then
			dataTable["skin"] = GetHashKey("s_m_y_marine_02")
		end

		--[[if dataTable["weight"] == nil then
			dataTable["weight"] = 5
		end

		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end]]

		if dataTable["health"] == nil then
			dataTable["health"] = 200
		end

		if dataTable["armour"] == nil then
			dataTable["armour"] = 34
		end

		if dataTable["permission"] then
			dataTable["permission"] = nil
		end

		CORECLIENT.applySkin(source,dataTable["skin"])
		CORE.setArmour(source,dataTable["armour"])
		CORECLIENT.setHealth(source,dataTable["health"])

		local identity = CORE.userIdentity(user_id)
		if identity then
			TriggerClientEvent("playerActive",source,user_id,identity["name"])
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ TRYDELETEPEDADMIN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("tryDeletePedAdmin")
AddEventHandler("tryDeletePedAdmin",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex[1])
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ TRYDELETEOBJECT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("tryDeleteObject")
AddEventHandler("tryDeleteObject",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ TRYDELETEPED ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("tryDeletePed")
AddEventHandler("tryDeletePed",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ /GG ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[RegisterCommand("gg",function(source,args,rawCommand)
	if exports["hz-chat"]:statusChat(source) then
		local user_id = CORE.getUserId(source)
		if user_id and CORECLIENT.checkDeath(source) then
			CORECLIENT.respawnPlayer(source)

			local dataTable = CORE.getDatatable(user_id)
			if dataTable["inventory"] then
				dataTable["inventory"] = {}
				CORE.upgradeThirst(user_id,100)
				CORE.upgradeHunger(user_id,100)
				CORE.downgradeStress(user_id,100)
			end

			TriggerEvent("inventory:clearWeapons",user_id)
			TriggerClientEvent("dynamic:animalFunctions",source,"deletar")
			TriggerEvent("discordLogs","Airport","**Passaporte:** "..parseFormat(user_id).."\n**Horário:** "..os.date("%H:%M:%S"),3092790)
		end
	end
end)]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETHEALTH ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.getHealth(source)
	local ped = GetPlayerPed(source)
	return GetEntityHealth(ped)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ MODELPLAYER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.modelPlayer(source)
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("s_m_y_marine_02") then
		return "s_m_y_marine_02"
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ SETARMOUR ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.setArmour(source,amount)
	local ped = GetPlayerPed(source)
	local armour = GetPedArmour(ped)

	SetPedArmour(ped,parseInt(armour + amount))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ TELEPORT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.teleport(source,x,y,z)
	local ped = GetPlayerPed(source)
	SetEntityCoords(ped,x + 0.0001,y + 0.0001,z + 0.0001,0,0,0,0)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CREATEOBJECT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.CreateObject(model,x,y,z)
	local spawnObjects = 0
	local mHash = GetHashKey(model)
	local Object = CreateObject(mHash,x,y,z,true,true,false)

	while not DoesEntityExist(Object) and spawnObjects <= 1000 do
		spawnObjects = spawnObjects + 1
		Citizen.Wait(1)
	end

	if DoesEntityExist(Object) then
		return true,NetworkGetNetworkIdFromEntity(Object)
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CREATEPED ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.CreatePed(model,x,y,z,heading,typ)
	local spawnPeds = 0
	local mHash = GetHashKey(model)
	local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)

	while not DoesEntityExist(Ped) and spawnPeds <= 1000 do
		spawnPeds = spawnPeds + 1
		Citizen.Wait(1)
	end

	if DoesEntityExist(Ped) then
		return true,NetworkGetNetworkIdFromEntity(Ped)
	end

	return false
end