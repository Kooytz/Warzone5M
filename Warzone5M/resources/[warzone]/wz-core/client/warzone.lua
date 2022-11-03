-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ DISPATCH ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	for i = 1,25 do
		EnableDispatchService(i,false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADTIMERS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
	while true do
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
		SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("frogger"),true)
		SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetVehicleModelIsSuppressed(GetHashKey("ambulance"),true)
		SetVehicleModelIsSuppressed(GetHashKey("stunt"),true)
		SetVehicleModelIsSuppressed(GetHashKey("cargobob"),true)
		SetVehicleModelIsSuppressed(GetHashKey("rhino"),true)
		SetVehicleModelIsSuppressed(GetHashKey("lazer"),true)
		SetVehicleModelIsSuppressed(GetHashKey("titan"),true)
		SetVehicleModelIsSuppressed(GetHashKey("hydra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("firetruk"),true)
		SetVehicleModelIsSuppressed(GetHashKey("lguard"),true)
		SetVehicleModelIsSuppressed(GetHashKey("pbus"),true)
		SetVehicleModelIsSuppressed(GetHashKey("dump"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prismuscl_01"),true)
		SetPedModelIsSuppressed(GetHashKey("u_m_y_prisoner_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prisoner_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_m_prisguard_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_marine_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_marine_02"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_marine_03"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_m_marine_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_m_marine_02"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_armymech_01"),true)

		Citizen.Wait(1000)
	end
end)]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADTIMERS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.2)
		SetWeaponDamageModifierThisFrame("WEAPON_KNIFE",0.4)
		SetWeaponDamageModifierThisFrame("WEAPON_DAGGER",0.5)
		SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.3)
		SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.4)
		SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.3)
		SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.3)
		SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.6)
		SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.5)
		SetWeaponDamageModifierThisFrame("WEAPON_SWITCHBLADE",0.5)
		SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.3)
		SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.8)
		SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.3)
		SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.4)
		SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.2)
		SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.3)


		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		DisablePlayerVehicleRewards(PlayerId())
		ReplaceHudColour(116, 6)

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		DisableControlAction(1,37,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,157,true)
		DisableControlAction(1,158,true)
		DisableControlAction(1,159,true)
		DisableControlAction(1,160,true)
		DisableControlAction(1,161,true)
		DisableControlAction(1,162,true)
		DisableControlAction(1,163,true)
		DisableControlAction(1,164,true)
		DisableControlAction(1,165,true)

		SetParkedVehicleDensityMultiplierThisFrame(0.2)
		SetRandomVehicleDensityMultiplierThisFrame(0.2)
		SetVehicleDensityMultiplierThisFrame(0.2)
		SetGarbageTrucks(false)
		SetRandomBoats(false)

		ClearAreaOfPeds(1693.22, 2603.64, 45.56, 160 + 0.0, false, false, false, false) -- LIMPA PEDS PRESÍDIO

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			ClearPlayerWantedLevel(PlayerId())
		end

		Citizen.Wait(0)
	end
end)]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ OPENOBJECTS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			local distance = #(coords - vector3(254.01,225.21,101.87))
			if distance <= 3.0 then
				timeDistance = 1

				if IsControlJustPressed(1,38) then
					local handle,object = FindFirstObject()
					local finished = false

					repeat
						local heading = GetEntityHeading(object)
						local coordsObj = GetEntityCoords(object)
						local distanceObjs = #(coordsObj - coords)

						if distanceObjs < 3.0 and GetEntityModel(object) == 961976194 then
							if heading > 150.0 then
								SetEntityHeading(object,0.0)
							else
								SetEntityHeading(object,160.0)
							end

							FreezeEntityPosition(object,true)
							finished = true
						end

						finished,object = FindNextObject(handle)
					until not finished

					EndFindObject(handle)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ IPLOADER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[local ipList = {
	{
		props = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = { -1150.70,-1520.70,10.60 }
	},{
		props = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = { -47.10,-1115.30,26.50 }
	},{
		props = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = { -802.30,175.00,72.80 }
	}
}]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADIPLOADER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
	for _k,_v in pairs(ipList) do
		local interiorCoords = GetInteriorAtCoords(_v["coords"][1],_v["coords"][2],_v["coords"][3])
		LoadInterior(interiorCoords)

		if _v["props"] ~= nil then
			for k,v in pairs(_v["props"]) do
				EnableInteriorProp(interiorCoords,v)
				Citizen.Wait(1)
			end
		end

		RefreshInterior(interiorCoords)
	end
