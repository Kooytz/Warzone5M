-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ VARIABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local uObject = nil
local uPoint = false
local animDict = nil
local animName = nil
local crouch = false
local walkSelect = nil
local animActived = false
local cdBtns = GetGameTimer()

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ LOCALPLAYERS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

LocalPlayer["state"]["Cancel"] = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CANCEL ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Cancel")
AddEventHandler("Cancel",function(status)
	LocalPlayer["state"]["Cancel"] = status
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADCANCEL ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] then
			timeDistance = 1
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,38,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADMUMBLECONNECT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if not MumbleIsConnected() then
			timeDistance = 1
			DisableControlAction(1,38,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,47,true)
            -- colocar evento de tela bloqueando o jogador caso desconecte o voip
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ LOADANIMSET ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.loadAnimSet(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CREATEOBJECTS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.createObjects(newDict,newAnim,newProp,newFlag,newHands,newHeight,newPos1,newPos2,newPos3,newPos4,newPos5)
	if DoesEntityExist(uObject) then
		TriggerServerEvent("tryDeleteObject",ObjToNet(uObject))
		uObject = nil
	end

	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if newAnim ~= "" then
		tCORE.loadAnimSet(newDict)
		TaskPlayAnim(ped,newDict,newAnim,3.0,3.0,-1,newFlag,0,0,0,0)

		animActived = true
		animFlags = newFlag
		animDict = newDict
		animName = newAnim
	end

	local myObject,objNet = CORESERVER.CreateObject(newProp,coords["x"],coords["y"],coords["z"])
	if myObject then
		local spawnObjects = 0
		uObject = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(uObject) and spawnObjects <= 1000 do
			uObject = NetworkGetEntityFromNetworkId(objNet)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		spawnObjects = 0
		local objectControl = NetworkRequestControlOfEntity(uObject)
		while not objectControl and spawnObjects <= 1000 do
			objectControl = NetworkRequestControlOfEntity(uObject)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		if newHeight then
			AttachEntityToEntity(uObject,ped,GetPedBoneIndex(ped,newHands),newHeight,newPos1,newPos2,newPos3,newPos4,newPos5,true,true,false,true,1,true)
		else
			AttachEntityToEntity(uObject,ped,GetPedBoneIndex(ped,newHands),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		end

		SetEntityAsNoLongerNeeded(uObject)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADANIM ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if animActived and LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if not IsEntityPlayingAnim(ped,animDict,animName,3) then
				TaskPlayAnim(ped,animDict,animName,3.0,3.0,-1,animFlags,0,0,0,0)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ REMOVEOBJECTS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.removeObjects(status)
	if status == "one" then
		tCORE.stopAnim(true)
	elseif status == "two" then
		tCORE.stopAnim(false)
	else
		tCORE.stopAnim(true)
		tCORE.stopAnim(false)
	end

	animActived = false
	TriggerEvent("camera")
	TriggerEvent("binoculos")
	if DoesEntityExist(uObject) then
		TriggerServerEvent("tryDeleteObject",ObjToNet(uObject))
		uObject = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ POINT ]] --OBSERVAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		if uPoint and LocalPlayer["state"]["Active"] then
			timeDistance = 1
			local ped = PlayerPedId()
			local camPitch = GetGameplayCamRelativePitch()

			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local nn = 0
			local blocked = 0
			local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords["x"],coords["y"],coords["z"]-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Pitch",camPitch)
			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Heading",camHeading * -1.0 + 1.0)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isBlocked",blocked)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ AGACHAR ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("crouch",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(ped) then	
            RequestAnimSet("move_ped_crouched")
            while not HasAnimSetLoaded("move_ped_crouched") do
                Citizen.Wait(1)
            end

            if crouch then
                ResetPedMovementClipset(ped,0.25)
                crouch = false

                if walkSelect ~= nil then
                    RequestAnimSet(walkSelect)
                    while not HasAnimSetLoaded(walkSelect) do
                        Citizen.Wait(1)
                    end

                    SetPedMovementClipset(ped,walkSelect,0.25)
                end
            else
                SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                crouch = true
            end
			
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ BIND ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("bind",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(ped) then
			if parseInt(args[1]) >= 1 and parseInt(args[1]) <= 5 then
				TriggerServerEvent("inventory:useItem",args[1],1)
            end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ KEYMAPPING ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterKeyMapping("crouch","Agachar","keyboard","Z")

RegisterKeyMapping("bind 1","Interação do botão 1","keyboard","1")
RegisterKeyMapping("bind 2","Interação do botão 2","keyboard","2")
RegisterKeyMapping("bind 3","Interação do botão 3","keyboard","3")
RegisterKeyMapping("bind 4","Interação do botão 4","keyboard","4")
RegisterKeyMapping("bind 5","Interação do botão 5","keyboard","5")
RegisterKeyMapping("bind 6","Interação do botão 6","keyboard","6")
RegisterKeyMapping("bind 7","Interação do botão 7","keyboard","7")
RegisterKeyMapping("bind 8","Interação do botão 8","keyboard","8")
RegisterKeyMapping("bind 9","Interação do botão 9","keyboard","9")