-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CORE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local Tunnel = module("wz-core","lib/Tunnel")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CONNECTION ]]
-----------------------------------------------------------------------------------------------------------------------------------------

WZ = {}
Tunnel.bindInterface("wz-login",WZ)
WZServer = Tunnel.getInterface("wz-login")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ VARIABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local banReason = ""

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ONCLIENTRESOURCESTART ]]
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("onClientResourceStart",function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

-- VEM UMAS COISAS NATES DO CHAT, VERIFICAR LÁ

	Citizen.Wait(1000)

	SendNUIMessage({ action = "Connect" })
	ShutdownLoadingScreenNui()

	Citizen.Wait(6000)

	SendNUIMessage({ action = "Update" })

	Citizen.Wait(3000)

	TriggerServerEvent("Queue:playerConnect")
	ShutdownLoadingScreen()
	SendNUIMessage({ action = "GetProfile" })

	Citizen.Wait(3000)

	local loginType = WZServer.Login()

	if loginType[1] == "banned" then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "BanScreen" })

		if loginType[2] > 1000 then
			banReason = "Conta banida permanentemente. Para mais informações, acesse https://discord.gg/colocar-link-do-discord."
		else
			banReason = "Conta banida por "..loginType[2].." dias. Para mais informações, acesse https://discord.gg/colocar-link-do-discord."
		end
	elseif loginType == "noAccountFounded" then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "noAccountScreen" })
	end

-- AQUI QUE VAI ADICIONAR O NOVO PERSONAGEM STEAM DA PESSOA CASO NÃO TENHA / VERIFICAR SE JÁ TEM CONTA

-- COLOCAR FUNC DE MUDAR DE BUCKET
-- COLOCAR MESMA INTERFACE DA LOAD PRA ENTRAR APÓS A LOAD = Obtendo perfil online


-- Em andamento: Obtendo informações da loja
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ QUIT BUTTON ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("quitButton",function()
	WZServer.LoginDrop(banReason)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ INFO BAN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("infoBan",function(data,cb)
	cb({banReason = banReason})
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ SIGN UP BUTTON ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("signUpButton",function()
end)