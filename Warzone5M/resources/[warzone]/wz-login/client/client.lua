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
	print(variavel)

-- AQUI QUE VAI ADICIONAR UMA NOVA CONTA AO STEAM DA PESSOA CASO NÃO TENHA / VERIFICAR BANIMENTO / VERIFICAR SE JÁ TEM CONTA

	-- COLOCAR FUNC DE MUDAR DE BUCKET
	-- COLOCAR MESMA INTERFACE DA LOAD PRA ENTRAR APÓS A LOAD = Obtendo perfil online


	-- Em andamento: Obtendo informações da loja
end)