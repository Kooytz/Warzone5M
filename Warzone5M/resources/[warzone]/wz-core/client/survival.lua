-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ VARIABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[local timeDeath = 600
local ropeCarry = false
local deathStatus = false
local emergencyButton = false
local invincibles = true
local invTimer = GetGameTimer() + 60000]]

LocalPlayer["state"]["Active"] = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERACTIVE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("playerActive")
AddEventHandler("playerActive",function(user_id,name)
	LocalPlayer["state"]["Active"] = true

	SetDiscordAppId(686718089609740372)
	SetDiscordRichPresenceAsset("logo1")
	SetRichPresence(name.."#"..user_id)
	SetDiscordRichPresenceAssetSmall("Warzone 5M")
	SetDiscordRichPresenceAssetText("discord.gg/ckZA57EQb4")
	SetDiscordRichPresenceAssetSmallText("Warzone 5M")
	--SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/ckZA57EQb4")
	--SetDiscordRichPresenceAction(1, "Instagram", "https://www.instagram.com/hellzonerp/")

	--[[local pid = PlayerId()
	local ped = PlayerPedId()

	SetEntityInvincible(ped,true)
	FreezeEntityPosition(ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped,true,false)

	SetRadarZoom(1100)
	SetPedHelmet(ped,false)
	SetDeepOceanScaler(0.0)
	SetRandomEventFlag(false)
	SetPlayerTargetingMode(2)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	SetWeaponsNoAutoreload(true)
	SetPlayerCanUseCover(pid,false)
	SetPedSteersAroundPeds(ped,true)
	DisableVehicleDistantlights(true)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(ped,false)
	SetPedCanLosePropsOnDamage(ped,false,0)
	SetPedCanBeKnockedOffVehicle(ped,false)
	SetPedCanRagdollFromPlayerImpact(ped,false)

	SetPedConfigFlag(ped,2,true)
	SetPedConfigFlag(ped,48,true)
	SetPedConfigFlag(ped,33,false)

	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)

	AddTextEntry("FE_THDR_GTAO","~r~Hellzone Roleplay ~w~- O seu servidor de RP ~r~imersivo~w~.")]]
end)