-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ VARIABLES ]]
-----------------------------------------------------------------------------------------------------------------------------------------

local noclip = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ NOCLIP ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.noClip()
	noclip = not noclip
	local ped = PlayerPedId()

	if noclip then
		LocalPlayer["state"]["Invisible"] = true
		SetEntityInvincible(ped,true)
		SetEntityVisible(ped,false,false)
		TriggerEvent("Notify","sucesso","<b>NoClip:</b> Ativado.",5000)
	else
		LocalPlayer["state"]["Invisible"] = false
		SetEntityInvincible(ped,false)
		SetEntityVisible(ped,true,false)
		TriggerEvent("Notify","importante","<b>NoClip:</b> Desativado.",5000)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ THREADNOCLIP ]]
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local timeDistance = 999

		if noclip then
			timeDistance = 1
			local speed = 1.0
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local dx,dy,dz = tCORE.getCamDirection()

			SetEntityVelocity(ped,0.0001,0.0001,0.0001)

			if IsControlPressed(1,21) then
				speed = 5.0
			end

			if IsControlPressed(1,32) then
				x = x + speed * dx
				y = y + speed * dy
				z = z + speed * dz
			end

			if IsControlPressed(1,269) then
				x = x - speed * dx
				y = y - speed * dy
				z = z - speed * dz
			end

			if IsControlPressed(1,10) then
				z = z + 0.5
			end

			if IsControlPressed(1,11) then
				z = z - 0.5
			end

			SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [[ GETCAMDIRECTION ]]
-----------------------------------------------------------------------------------------------------------------------------------------

function tCORE.getCamDirection()
	local ped = PlayerPedId()
	local pitch = GetGameplayCamRelativePitch()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(ped)
	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi / 180.0)
	local len = math.sqrt(x*x + y*y + z*z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end

	return x,y,z
end