--- BIO

-- accounts_main = summerz_accounts
-- accounts_infos = summerz_characters
-- accounts_banneds = summerz_banneds
-- accounts_data = summerz_playerdata

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ACCOUNTS MAIN ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE.prepare("accountsMain/getInfos","SELECT * FROM accounts_main WHERE steam = @steam")
CORE.prepare("accountsMain/newAccount","INSERT INTO accounts_main(steam, discord) VALUES(@steam, @discord)")
CORE.prepare("accountsMain/updateWhitelist","UPDATE accounts_main SET whitelist = 0 WHERE steam = @steam")
CORE.prepare("accountsMain/removeGems","UPDATE accounts_main SET gems = gems - @gems WHERE steam = @steam")
CORE.prepare("accountsMain/setPriority","UPDATE accounts_main SET priority = @priority WHERE steam = @steam")
CORE.prepare("accountsMain/infosUpdategems","UPDATE accounts_main SET gems = gems + @gems WHERE steam = @steam")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ACCOUNTS INFOS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE.prepare("accountsInfos/getUsers","SELECT * FROM accounts_infos WHERE id = @id")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ ACCOUNTS BANNEDS ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE.prepare("accountsBanneds/getBanned","SELECT * FROM accounts_banneds WHERE steam = @steam")
CORE.prepare("accountsBanneds/removeBanned","DELETE FROM accounts_banneds WHERE steam = @steam")
CORE.prepare("accountsBanneds/insertBanned","INSERT INTO accounts_banneds(steam,time) VALUES(@steam,@time)")
CORE.prepare("accountsBanneds/getTimeBanned","SELECT * FROM accounts_banneds WHERE steam = @steam AND (DATEDIFF(CURRENT_DATE,time) >= time)")
CORE.prepare("accountsBanneds/bannedTime","SELECT time FROM accounts_banneds WHERE steam = @steam")

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ PLAYERDATA ]]
-----------------------------------------------------------------------------------------------------------------------------------------

CORE.prepare("accountsData/getUserdata","SELECT dvalue FROM accounts_data WHERE user_id = @user_id AND dkey = @key")
CORE.prepare("accountsData/setUserdata","REPLACE INTO accounts_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")