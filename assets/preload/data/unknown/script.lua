--[[
	The chart took me like almost a week to do.

	I hate when people miss or try to fucking cheat.
		~ Unknown
]]--

function onCreate()
	setProperty('debugKeysChart', null)
	setProperty('skipCountdown', true)
	setProperty('watermark.text', 'Unknown (TOMFUCKERY) | FUCK YOU, BYE')
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-unknown-dead')
end

function noteMiss() -- DONE
	restartSong(true)
end

function onUpdate()
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') or
	keyJustPressed('escape') then
		restartSong(true)
	end
end