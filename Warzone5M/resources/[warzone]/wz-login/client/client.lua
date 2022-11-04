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

	TriggerServerEvent("Queue:playerConnect")
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()

	-- COLOCAR FUNC DE MUDAR DE BUCKET
	-- COLOCAR MESMA INTERFACE DA LOAD PRA ENTRAR APÓS A LOAD = Obtendo perfil online


	-- test
	SendNUIMessage({ action = "GetProfile" })
end)