end)]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ INVISIBLABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

LocalPlayer["state"]["Invisible"] = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADHACKER ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()

			if not IsEntityVisible(ped) and not LocalPlayer["state"]["Invisible"] then
				TriggerServerEvent("Hacker","está invisível")
			end

			if ForceSocialClubUpdate == nil then
				TriggerServerEvent("Hacker","forçou a social club.")
			end

			if ShutdownAndLaunchSinglePlayerGame == nil then
				TriggerServerEvent("Hacker","entrou no modo single player.")
			end

			if ActivateRockstarEditor == nil then
				TriggerServerEvent("Hacker","ativou o rockstar editor.")
			end
		end

		Citizen.Wait(10000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ VARIABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local engineDelta = 0.0
local engineScaled = 0.0
local engineNew = 1000.0
local engineLast = 1000.0
local engineCurrent = 1000.0

local bodyDelta = 0.0
local bodyScaled = 0.0
local bodyNew = 1000.0
local bodyLast = 1000.0
local bodyCurrent = 1000.0

local lastVehicle = nil
local sameVehicle = false

local classDamage = { 1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.0,1.5,1.5,1.5,1.5,0.0,0.0,1.5,1.5,1.5,1.5,1.5,1.5,1.5 }

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADHEALTHVEH ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehClass = GetVehicleClass(vehicle)
			if vehClass ~= 13 and vehClass ~= 14 then
				timeDistance = 1

				if sameVehicle then
					local engineTorque = 1.0
					if engineNew < 900 then
						engineTorque = (engineNew + 200.0) / 1100
					end

					SetVehicleEngineTorqueMultiplier(vehicle,engineTorque)
				end

				if GetPedInVehicleSeat(vehicle,-1) == ped then
					local vehRoll = GetEntityRoll(vehicle)
					if vehRoll > 75.0 or vehRoll < -75.0 then
						DisableControlAction(1,59,true)
						DisableControlAction(1,60,true)
					end
				end

				engineCurrent = GetVehicleEngineHealth(vehicle)
				if engineCurrent >= 1000 then
					engineLast = 1000.0
				end

				engineNew = engineCurrent
				engineDelta = engineLast - engineCurrent
				engineScaled = engineDelta * 0.6 * classDamage[vehClass + 1]

				bodyCurrent = GetVehicleBodyHealth(vehicle)
				if bodyCurrent >= 1000 then
					bodyLast = 1000.0
				end

				bodyNew = bodyCurrent
				bodyDelta = bodyLast - bodyCurrent
				bodyScaled = bodyDelta * 0.6 * classDamage[vehClass + 1]

				if engineCurrent > 101.0 and bodyCurrent > 101.0 then
					SetVehicleUndriveable(vehicle,false)
				end

				if engineCurrent <= 101.0 or bodyCurrent <= 101.0 then
					SetVehicleUndriveable(vehicle,true)
				end

				if vehicle ~= lastVehicle then
					sameVehicle = false
				end

				if sameVehicle then
					if engineCurrent ~= 1000.0 or bodyCurrent ~= 1000.0 then
						local engineCombine = math.max(engineScaled,bodyScaled)
						if engineCombine > (engineCurrent - 100.0) then
							engineCombine = engineCombine * 0.7
						end

						if engineCombine > engineCurrent then
							engineCombine = engineCurrent - (210.0 / 5)
						end
						engineNew = engineLast - engineCombine

						if engineNew > 210.0 and engineNew < 350.0 then
							engineNew = engineNew - (0.038 * 7.4)
						end

						if engineNew < 210.0 then
							engineNew = engineNew - (0.1 * 1.5)
						end

						if engineNew < 100.0 then
							engineNew = 100.0
						end

						if bodyNew < 0 then
							bodyNew = 0.0
						end
					end
				else
					if bodyCurrent < 100.0 then
						bodyNew = 100.0
					end

					if engineCurrent < 100.0 then
						engineNew = 100.0
					end

					sameVehicle = true
				end

				if engineNew ~= engineCurrent then
					SetVehicleEngineHealth(vehicle,engineNew)
				end

				if bodyNew ~= bodyCurrent then
					SetVehicleBodyHealth(vehicle,bodyNew)
				end

				SetVehiclePetrolTankHealth(vehicle,1000.0)

				bodyLast = bodyNew
				engineLast = engineNew
				lastVehicle = vehicle
			end
		else
			sameVehicle = false
		end

		Citizen.Wait(timeDistance)
	end
end)
