-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CORE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local Tunnel = module("wz-core","lib/Tunnel")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CONNECTION ]]
-----------------------------------------------------------------------------------------------------------------------------------------

WZ = {}
Tunnel.bindInterface("wz-login",WZ)
CORESERVER = Tunnel.getInterface("wz-login")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ONCLIENTRESOURCESTART ]]
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("onClientResourceStart",function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	-- VEM UMAS COISAS NATES DO CHAT, VERIFICAR LÁ

	Citizen.Wait(1000)

	SendNUIMessage({ action = "Connect" }) -- Conectando-se com os servidores online

	--Citizen.Wait(9000)

	--SendNUIMessage({ action = "Update" }) -- Verificando atualização...

	SetNuiFocus(true,true)
	TriggerServerEvent("Queue:playerConnect")
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()

	-- COLOCAR FUNC DE MUDAR DE BUCKET
	-- COLOCAR MESMA INTERFACE DA LOAD PRA ENTRAR APÓS A LOAD = Obtendo perfil online


	-- Em andamento: Obtendo informações da loja
end)