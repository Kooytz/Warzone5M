-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CORE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
CORE = Proxy.getInterface("wz-core")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ CONNECTION ]]
-----------------------------------------------------------------------------------------------------------------------------------------

WZ = {}
Tunnel.bindInterface("wz-login",WZ)
WZClient = Tunnel.getInterface("wz-login")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ LOGIN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE.prepare("accountsBanneds/bannedTime","SELECT * FROM accounts_banneds WHERE steam = @steam")

function WZ.Login()
	local source = CORE.loginSource()
	local steam = CORE.getIdentities(source)
	if steam then
		if not CORE.checkBanned(steam) then
			print("não está banido")
			--local infoAccount = CORE.infoAccount(steam)
			--if infoAccount then
			--	if infoAccount["whitelist"] then
			--		print("Concluído: Obter dados de perfil")
			--	else
			--		print("Tela de login")
			--	end
			--else
			--	print("Error: Ocorreu um problema ao obter dados de perfil.")
			--end
		else
			local timeCheck = CORE.query("accountsBanneds/bannedTime",{ steam = steam })
			print(timeCheck)
			return timeCheck
		end
	else
		print("Error: Conexão perdida com a steam.")
	end
end



































-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERCONNECT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local playerConnect = function(user_id,source)
	Player(source).state.played = os.time()
end

AddEventHandler("playerConnect",playerConnect)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERDISCONNECT ]]
-----------------------------------------------------------------------------------------------------------------------------------------

--[[local playerDisconnect = function(user_id,source)
	local timer = os.time() - Player(source).state.played
	vRP.execute("characters/savePlayed", { id = user_id, played = timer })
end

AddEventHandler("playerDisconnect",playerDisconnect)]]