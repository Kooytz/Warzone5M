-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERIDENTITY ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.userIdentity(user_id)
	if CORE.userSources[user_id] then
		if CORE.userInfos[user_id] == nil then
			local identity = CORE.query("accountsInfos/getUsers",{ id = user_id })
			CORE.userInfos[user_id] = {}
			CORE.userInfos[user_id]["id"] = identity[1]["id"]
			CORE.userInfos[user_id]["name"] = identity[1]["name"]
			CORE.userInfos[user_id]["steam"] = identity[1]["steam"]
		end

		return CORE.userInfos[user_id]
	else
		local identity = CORE.query("accountsInfos/getUsers",{ id = user_id })
		return identity[1] or false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ USERGEMSTONE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.userGemstone(steam)
	local infoAccount = CORE.infoAccount(steam)
	return infoAccount["gems"] or 0
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ UPGRADEGEMSTONE ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function CORE.upgradeGemstone(user_id,amount)
	CORE.execute("accountsMain/infosUpdategems",{ steam = CORE.userInfos[user_id]["steam"], gems = amount })
end