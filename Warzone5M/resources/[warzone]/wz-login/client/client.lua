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

local kickdrop = ""

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
		print(loginType[1], loginType[2])
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "BanScreen" })

		if loginType[2] > 1000 then
			kickdrop = "Conta banida permanentemente. Para mais informações acesse: https://discord.gg/colocar-link-do-discord."
		else
			kickdrop = "Conta banida por "..loginType[2].." dias. Para mais informações acesse: https://discord.gg/colocar-link-do-discord."
		end

		-- AQUI VIRÁ A TELA DE BANIDO + O TEMPO DO BANIMENTO
	end

-- AQUI QUE VAI ADICIONAR UMA NOVA CONTA AO STEAM DA PESSOA CASO NÃO TENHA / VERIFICAR BANIMENTO / VERIFICAR SE JÁ TEM CONTA

-- COLOCAR FUNC DE MUDAR DE BUCKET
-- COLOCAR MESMA INTERFACE DA LOAD PRA ENTRAR APÓS A LOAD = Obtendo perfil online


-- Em andamento: Obtendo informações da loja
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ QUIT BUTTON ]]
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("quitButton",function()
	WZServer.LoginDrop(kickdrop)
end)