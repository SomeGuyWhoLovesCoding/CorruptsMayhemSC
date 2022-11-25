local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and getPropertyFromClass('ClienfPrefs', 'cursing') then
		startVideo('empty');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;

	-- This went fucking unused, I would rather keep it as one instead of two since lua is annoying.

	--[[if not allowCountdown and not getPropertyFromClass('ClienfPrefs', 'cursing') then
		startVideo('empty_noSwear');
		allowCountdown = true;
		return Function_Stop;
		end
	end]]--
end