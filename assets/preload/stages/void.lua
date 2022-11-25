
function onCreate()

	makeLuaSprite('bg', 'Ender/Void', -2500, -700)
	scaleObject('bg', 2.5, 2.5)
	addLuaSprite('bg', false)
	setProperty('bg.antialiasing', false)

end
function onCountdownTick(counter)
	if counter == 3 then
		setProperty('introSoundsSuffix', 'introGo_weird') 
		playSound('introGo_weird', 1)
	end
end
function onCreatePost()
	local username = os.getenv('USERNAME')
	setProperty('healthBar.visible',false)
	setProperty('ghudsong.y', 675)
	makeLuaText('warning', "You won't Survive "..username..", You Fucking Bitch.", 0, 2, 695)
	setTextBorder("warning", 1.8, '000000')
	setTextAlignment('warning', 'LEFT')
	setTextFont('warning', 'COMIC.TTF')
	setTextSize('warning', 18)
	addLuaText('warning')

end
fr = 0
function onUpdate(elapsed)
	fr = fr + elapsed

	setProperty('dad.x', 720 + math.sin(fr*1.5) * -960);
end

function onEvent(n,v1,v2)
	if n == 'Set Cam Zoom' then
		if v1 == '0.8' then
			doTweenAlpha('begonebf','boyfriend',0,2,'linear')
			doTweenAlpha('begonegf','gf',0,2,'linear')
		end
		if v1 == '0.5' then
			doTweenAlpha('hellobf','boyfriend',1,0.5,'linear')
			doTweenAlpha('hellogf','gf',1,0.5,'linear')
		end
	end
end